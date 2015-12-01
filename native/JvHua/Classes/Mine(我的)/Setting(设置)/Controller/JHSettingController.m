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
#import "JHUpdateViewController.h"
#import "JHAboutViewController.h"
#import "JHInviteViewController.h"


@interface JHSettingController ()

@end

@implementation JHSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    
}




- (void)loadGroups{
    //获取数据
    //账号设置
    JHItem *item1 = [JHItemArrow itemWithTitle:@"账号设置" destController:[JHAccountViewController class]];
    //意见反馈
    JHItem *item2 = [JHItemArrow itemWithTitle:@"意见反馈" destController:[JHAdviceViewController class]];
    
    //检查更新
    JHItem *item3 = [JHItemArrow itemWithTitle:@"检查更新" destController:[JHUpdateViewController class]];
    
    //关于我们
    JHItem *item4 = [JHItemArrow itemWithTitle:@"关于我们" destController:[JHAboutViewController class]];
    //邀请吗
    JHItem *item5 = [JHItemArrow itemWithTitle:@"邀请码" destController:[JHInviteViewController class]];
    
    
    JHGroup *group1 = [JHGroup groupWithItems:@[item1,item2,item3,item4,item5]];
    
    
    
    
    
    
    self.groups = @[group1];
    
    
    
    
    
    
    
    
    
    
    
    
//    //账号设置
//    JHCommonItemArrow *accountInfo = [JHCommonItemArrow itemWithTitle:@"账号设置"];
//    accountInfo.destVc = [JHAccountViewController class];
//    
//    //意见反馈
//    JHCommonItemArrow *advice = [JHCommonItemArrow itemWithTitle:@"意见反馈"];
//    advice.destVc = [JHAdviceViewController class];
//    
//    //检查更新
//    JHCommonItemArrow *update = [JHCommonItemArrow itemWithTitle:@"检查更新"];
//    update.destVc = [JHUpdateViewController class];
//    
//    //关于我们
//    JHCommonItemArrow *about = [JHCommonItemArrow itemWithTitle:@"关于我们"];
//    about.destVc = [JHAboutViewController class];
//    
//    //邀请码
//    JHCommonItemArrow *invite = [JHCommonItemArrow itemWithTitle:@"邀请码"];
//    update.destVc = [JHInviteViewController class];
//    
//    
//    JHCommonGroup *group0 = [self addGroup];
//    group0.items = @[accountInfo,advice,update,about,invite];
    
    
    
    
}


@end
