//
//  JHForgetPasswordViewController.m
//  JvHua
//
//  Created by 乔耐 on 15/11/4.
//  Copyright (c) 2015年 juzi. All rights reserved.
//

#import "JHForgetPasswordViewController.h"
#import "JHResetPasswordViewController.h"

@interface JHForgetPasswordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIButton *getVerCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *vercodeTF;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation JHForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"验证身份 ";
    
    
}



- (IBAction)getVerCode:(id)sender {





}
- (IBAction)commit:(id)sender {



}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
