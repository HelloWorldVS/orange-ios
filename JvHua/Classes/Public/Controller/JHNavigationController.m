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

    NSDictionary* textAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]};
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

    
    
    UIViewController *ctrl =  self.viewControllers.firstObject;
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *backBtn = [[UIButton alloc] init];
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
