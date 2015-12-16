//
//  JHAccountViewController.m
//  JvHua
//
//  Created by 乔耐 on 15/11/25.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHAccountViewController.h"
#import "JHAddressController.h"
#import "JHCreditController.h"
#import "JHInfoImageCell.h"

@interface JHAccountViewController ()

@end

@implementation JHAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账号设置";
   
//    [self setupHeader];
}

////设置header
//- (void)setupHeader{
//   
//    
//}


- (void)loadGroups{
   
    JHItem *head = [JHItemArrow itemWithTitle:@"头像" icon:@"image"];
    JHGroup *group1 = [JHGroup groupWithItems:@[head] header:nil];
    
    
    JHItem *add = [JHItemArrow itemWithTitle:@"地址管理" destController:[JHAddressController class]];
    JHItem *credit = [JHItemArrow itemWithTitle:@"信用认证" destController:[JHCreditController class]];
    
    JHGroup *group2 = [JHGroup groupWithItems:@[add,credit]];
    self.groups = @[group1,group2];
}



@end
