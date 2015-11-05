//
//  JHRegisterViewController.m
//  JvHua
//
//  Created by 乔耐 on 15/11/4.
//  Copyright (c) 2015年 juzi. All rights reserved.
//

#import "JHRegisterViewController.h"
#import "JHLoginViewController.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#import "MyMD5.h"
#import "AESCrypt.h"


@interface JHRegisterViewController ()<UITextFieldDelegate>
//手机号
@property (weak, nonatomic) IBOutlet UITextField *user;
//验证码
@property (weak, nonatomic) IBOutlet UITextField *txtAuth;
//密码
@property (weak, nonatomic) IBOutlet UITextField *pwd1;
//确认密码
@property (weak, nonatomic) IBOutlet UITextField *pwd2;
//注册
@property (weak, nonatomic) IBOutlet UIButton *reg;

/** 获得的salt */
@property (copy, nonatomic) NSString *salt;
/** 获得的sid */
@property (copy, nonatomic) NSString *sid;

@end

@implementation JHRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"注册新用户";
    
    [self setNav];
}

- (void)setNav{
    //设置导航栏左右的按钮
    
    //设置左边的item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back_withtext" hltImage:@"navigationbar_back_withtext" target:self action:@selector(loginshow:)];
    
    //设置左边的item
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back_withtext" hltImage:@"navigationbar_back_withtext" target:self action:@selector(loginshow:)title:@"登陆"];
    
}

- (void)loginshow:(UIButton *)btn{
    NSLog(@"%s",__func__);
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

//请求验证码
- (IBAction)phoneClick:(id)sender {
    if ([self isMobileNumber:self.user.text] ) {
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        //url地址
        NSString *url = [NSString stringWithFormat:@"%@%@",RequestURL,@"user/mobilecheck.json"];
        
        //参数
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"mobile"] = self.user.text;
        
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            LogObj(responseObject);
            self.salt = responseObject[@"salt"];
            self.sid = responseObject[@"sid"];
            
            //获取验证吗
            [self getAuth];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            LogObj(error.localizedDescription);
            
        }];
        
    } else
    {
        [self alertWithMessage:@"你的手机号不存在"];
    }
    
    

    
    
}


//获取验证码
- (void)getAuth{
    
}

//注册
- (IBAction)regBtn:(id)sender {
    
    
    
}



#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField==self.user) {
        [self.user resignFirstResponder];
        [self.pwd1 becomeFirstResponder];
    }else if (textField==self.txtAuth){
        [self.txtAuth resignFirstResponder];
        [self.pwd1 becomeFirstResponder];
    }else if (textField==self.pwd1){
        [self.pwd1 resignFirstResponder];
    }
    
    return YES;
}

//判断是否是电话号码
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


//弹警告框
- (void)alertWithMessage:(NSString *)string{
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:NSLocalizedString(@"提示", nil)
                              message:NSLocalizedString(string, nil)
                              delegate:self
                              cancelButtonTitle:@"确定！"
                              otherButtonTitles:nil,
                              nil];
    alertView.delegate = self;
    [alertView show];
}




//sha1加密方式
- (NSString *)getSha1String:(NSString *)srcString{
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
