//
//  ViewController.m
//  juhua
//
//  Created by 乔耐 on 15/10/21.
//  Copyright (c) 2015年 juzi. All rights reserved.


#import "ViewController.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "Pingpp.h"
#import "AppDelegate.h"
@import JavaScriptCore;
#import "JSExtension.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"

@interface ViewController ()

@property (nonatomic, strong) JSExtension *jsExt;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //#ifdef DEBUG
    //    // 每次回前台，发送假数据测试能否拿到charge
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testGetCharge) name:@"applicationDidBecomeActive" object:nil];
    //#endif
    
    self.jsExt = [JSExtension sharedInstance];
    self.jsExt.vc = self;
    
    [self.view  setBackgroundColor:[UIColor lightGrayColor]];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,20, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)- 20)];
    
    //http://192.168.0.119/main   http://www.juhuaba.com
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.juhuaba.com"]];
    [self.view addSubview: _webView];
    [_webView loadRequest:request];
    [_webView setDelegate:self];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}





// 测试获取charge
//- (void)testGetCharge
//{
////    [MBProgressHUD showMessage:@"测试charge"];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [MBProgressHUD hideHUD];
//
//        [self requestForChargeWithToken:@"token" targetID:@"targetID" tradeType:@"TRADE_CONSUME" payChannel:@"ALIPAY" payPwd:@"nil"];
////        [self requestForChargeWithTargetID:@"2015120209116057" tradeType:@"TRADE_CONSUME" payChannel:@"ALIPAY" payPwd:@"nil"];
//
//    });
//
//}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //注
    NSString *urlString = [[request URL] absoluteString];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"urlString=%@",urlString);
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    
    if([urlComps count] && [[urlComps objectAtIndex:0] isEqualToString:@"objc"])
    {
        
        NSArray *arrFucnameAndParameter = [(NSString*)[urlComps objectAtIndex:1] componentsSeparatedByString:@":/"];
        NSString *funcStr = [arrFucnameAndParameter objectAtIndex:0];
        
        if (1 == [arrFucnameAndParameter count])
        {
            // 没有参数
            if([funcStr isEqualToString:@"doFunc1"])
            {
                
                // 调用本地函数1
                NSLog(@"doFunc1");
                
            }
        }
        else
        {
            //有参数的
            if([funcStr isEqualToString:@"getParam1:withParam2:"])
            {
            }
        }
        return NO;
    }
    //注
    return TRUE;
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    // get JSContext from UIWebView instance
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // enable error logging
    [context setExceptionHandler:^(JSContext *context, JSValue *value) {
        NSLog(@"WEB JS: %@", value);
    }];
    
    context[@"appPay"] = ^() {
        
        NSArray *args = [JSContext currentArguments];
#ifdef DEBUG
        NSLog(@"Begin Log");
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal);
            // 1.targetID 2. 日期 3.payChannel 4. tradeType
        }
        NSLog(@"-------End Log-------");
#endif
        // 这样写有...
        if (args.count >= 4) {
            NSString *token = [args[0] toString];
            NSString *targetID = [args[1] toString];
            NSString *payChannel = [args[2] toString];
            NSString *tradeType = [args[3] toString];
            //            [self requestForChargeWithTradeType:tradeType targetID:targetID payChannel:payChannel payPwd:nil];
            [self requestForChargeWithToken:token targetID:targetID tradeType:tradeType payChannel:payChannel payPwd:nil];
        } else {
            NSLog(@"invalid payment args");
            [MBProgressHUD showError:@"订单参数错误，请稍后重试"];
        }
    };
}


// 用JS传递的参数向服务器请求charge
//- (void)requestForChargeWithTradeType:(NSString *)tradeType targetID:(NSString *)targetID payChannel:(NSString *)payChannel payPwd:(NSString *)payPwd
- (void)requestForChargeWithToken:(NSString *)token targetID:(NSString *)targetID tradeType:(NSString *)tradeType payChannel:(NSString *)payChannel payPwd:(NSString *)payPwd
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"tradeType"] = tradeType ? : @"";
    params[@"targetId"] = targetID ? : @"";
    params[@"payChannel"] = payChannel ? : @"";
    params[@"payPwd"] = payPwd ? : @"";
    
    [ manager.requestSerializer setValue:@"token" forHTTPHeaderField:@"x-auth-token"];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:@"http://api.juhuaba.com/api/payment/pay" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [indicator stopAnimating];
        NSLog(@"JSON: %@", responseObject);
        if (operation.response.statusCode == 200) {
            // 拿到charge,主线程调ping++
            dispatch_async(dispatch_get_main_queue(), ^{
                [Pingpp createPayment:responseObject
                       viewController:self
                         appURLScheme:@"wx22934c6eed622aac"
                       withCompletion:^(NSString *result, PingppError *error) {
                           [self handlePaymentResult:result error:error];
                       }];
            });
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [indicator stopAnimating];
        
        NSDictionary *responseDict = operation.responseObject;
        if ([responseDict isKindOfClass:[NSDictionary class]]) {
            NSString *msg = responseDict[@"message"];
            if (msg.length) {
                [MBProgressHUD showError:msg];
            } else {
                [MBProgressHUD showError:@"网络请求失败"];
            }
        } else {
            NSLog(@"Error: %@", error);
            [MBProgressHUD showError:@"网络请求失败"];
        }
    }];
    [indicator startAnimating];
}


// 处理ping++支付结果，通过JS返回给网页
- (void)handlePaymentResult:(NSString *)result error:(PingppError *)error
{
    if ([result isEqualToString:@"success"]) {
        [MBProgressHUD showSuccess:@"支付成功"];
        [_webView stringByEvaluatingJavaScriptFromString:@"payCallBack('success', '')"];
    } else if ([result isEqualToString:@"fail"]) {
        [MBProgressHUD showError:@"支付失败"];
        [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"payCallBack('invalid', '%@')", error.getMsg]];
    } else if ([result isEqualToString:@"cancel"]) {
        [MBProgressHUD showError:@"支付取消"];
        [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"payCallBack('cancel', '%@')", error.getMsg]];
    } else {
        [MBProgressHUD showError:@"支付遇到未知错误"];
        [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"payCallBack('unknown', '%@')", error.getMsg]];
    }
}

@end