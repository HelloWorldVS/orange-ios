//
//  JHForgetPasswordViewController.m
//  JvHua
//
//  Created by 乔耐 on 15/11/4.
//  Copyright (c) 2015年 juzi. All rights reserved.
//

#import "JHForgetPasswordViewController.h"
#import "JHChangePasswordViewController.h"
#import "OZHNetWork.h"
#import "JHLoginViewController.h"
#import "LGAlertView.h"
@interface JHForgetPasswordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *identifyingCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneIdentifyingCodeTextField;
@property (weak, nonatomic) IBOutlet UIView *identifyingCodeView;

@property (weak, nonatomic) IBOutlet UIButton *nextStep;



@end

@implementation JHForgetPasswordViewController
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
    
    self.title = @"验证身份 ";
    
    [self createDelegate];
    
    [self setNav];
    
}

- (void)createDelegate {
    self.phoneNumberTextField.delegate = self;
    self.phoneIdentifyingCodeTextField.delegate = self;
    
}


#pragma mark - 验证手机号
/**
 根据是否为手机号,设置验证码按钮的状态
 */
- (void)isInputPhoneNumber
{
    if ([self isMobileNumberValid:self.phoneNumberTextField.text]) {
        self.identifyingCodeButton.userInteractionEnabled = YES;
    }
    else
    {
        self.identifyingCodeButton.userInteractionEnabled = NO;
    }
    
    
}

/**
 *  正则解析 手机号
 */
- (BOOL)isMobileNumberValid:(NSString *)mobileNum
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

//获取验证码按钮点击事件
- (IBAction)GetIdentifyingCode:(id)sender {
    
    [self testCellPhoneNumber];
    
    
   
    
    double delayInSeconds = 3.0;
    __weak typeof(self) weakSelf = self;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf delayMethod]; });
}

- (void)delayMethod {
    
}

- (void)testCellPhoneNumber {
    
    [self sendMessage];
    
}

- (void)sendMessage {
    
   [[OZHNetWork sharedNetworkTools] sendIdentifyingCodeWithPhoneNumber:self.phoneNumberTextField.text withSuccess:^(OZHNetWork *manager, NSDictionary *jsonDict) {
        
        ////NSLog(@"发送验证码:%@",[NSString stringWithFormat:@"%@",jsonArr[0][@"result"][0][@"message"]]);
        
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
        
       // TODO:
   } andFailure:^(OZHNetWork *manager, NSError *error) {
       
       NSLog(@"发送验证码 error == %@",error);
       
   }];
    
}

- (void)judgeMessageIdentifiyWithCode:(NSString *)code
{
    _phoneIdentifiy = code;
}



#pragma mark - 点击下一步
- (IBAction)StartToRegist:(id)sender {
    
    typeof(self) weakSelf = self;
    
    //2个输入框是否有空
    if (self.phoneNumberTextField.text.length != 0 && self.phoneIdentifyingCodeTextField.text.length != 0)
    {
        
            //2次输入密码相同,判断验证码是否正确
            if ([self.phoneIdentifyingCodeTextField.text isEqualToString:_phoneIdentifiy]) {
                //允许找回密码
                
                
//                    [[OZHNetWork sharedNetworkTools] findPassWordWithPhoneNumber:self.phoneNumberTextField.text andNew:self.passWordAgainTextField.text andSuccess:^(OZHNetWork *manager, NSDictionary *jsonDict) {
//                        
//                        //找回成功
//                        if ([jsonDict[@"Success"] isEqualToString:@"1"]) {
//                            
//                            [weakSelf chagePW];
//                            
//                        }else{
//                            
//                            LGAlertView *alert = [LGAlertView alertViewWithTitle:@"错误" message:@"请重新输入" buttonTitles:nil cancelButtonTitle:@"确定" destructiveButtonTitle:nil];
//                            
//                            [alert showAnimated:YES completionHandler:nil];
//                            
//                        }
//                        
//                        
//                        
//                    } andFailure:^(OZHNetWork *manager, NSError *error) {
//                        //NSLog(@"找回密码 error == %@",error);
//                    }];
                }
            else
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证码不正确" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                
                [alert addAction:cancel];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
            
        }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入验证码信息" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}





//跳至更改密码
- (IBAction)changePassword:(id)sender {
    JHChangePasswordViewController *changeVC = [[JHChangePasswordViewController alloc] init];
    changeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:changeVC animated:YES];
    
}


#pragma mark 设置自定义返回按钮
- (void)setNav{
    
    //设置左边的item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back_withtext" hltImage:@"navigationbar_back_withtext" target:self action:@selector(back:)];
    
}


- (void)back:(UIButton *)btn{
    NSLog(@"%s",__func__);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
