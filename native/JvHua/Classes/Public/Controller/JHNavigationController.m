//
//  JHNavigationController.m
//  橘花
//
//  Created by 乔耐 on 15/10/15.
//  Copyright (c) 2015年 橘子星球网络科技有限公司. All rights reserved.
//

#import "JHNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@interface JHNavigationController ()

@end

@implementation JHNavigationController


//+ (void)initialize
//{
//    // 设置导航栏主题
//    [self setupNavTheme];
//    
//    // 设置导航栏按钮主题
//    [self setupItemTheme];
//    
//}
//
//+ (void)setupNavTheme
//{
//    //    UINavigationBar *navBar = [UINavigationBar appearance];
//    //    navBar.barTintColor = DKRGBColor(248, 248, 248);
//    
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    ////    navBar [setBackgroundImage: forBarMetrics:]
//    //
//    // 按钮文字
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    // 设置文字颜色
//    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
//    // 去掉阴影
//    //    textAttrs[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetZero];
//    // 设置文字字体
//    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
//    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    
//    
//    
//}
///**
// * 设置导航栏按钮主题
// */
//+ (void)setupItemTheme
//{
//    // 1.获得appearance对象, 就能修改主题
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    
//    // 2.设置背景
//    /******普通状态******/
//    // 按钮文字
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    // 设置文字颜色
//    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    // 去掉阴影
//    //    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
//    // 设置文字字体
//    //    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:16];
//    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    
//    [[UINavigationBar appearance] setBarTintColor:KGreenColor];
//}
//

+(void)initialize
{
//    [navigationBar setBackgroundColor:[UIColor redColor]];
//    [navigationBar setBackgroundImage:[UIImage imageNamed:@"home_top_bg"] forBarMetrics:UIBarMetricsDefault];
//    
    //定义整个项目中的导航条文字
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];

    NSDictionary* textAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
    [[UINavigationBar appearance]setTitleTextAttributes:textAttributes];
    
    //获取整个项目中NavigationController下的导航条
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    navigationBar.translucent = NO;//    Bar的模糊效果，默认为YES
        
    [[UINavigationBar appearance] setBarTintColor:KGreenColor];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //    [super pushViewController:viewController animated:animated];
    
    NSLog(@"count=%ld",(unsigned long)self.viewControllers.count);

    
    
//    UIViewController *ctrl =  self.viewControllers.firstObject;
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 21, 21)];
//        [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_withtext"] forState:UIControlStateNormal];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_withtext"] forState:UIControlStateNormal];
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        // 左上角的返回
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        //        // 右上角的更多
        //        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_more" highImage:@"navigationbar_more_highlighted" target:self action:@selector(more)];

    
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)back{
    [self popViewControllerAnimated:YES];
    
}



@end
