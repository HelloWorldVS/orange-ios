//
//  AppDelegate.m
//  juhua
//
//  Created by 乔耐 on 15/10/21.
//  Copyright (c) 2015年 juzi. All rights reserved.
//

#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "Pingpp.h"
#import "ViewController.h"
#import "JHNewFeatureViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation {
//
//    //跳转支付宝钱包进行支付，处理支付结果
//    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//        NSLog(@"result = %@",resultDic);
//        //
//    }];
//
//    return YES;
//}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    [Pingpp handleOpenURL:url
           withCompletion:^(NSString *result, PingppError *error) {
               ViewController *rootVC = (ViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
               [rootVC handlePaymentResult:result error:error];
           }];
    return  YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //1初始化一个window
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //     JHTabBarController *tabbarCtrl = [[JHTabBarController alloc] init];
    
    //2设置根控制器
    NSLog(@"%@",[NSBundle mainBundle].infoDictionary);
    
    CGFloat currentVersion = [JHUtils appVersion];
    
    
    //2.1判断本地是否有保存过版本号
    CGFloat saveVersion = [[NSUserDefaults standardUserDefaults] doubleForKey:KEY_VERSION];
    
    if (saveVersion==0) {
        //直接进入新特性页
        [self.window setRootViewController:[JHNewFeatureViewController new]];
    }else{
        //进行版本号对比
        if (currentVersion>saveVersion) {
            //直接进入新特性页
            [self.window setRootViewController:[JHNewFeatureViewController new]];
        }else{
            ViewController *tabbarCtrl = [[ViewController alloc] init];
            //设置根控制器
            [self.window setRootViewController:tabbarCtrl];
        }
    }
    
    //3让window显示出来
    [self.window makeKeyAndVisible];
    

    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
#ifdef DEBUG
    [[NSNotificationCenter defaultCenter] postNotificationName:@"applicationDidBecomeActive" object:nil];
#endif
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//// iOS 8 及以下请用这个
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    return [Pingpp handleOpenURL:url withCompletion:nil];
//}
//
//// iOS 9 以上请用这个
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {
//    return [Pingpp handleOpenURL:url withCompletion:nil];
//}

@end
