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


@interface JHAccountViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationBarDelegate>

@end

@implementation JHAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账号设置";
   
    self.view.backgroundColor = KLightGreyColor;
    
    UITapGestureRecognizer *view1Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(view1Tap:)];
    [_view1 addGestureRecognizer:view1Tap];
    
    UITapGestureRecognizer *view2Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(view2Tap:)];
    [_view2 addGestureRecognizer:view2Tap];
    
    UITapGestureRecognizer *view3Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(view3Tap:)];
    [_view3 addGestureRecognizer:view3Tap];

}






#pragma mark 选择头像
- (void)view1Tap:(UITapGestureRecognizer *)tap
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"修改头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册" otherButtonTitles:@"拍照", nil];
    [actionSheet showInView:self.view];
    
}

#pragma mark 编辑地址管理
- (void)view2Tap:(UITapGestureRecognizer *)tap
{
    JHAddressController *addressList = [[JHAddressController alloc] init];
    [self.navigationController pushViewController:addressList animated:YES];
}


#pragma mark 编辑信用认证
- (void)view3Tap:(UITapGestureRecognizer *)tap
{
    JHCreditController *credit = [[JHCreditController alloc] init];
    [self.navigationController pushViewController:credit animated:YES];
}


//- (void)loadGroups{
//   
//    JHItem *head = [JHItemArrow itemWithTitle:@"头像" icon:@"image"];
//    JHGroup *group1 = [JHGroup groupWithItems:@[head] header:nil];
//    
//    
//    JHItem *add = [JHItemArrow itemWithTitle:@"地址管理" destController:[JHAddressController class]];
//    JHItem *credit = [JHItemArrow itemWithTitle:@"信用认证" destController:[JHCreditController class]];
//    
//    JHGroup *group2 = [JHGroup groupWithItems:@[add,credit]];
//    self.groups = @[group1,group2];
//}



@end
