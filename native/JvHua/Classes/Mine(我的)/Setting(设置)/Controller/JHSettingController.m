//
//  JHSettingController.m
//  JvHua
//
//  Created by 乔耐 on 15/11/26.
//  Copyright © 2015年 juzi. All rights reserved.
//


#import "JHSettingController.h"

#import "JHAccountViewController.h"
#import "JHAdviceViewController.h"
//#import "JHUpdateViewController.h"
#import "JHAboutViewController.h"
#import "JHInviteViewController.h"


@interface JHSettingController ()

@end

@implementation JHSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    
    [self setupFooter];
}




- (void)loadGroups{
    
    __weak typeof (self) weakSelf = self;

    
    //获取数据
    //账号设置
    JHItem *item1 = [JHItemArrow itemWithTitle:@"账号设置" destController:[JHAccountViewController class]];
    //意见反馈
    JHItem *item2 = [JHItemArrow itemWithTitle:@"意见反馈" destController:[JHAdviceViewController class]];
    
    //检查更新
    JHItem *item3 = [JHItemArrow itemWithTitle:@"检查更新" icon:nil option:^{
        UIAlertView *alertview= [[UIAlertView alloc] initWithTitle:@"已经是最新版本了!" message:nil delegate:weakSelf cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertview show];

    }];
//    JHItem *item3 = [JHItemArrow itemWithTitle:@"检查更新" destController:[JHUpdateViewController class]];
    
    //关于我们
    JHItem *item4 = [JHItemArrow itemWithTitle:@"关于我们" destController:[JHAboutViewController class]];
    //邀请吗
    JHItem *item5 = [JHItemArrow itemWithTitle:@"邀请码" destController:[JHInviteViewController class]];
    
    
    JHGroup *group1 = [JHGroup groupWithItems:@[item1,item2,item3,item4,item5]];
    
    
    
//    JHItem *item6 = [JHItemArrow itemWithTitle:@"退出登录"];
//    
//    
//    JHGroup *group2 = [JHGroup groupWithItems:@[item6]];
//
    
    
    self.groups = @[group1];
    
    
}

- (void)setupFooter
{
    //退出当前账号
    UIButton *logout = [[UIButton alloc] init];
    logout.backgroundColor = [UIColor whiteColor];
    //设置文字
    [logout setTitle:@"退出登录" forState:UIControlStateNormal];
    [logout setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [logout addTarget:self action:@selector(logOutAction:) forControlEvents:UIControlEventTouchUpInside];
    logout.titleLabel.font = [UIFont systemFontOfSize:15];
    
    //设置成为底部控件
    self.tableView.tableFooterView = logout;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    
    
    if (![UIDevice currentDevice].systemVersion.doubleValue >= 7.0) {
        self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    }
    
    // 设置高度(不用设置宽度)
    logout.height = 45;

    [self.tableView       setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
}



#pragma mark 退出登录
- (void)logOutAction:(UIButton *)btn
{
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"checkLogin"];
//    [JHUtilTool removeToken];
//    [JHUtilTool removeUserName];
//    
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    JHTabController *mainVc = [[JHTabController alloc] init];
//    delegate.window.rootViewController = mainVc;
}

@end
