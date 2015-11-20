//
//  JHTabBarController.m
//  橘花
//
//  Created by 乔耐 on 15/10/14.
//  Copyright (c) 2015年 橘子星球网络科技有限公司. All rights reserved.
//

#import "JHTabBarController.h"
#import "JHHomeViewController.h"
#import "JHNavigationController.h"
#import "JHLoginViewController.h"
#import "JHSellingVC.h"
#import "JHWalletVC.h"
@interface JHTabBarController ()

@end

@implementation JHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加首页
    JHHomeViewController *homeCtlt = [[JHHomeViewController alloc] init];
    [self addChildViewCtrlWithTitle:@"首页" image:@"tabbar_home" ctrl:homeCtlt];
    
    //添加分类
    UITableViewController *msgCtlt = [[UITableViewController alloc] init];
    [self addChildViewCtrlWithTitle:@"分类" image:@"tabbar_message_center" ctrl:msgCtlt];
    
    
    //添加热卖
    JHSellingVC *hotCtlt = [[JHSellingVC alloc] init];
    [self addChildViewCtrlWithTitle:@"热卖" image:@"tabbar_discover" ctrl:hotCtlt];
    
    
    //添加钱包
    
    JHWalletVC *walletCtlt = [[JHWalletVC alloc] init];
    [self addChildViewCtrlWithTitle:@"钱包" image:@"tabbar_wallet" ctrl:walletCtlt];
    
    //添加我的
    JHLoginViewController *mineCtlt = [[JHLoginViewController alloc] init];
    [self addChildViewCtrlWithTitle:@"我的" image:@"tabbar_profile" ctrl:mineCtlt];
    
    
    
}




- (void)addChildViewCtrlWithTitle:(NSString *)title image:(NSString *)image ctrl:(UIViewController *)ctrl{
    
    ctrl.view.backgroundColor = [UIColor whiteColor];
    
    //初始化子控制器
    //    UIViewController *ctrl = [[UIViewController alloc] init];
    
    //    image = @"allproducts";
    //设置选中与默认的图标
    
    ctrl.tabBarItem.image = [UIImage imageNamed:image];
    
    //解决图片变蓝的问题
    
    
    UIImage *originalImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",image]];
    ctrl.tabBarItem.selectedImage = [originalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置标题
    ctrl.title = title;
    
    //初始化文字的属性
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    dic[NSForegroundColorAttributeName] = [UIColor greenColor];
    
    //设置tabbarItem 标题的文字属性
    [ctrl.tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    //用自定义的导航栏控制器
    
    JHNavigationController *navCtrl = [[JHNavigationController alloc] initWithRootViewController:ctrl];
    
    [self addChildViewController:navCtrl];
    

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
