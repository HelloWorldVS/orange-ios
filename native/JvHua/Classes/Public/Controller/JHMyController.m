//
//  JHMyController.m
//  JvHua
//
//  Created by 乔耐 on 15/11/24.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHMyController.h"
#import "JHHomeTitleButton.h"
#import "JHSettingController.h"
@interface JHMyController ()
@property (nonatomic,weak) JHHomeTitleButton *titleBtn;
@end

@implementation JHMyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.navigationController.title = @"个人中心";
    
    [self setNav];
    
}













#pragma mark - 导航控制器

- (void)setNav{
    
    //设置右边的item
    //设置右边设置按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting:)];
    
   
    
    //设置中间的view
    JHHomeTitleButton *titleBtn = [[JHHomeTitleButton alloc] init];
    //    [titleBtn setTitle:@"限时特卖" forState:UIControlStateNormal];
    
    [titleBtn sizeToFit];
    self.navigationItem.titleView = titleBtn;
    self.titleBtn = titleBtn;
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.titleBtn setTitle:@"个人中心" forState:UIControlStateNormal];
    self.titleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [self.titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.tabBarItem.badgeValue = nil;
    
}
- (void)setting:(UIButton *)btn{
    NSLog(@"%s",__func__);
    
    [self.navigationController popViewControllerAnimated:YES];
    JHSettingController *setVC = [[JHSettingController alloc] init];
    setVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setVC animated:YES];

    
}



@end
