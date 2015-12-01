//
//  JHRegisterViewController.m
//  JvHua
//
//  Created by 乔耐 on 15/11/4.
//  Copyright (c) 2015年 juzi. All rights reserved.
//

#import "JHRegisterViewController.h"
#import "JHLoginViewController.h"
#import "OZHNetWork.h"
#import "MBProgressHUD+MJ.h"

@interface JHRegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *identifyingCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneIdentifyingCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordAgainTextField;
@property (weak, nonatomic) IBOutlet UIView *identifyingCodeView;
@property (weak, nonatomic) IBOutlet UIButton *RegistButton;
@property (nonatomic,copy) NSString *token;

@end


@implementation JHRegisterViewController
{
    NSInteger _time;
    UILabel *_timeLabel;
    BOOL _isPhoneRegistered;
    BOOL _isPhoneIdentifiyPass;
    NSString *_phoneIdentifiy;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"注册新用户";
    [self setupLayout];
    [self setNav];
}

#pragma mark - 导航控制器

- (void)setupLayout
{
    UIImage *loginValidateImg = [UIImage imageNamed:@"Login_validate"];
    UIImage *resizedLoginValidateImg = [loginValidateImg resizableImageWithCapInsets:UIEdgeInsetsMake(loginValidateImg.size.height/2 - 1, loginValidateImg.size.width/2 - 1, loginValidateImg.size.height/2, loginValidateImg.size.width/2)];
    
    UIImage *loginBtnImg = [UIImage imageNamed:@"Login_button"];
    UIImage *resizedLoginBtnImg = [loginBtnImg resizableImageWithCapInsets:UIEdgeInsetsMake(loginBtnImg.size.height/2 - 1, loginBtnImg.size.width/2 - 1, loginBtnImg.size.height/2, loginBtnImg.size.width/2)];
    
    [self.identifyingCodeButton setBackgroundImage:resizedLoginValidateImg forState:UIControlStateNormal];
    [self.RegistButton setBackgroundImage:resizedLoginBtnImg forState:UIControlStateNormal];
}

- (void)setNav{
    //设置导航栏左右的按钮
    
    //设置左边的item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back_withtext" hltImage:@"navigationbar_back_withtext" target:self action:@selector(loginshow:)];
    
    
    //设置右边登陆
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(loginshow:)];
    
    
    
}

- (void)loginshow:(UIButton *)btn{
    NSLog(@"%s",__func__);
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


#pragma mark - 验证手机号
/**
 根据是否为手机号,设置验证码按钮的状态
 */
- (void)isInputPhoneNumber
{
    
    
    if ([self isMobileNumberValid:self.phoneNumberTextField.text]) {
        
        //        NSLog(@"是不是手机号");
        //        self.identifyingCodeButton.userInteractionEnabled = YES;
        
        
        
    }
    else
    {
        //        NSLog(@"不是手机号");
        
        [MBProgressHUD showError:@"请输入正确的手机号码"];
        
        return;
        
        //        self.identifyingCodeButton.userInteractionEnabled = NO;
    }
    
    
}

/**
 *  正则解析 手机号
 */
- (BOOL)isMobileNumberValid:(NSString *)mobileNum
{
    //    https://github.com/VincentSit/ChinaMobilePhoneNumberRegex
    //    130、131、132、133、134、135、136、137、138、139
    //    145、147
    //    150、151、152、153、155、156、157、158、159
    //    176、177、178、1700、1705、1709
    //    180、181、182、183、184、185、186、187、188、189
    NSString * MOBILE = @"^(13\\d|14[57]|15[^4,\\D]|17[678]|18\\d)\\d{8}|170[059]\\d{7}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    //    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    //    NSString * CU = @"^1(3[0-2]|5[256]|8[156]|7[0-9])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    //    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
}


- (BOOL)isPasswordValid:(NSString *)pwd
{
    //    http://blog.csdn.net/dmtnewtons_blog/article/details/9243773
    // 5~19位，必须字母开头，可带".","_"符号
    NSString *pwdPattern = @"^([a-zA-Z0-9]|[._]){5,20}$";
    NSPredicate *regexTestPwd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwdPattern];
    return [regexTestPwd evaluateWithObject:pwd];
}


//获取验证码按钮点击事件
- (IBAction)GetIdentifyingCode:(id)sender {
    
    if (![self isMobileNumberValid:self.phoneNumberTextField.text]) {
        [MBProgressHUD showError:@"请输入正确的手机号码"];
        return;
    }
    
    [self checkPhoneNumberRegister];
}




- (void)checkPhoneNumberRegister {
    
    //30秒
    //验证手机号是否注册过
    [[OZHNetWork sharedNetworkTools] testCellPhoneNumber:self.phoneNumberTextField.text withSuccess:^(OZHNetWork *manager, NSDictionary *jsonDict) {
        
        NSNumber *code = jsonDict[@"code"];
        NSString *msg = jsonDict[@"message"];
        
        if (code.intValue == 400 && [msg containsString:@"未注册"]) {
            [self getRegisterCode];
        }
        else {
            [self showSimpleAlertWithTitle:@"提示" message:@"该手机号已被注册"];
        }
        
    } andFailure:^(OZHNetWork *manager, NSError *error) {
        
        NSLog(@"验证手机号 error == %@",error);
        
        [self showSimpleAlertWithTitle:@"提示" message:@"网络连接失败，请稍后重试"];
    }];
    
}


- (void)getRegisterCode {
    
    [[OZHNetWork sharedNetworkTools] sendIdentifyingCodeWithPhoneNumber:self.phoneNumberTextField.text withSuccess:^(OZHNetWork *manager, NSDictionary *jsonDict) {
        
        //NSLog(@"发送验证码:%@",[NSString stringWithFormat:@"%@",jsonArr[0][@"result"][0][@"message"]]);
        
        __block int timeout= 59; //倒计时时间
        //点击获取验证码后,进行倒计时
        
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
        dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            
            if(timeout<=0){ //倒计时结束，关闭
                dispatch_source_cancel(timer);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.identifyingCodeButton.userInteractionEnabled = YES;
                    //设置界面的按钮显示 根据自己需求设置
                    [self.identifyingCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                });
            }else {
                //            int minutes = timeout / 60;
                int seconds = timeout % 60;
                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                
                self.identifyingCodeButton.userInteractionEnabled = NO;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //设置界面的按钮显示 根据自己需求设置
                    [self.identifyingCodeButton setTitle:[NSString stringWithFormat:@"重新发送%@",strTime] forState:UIControlStateNormal];
                });
                timeout--;
                
            }
            
        });
        
        dispatch_resume(timer);
        
        
        if ([jsonDict[@"msg"] isEqualToString:@"true"]) {
            NSLog(@"succ");
        }else{
            NSString *msgFromServer = jsonDict[@"message"];
            if (msgFromServer) {
                [self showSimpleAlertWithTitle:@"提示" message:msgFromServer];
            }else {
                [self showSimpleAlertWithTitle:@"提示" message:@"发送验证码失败，请稍后重试"];
            }
        }
        
    } andFailure:^(OZHNetWork *manager, NSError *error) {
        NSLog(@"发送验证码 error == %@",error);
        [self showSimpleAlertWithTitle:@"提示" message:@"网络连接失败，请稍后重试"];
        self.identifyingCodeButton.userInteractionEnabled = YES;
    }];
    
    self.identifyingCodeButton.userInteractionEnabled = NO;
}




#pragma mark - 点击注册按钮事件
- (IBAction)StartToRegist:(id)sender {
    
    typeof(self) weakSelf = self;
    
    //4个输入框是否有空
    if (self.phoneNumberTextField.text.length != 0 && self.phoneIdentifyingCodeTextField.text.length != 0 && self.passWordTextField.text.length != 0 && self.passWordAgainTextField.text.length != 0)
    {
        if (![self isMobileNumberValid:self.phoneNumberTextField.text]) {
            [self showSimpleAlertWithTitle:@"提示" message:@"手机号码格式不正确"];
            return;
        }
        if (![self isPasswordValid:self.passWordTextField.text]) {
            [self showSimpleAlertWithTitle:@"提示" message:@"密码只允许数组字母以及英文句号及下划线"];
            return;
        }
        
        //2次密码输入是否相同
        if ([self.passWordTextField.text isEqualToString:self.passWordAgainTextField.text])
        {
            NSString *phoneNum =  self.phoneNumberTextField.text;
            NSString *pwd = self.passWordAgainTextField.text;
            //允许注册
            [[OZHNetWork sharedNetworkTools] postRegisterUserInfoWithPhoneNumber:phoneNum password:pwd code:self.phoneIdentifyingCodeTextField.text withSuccess:^(OZHNetWork *manager, NSDictionary *jsonDict) {
                
                if ([jsonDict[@"msg"] isEqualToString:@"true"]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"backFrmoRegister" object:nil userInfo:@{@"account":weakSelf.phoneNumberTextField.text,@"password":weakSelf.passWordTextField.text}];
                    //
                    [weakSelf LoginWithUserName:weakSelf.phoneNumberTextField.text AndPassword:weakSelf.passWordTextField.text];
                    
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                } else {
                    if ([jsonDict[@"code"] intValue] == 10002) {
                        [self showSimpleAlertWithTitle:@"提示" message:@"验证码错误"];
                    } else {
                        [self showSimpleAlertWithTitle:@"提示" message:@"注册失败，请稍后重试"];
                    }
                }
                
            } andFailure:^(OZHNetWork *manager, NSError *error) {
                NSLog(@"注册 error == %@",error);
                [self showSimpleAlertWithTitle:@"提示" message:@"网络连接失败，请稍后重试"];
            }];
            
        }
        else
        {
            //不允许注册
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次密码输入不一致,请重新输入" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                self.passWordTextField.text = @"";
                self.passWordAgainTextField.text = @"";
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }
    else
    {
        [self showSimpleAlertWithTitle:@"提示" message:@"请填写完整信息"];
    }
    
    
}


#pragma mark - 辅助方法
- (void)showSimpleAlertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}



- (NSString *)base64Encode:(NSString *)str {
    
    // 1. 将字符串转换成二进制数据
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    // 2. 返回 NSData 编码后的结果
    return [data base64EncodedStringWithOptions:0];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 登录
- (void)LoginWithUserName:(NSString *)username AndPassword:(NSString *)password
{
    
    [[OZHNetWork sharedNetworkTools] LoginWithUserName:username AndPassWord:password Success:^(OZHNetWork *manager, NSDictionary *jsonDict) {
        
        if ([jsonDict[@"msg"] isEqualToString:@"true"]) {
            // TODO: 登录成功,撤掉正在登录的提示,该跳哪跳哪.
            // ...
        }
        else {
            NSString *messageFromServer = jsonDict[@"message"];
            if (messageFromServer) {
                [self showSimpleAlertWithTitle:@"提示" message:messageFromServer];
            } else {
                [self showSimpleAlertWithTitle:@"提示" message:@"登录失败，请稍后重试"];
            }
        }
        
    } andFailure:^(OZHNetWork *manager, NSError *error) {
        [self showSimpleAlertWithTitle:@"提示" message:@"网络连接失败，请稍后重试"];
        
    }];
}




#pragma mark - 代理方法
- (void)backFromZRTRZViewController {
    [self.navigationController popViewControllerAnimated:NO];
}




@end
