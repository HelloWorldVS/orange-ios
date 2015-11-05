//
//  JHResetPasswordViewController.m
//  JvHua
//
//  Created by 乔耐 on 15/11/4.
//  Copyright (c) 2015年 juzi. All rights reserved.
//

#import "JHResetPasswordViewController.h"
#import "JHLoginViewController.h"


@interface JHResetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *newpasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswrodTF;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;


@end

@implementation JHResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)commit:(UIButton *)sender {



}

@end
