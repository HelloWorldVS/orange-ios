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


@interface JHLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation JHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNav];
}

- (void)setNav{
    
    
    //设置左边的item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back_withtext" hltImage:@"navigationbar_back_withtext" target:self action:@selector(homeshow:)];
    
    
    //设置导航栏
    self.navigationController.title = @"登陆菊花";
}

- (void)homeshow:(UIButton *)btn{
    NSLog(@"%s",__func__);
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}




- (IBAction)loginClick:(UIButton *)btn {
    

    
 }
- (IBAction)forgetPassword:(id)sender {
    JHForgetPasswordViewController *forgetVC = [[JHForgetPasswordViewController alloc] init];
    forgetVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:forgetVC animated:YES];
}

- (IBAction)registerAccount:(id)sender {
    JHRegisterViewController *registerVC = [[JHRegisterViewController alloc] init];
    registerVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)registerSucceed:(NSString *)phoneNum
{
    _accountTF.text = phoneNum;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
