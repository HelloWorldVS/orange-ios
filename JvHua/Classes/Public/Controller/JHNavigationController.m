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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //    [super pushViewController:viewController animated:animated];
    
    NSLog(@"count=%ld",self.viewControllers.count);
//    if (self.viewControllers.count!=0) {
//        //发push新控制器的时候把底部的tabbar隐藏
//        //        viewController.hidesBottomBarWhenPushed = YES;
//        [viewController setHidesBottomBarWhenPushed:YES];
//    }
    
    UIViewController *ctrl =  self.viewControllers.firstObject;
    if(self.viewControllers.count>=1){
        
        NSString *title = @"返回";
        if (self.viewControllers.count==1) {
            title = ctrl.title;
                       viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back_withtext" hltImage:@"navigationbar_back_withtext_highlighted" target:nil action:nil title:ctrl.title];
        }else{
            //            title = @"";
                        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back_withtext" hltImage:@"navigationbar_back_withtext_highlighted" target:nil action:nil title:@"返回"];
        }
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back_withtext" hltImage:@"navigationbar_back_withtext_highlighted" target:self action:@selector(back) title:title];
        
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)back{
    [self popViewControllerAnimated:YES];
    
}



@end
