//
//  JHLoginViewController.m
//  JvHua
//
//  Created by 乔耐 on 15/11/4.
//  Copyright (c) 2015年 juzi. All rights reserved.
//

#import "JHLoginViewController.h"
#import "JHRegisterViewController.h"
#import "JHForgetPasswordViewController.h"
#import "JHChangePasswordViewController.h"
#import "OZHNetWork.h"

#import "MBProgressHUD+MJ.h"

@interface JHLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@property (weak, nonatomic) IBOutlet UIButton *forgetPassword;


@property (nonatomic,copy) NSString *token;

@end

@implementation JHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 21, 21)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_withtext"] forState:UIControlStateNormal];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    // 左上角的返回
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    
    
//    [self setNav];
    
    
}

#pragma mark - 导航控制器

//- (void)setNav{
//    
//    //设置左边的item
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back_withtext" hltImage:@"navigationbar_back_withtext" target:self action:@selector(homeshow:)];
//    
//    
//    //设置导航栏
//    self.navigationController.title = @"登陆菊花";
//}

- (void)back:(UIButton *)btn{
    NSLog(@"%s",__func__);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 按钮点击事件
//登陆按钮

- (IBAction)loginClick:(UIButton *)btn {
    
 [self LoginWithUserName:self.userNameTextField.text AndPassword:self.passWordTextField.text];
    
 }


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - NetWorking
- (void)LoginWithUserName:(NSString *)username AndPassword:(NSString *)password
{
    [[OZHNetWork sharedNetworkTools] LoginWithUserName:username AndPassWord:password Success:^(OZHNetWork *manager, NSDictionary *jsonDict) {
        
        if ([jsonDict[@"msg"] isEqualToString:@"true"]) {
            // TODO: 登录成功,撤掉正在登录的提示,该跳哪跳哪.
            // ...
            
            
            
            [MBProgressHUD hideHUD];
        }
        else {
            NSString *messageFromServer = jsonDict[@"message"];
            if (messageFromServer) {
                [MBProgressHUD showError:messageFromServer];
            } else {
                [MBProgressHUD showError:@"用户名或密码错误"];
            }
        }
        
    } andFailure:^(OZHNetWork *manager, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败，请稍后重试"];
    }];
}

- (void)getDetailUserInfoWithId:(NSString *)Id {
    
    [[OZHNetWork sharedNetworkTools] getUserInfomationWithId:Id Success:^(OZHNetWork *manager, NSDictionary *jsonDict) {
        // ...一个巨大的字典，看api酌情解析
        if (jsonDict[@"message"]) {
            [MBProgressHUD showError:jsonDict[@"message"]];
        }
        
        // 异步不能用return返回结果，可以通过调用刷新UI的接口
        // 举个栗子:
        /**
         {
         // ..可以考虑把经常需要用到又不会经常变的数据缓存在本地，像用户手机号，用户名什么的，偏好设置或者plist都可以，
         
         // update UI...
         self.nameLabel.text = jsonDict[@"name"];
         self.creditLabel.text = jsonDict[@"credit"];
         self.avatarImageView.image = [SDWebImage sd_setimageURL:jsonDict[@"头像URL"]];
         }
         */
        
    } andFailure:^(OZHNetWork *manager, NSError *error) {
        //NSLog(@"获取用户信息 error == %@",error);
        [MBProgressHUD showError:@"网络错误"];
    }];
    
}



#pragma mark - 登陆成功,录入用户信息
- (void)inputUserInfoWithDict:(NSDictionary *)dict
{
    [DEFAULT setObject:dict forKey:@"UserDict"];
    [DEFAULT setObject:[NSNumber numberWithBool:YES] forKey:@"isLogin"];
    
    
    NSMutableDictionary *RongyunDict = [[NSMutableDictionary alloc] init];
    [RongyunDict setObject:dict[@"Id"] forKey:@"UserId"];
    [RongyunDict setObject:dict[@"NickName"] forKey:@"NickName"];
    [RongyunDict setObject:dict[@"ImgUrl"] forKey:@"ImgUrl"];
    [RongyunDict setObject:dict[@"Tel"] forKey:@"PhoneNumber"];
    
    [DEFAULT setObject:RongyunDict forKey:@"RongyunDict"];
    
    [DEFAULT setObject:[NSNumber numberWithBool:NO] forKey:@"firstTime"];
    
    [DEFAULT synchronize];
    
    [self getRongyunToken];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    /**
     *  注意
     */
    
    if ([self.delegate respondsToSelector:@selector(doNetWorking)]) {
        
        [self.delegate doNetWorking];
        
    }
    
    [MBProgressHUD hideHUD];
    
    
}


- (void)getRongyunToken {
    
    NSDictionary *RongyunDict = [DEFAULT objectForKey:@"RongyunDict"];
    
    
    NSString *ID = [RongyunDict objectForKey:@"UserId"];
    
    
    NSString *NickName;
    if ([[RongyunDict objectForKey:@"NickName"] isEqualToString:@""]) {
        NickName = [NSString stringWithFormat:@"用户%@",ID];
    }
    else {
        NickName = [RongyunDict objectForKey:@"NickName"];
    }
    
    NSString *ImgUrl = [RongyunDict objectForKey:@"ImgUrl"];
    
    
    NSString * nonce = [NSString stringWithFormat:@"%d",arc4random()];
    
    NSString * timestamp = [[NSString alloc] initWithFormat:@"%ld",(long)[NSDate timeIntervalSinceReferenceDate]];
    
    
    // post 方法中，url中没有参数
    NSURL *url = [NSURL URLWithString:@"https://api.cn.ronghub.com/user/getToken.json"];
    
    // post 方法中，数据应该在请求的数据体中
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.timeoutInterval = 10;
    
    request.HTTPMethod = @"POST";
    
    //配置http header
    [request setValue:APPKEY forHTTPHeaderField:@"App-Key"];
    [request setValue:nonce forHTTPHeaderField:@"Nonce"];
    [request setValue:timestamp forHTTPHeaderField:@"Timestamp"];
    [request setValue:APPSecret forHTTPHeaderField:@"appSecret"];
    
    //生成hashcode 用以验证签名
    [request setValue:[self base64Encode:[NSString stringWithFormat:@"%@%@%@",APPKEY,nonce,timestamp]]forHTTPHeaderField:@"Signature"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString *bodyString = [NSString stringWithFormat:@"userId=%@&name=%@&portraitUri=%@" ,ID,NickName,ImgUrl];
    request.HTTPBody = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [NSURLConnection sendAsynchronousRequest:request  queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        //        NSLog(@"POST!!! %@", result);
        
        self.token = result[@"token"];
        
        [DEFAULT setObject:self.token forKey:@"token"];
        
        [DEFAULT synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UserIsLogined" object:nil];
        
        if (connectionError) {
            
            NSLog(@"error %@",connectionError);
        }
        
    }];
    
    
}

- (NSString *)base64Encode:(NSString *)str {
    
    // 1. 将字符串转换成二进制数据
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    // 2. 返回 NSData 编码后的结果
    return [data base64EncodedStringWithOptions:0];
}


- (void)showSimpleAlertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - 通知中心
- (void)createNotificationCenter {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backFrmoRegister:) name:@"backFrmoRegister" object:nil];
}

- (void)backFrmoRegister:(NSNotification *)sender {
    
    //NSLog(@"%@",sender.userInfo);
    
    self.phoneNumber.text = sender.userInfo[@"account"];
    self.passWordTextField.text = sender.userInfo[@"password"];
    
    [self LoginWithUserName:self.phoneNumber.text AndPassword:self.passWordTextField.text];
    
    [MBProgressHUD showMessage:@"正在进行登录~"];
    
}

- (void)textFieldChange:(NSNotification *)notification {
    if ([self.phoneNumber.text isEqualToString:@""] || [self.passWord.text isEqualToString:@""]) {
        self.registBtn.userInteractionEnabled = NO;
        [self.registBtn setTitleColor:[UIColor colorWithRed:244/256.0 green:204/256.0 blue:173/256.0 alpha:1] forState:UIControlStateNormal];
    }
    else {
        self.registBtn.userInteractionEnabled = YES;
        [self.registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}


//点击跳转控制器

//跳至忘记密码
- (IBAction)forgetPassword:(id)sender {
    JHForgetPasswordViewController *forgetVC = [[JHForgetPasswordViewController alloc] init];
    forgetVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:forgetVC animated:YES];
}

//跳至注册
- (IBAction)registerAccount:(id)sender {
    JHRegisterViewController *registerVC = [[JHRegisterViewController alloc] init];
    registerVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)registerSucceed:(NSString *)phoneNum
{
    _phoneNumber.text = phoneNum;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
