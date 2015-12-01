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
    
    self.jsExt = [JSExtension sharedInstance];
    self.jsExt.vc = self;
    
    [self.view  setBackgroundColor:[UIColor lightGrayColor]];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    
    //http://192.168.0.119/main   http://www.juhuaba.com
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.juhuaba.com"]];
    [self.view addSubview: _webView];
    [_webView loadRequest:request];
    [_webView setDelegate:self];
    
   }

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    NSString *requestString = [[request URL] absoluteString];//获取请求的绝对路径.
//    NSArray *components = [requestString componentsSeparatedByString:@":"];//提交请求时候分割参数的分隔符
//    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"testapp"]) {
//        //过滤请求是否是我们需要的.不需要的请求不进入条件
//        if([(NSString *)[components objectAtIndex:1] isEqualToString:@"alert"])
//        {
//            NSString *message = (NSString *)[components objectAtIndex:2];
//            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"JS向APP提交数据" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [alert show];
//        }
//        return NO;
//    }
//    return YES;
//}

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
                
                /*调用本地函数1*/
                NSLog(@"doFunc1");
                
            }
        }
        else
        {
            //有参数的
            if([funcStr isEqualToString:@"getParam1:withParam2:"])
            {
                [self getParam1:[arrFucnameAndParameter objectAtIndex:1] withParam2:[arrFucnameAndParameter objectAtIndex:2]];
            }
        }
        return NO;
    }
    return TRUE;
}


-(void)getParam1:(NSString*)str1 withParam2:(NSString*)str2
{
    NSLog(@"收到html传过来的参数：str1=%@,str2=%@",str1,str2);
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"getMessageFromApp('%@')", @"加载结束调用方法"]];
 
    // get JSContext from UIWebView instance
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // enable error logging
    [context setExceptionHandler:^(JSContext *context, JSValue *value) {
        NSLog(@"WEB JS: %@", value);
    }];
    
    context[@"myJSExt"] = self.jsExt;  // 注册给叫myJSExt的js变量，供JS调用
    
    // add function for processing form submission
    NSString *addContactText =
    @"var appPay = function(type, targetID, payChannel) {" // 给网页添加一个叫addContact()的JS函数
    "    myJSExt.appPayWithTypeTargetIDPayChannelPayPwd(type, targetID, payChannel, '');"  // JS调用了上面注册的OC变量的实例方法
    "};";

    [context evaluateScript:addContactText];
}

/**
 *  js调这个方法
 *  模拟一下这三个参数
 */
- (void)appPay:(NSString *)type elem1:(NSString *)elem1 elem2:(NSString *)elem2 elem3:(NSString *)elem3{
    
    //请求支付 获得charge对象
    NSString *url = @"http://api.juhuaba.com/api/payment/pay";
    
    
    /**
     *  用NSmutableURLRequest拼接参数
        用post方式，传三个参数。
     */
    
    
//    window.orange.appPay();
    
    NSLog(@"%s",__func__);
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.juhuaba.com"]];
    [_webView loadRequest:request];
    /**
     *  OVer
     */
}

//[Pingpp createPayment:charge
//       viewController:viewController
//         appURLScheme:kUrlScheme
//       withCompletion:^(NSString *result, PingppError *error) {
//           if ([result isEqualToString:@"success"]) {
//               // 支付成功
//           } else {
//               // 支付失败或取消
//               NSLog(@"Error: code=%lu msg=%@", error.code, [error getMsg]);
//           }
//       }];

// js 方法名
//- payCallBack{
//    
//}

- (void)requestForCharge
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"tradeType"] = self.jsExt.type ? : @"";
    params[@"targetId"] = self.jsExt.targetID ? : @"";
    params[@"payChannel"] = self.jsExt.payChannel ? : @"";
    params[@"payPwd"] = self.jsExt.payPwd ? : @"";
    
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    
    [manager POST:@"http://api.juhuaba.com/api/payment/pay" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [indicator stopAnimating];
        NSLog(@"JSON: %@", responseObject);
        if (operation.response.statusCode == 200) {
            
             NSLog(@"__func__");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [Pingpp createPayment:responseObject
                       viewController:self
                         appURLScheme:@"juhuaDevelop"
                       withCompletion:^(NSString *result, PingppError *error) {
                           [self handlePaymentResult:result error:error];
                       }];
            });
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [indicator stopAnimating];
        NSLog(@"Error: %@", error);
        [MBProgressHUD showError:@"网络请求失败"];
    }];
    [indicator startAnimating];
}

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
