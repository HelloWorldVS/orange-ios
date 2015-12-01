//
//  JHTabBarController.m
//  橘花
//
//  Created by 乔耐 on 15/10/14.
//  Copyright (c) 2015年 橘子星球网络科技有限公司. All rights reserved.
//

#import "JHTabBarController.h"
#import "JHNavigationController.h"

#import "JHHomeController.h"
#import "JHClassificationController.h"

#import "JHSellingVC.h"
#import "JHWalletVC.h"
#import "JHMyController.h"
#import "JHLoginViewController.h"

#import "JHTabBar.h"
#import "JHTabBarButton.h"
//#import "JHBaseController.h"

@interface JHTabBarController () <JHTabBarDelegate, JHLoginViewControllerDelegate>

@property (nonatomic, weak) JHTabBar *customTabBar;

@property (nonatomic, weak) JHHomeController *home;
@property (nonatomic, weak) JHClassificationController *msg;
@property (nonatomic, weak) JHSellingVC *hot;
@property (nonatomic, weak) JHWalletVC *wallet;
@property (nonatomic, weak) JHMyController *my;

@property (nonatomic, strong) NSMutableArray *arrayDatas;




@end

@implementation JHTabBarController


- (JHTabBar *)customTabBar
{
    if (!_customTabBar) {
        // 创建一个新的tabbar
        JHTabBar *customTabBar = [[JHTabBar alloc] init];
        customTabBar.backgroundColor = [UIColor clearColor];
        customTabBar.frame = self.tabBar.bounds;
        customTabBar.delegate = self;
        self.tabBar.backgroundColor = [UIColor whiteColor];
//        self.tabBar.backgroundImage = [UIImage imageNamed:@"starbar_bg"];
        
        
        [self.tabBar addSubview:customTabBar];
        self.customTabBar = customTabBar;
    }
    return _customTabBar;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
        [self setupAllChildVCs];
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildVCs
{
    
//    _arrayDatas = [NSMutableArray array];
//    // 获取全部分类的名称
////    [JHHttpTool getWithURL:DK_API_FOR_GET_PRODUCT_TYEP params:nil success:^(id json) {
//        
//        
//        NSArray *typesArray = json[@"data"];
//        for (NSDictionary *dict in typesArray) {
//            [_arrayDatas addObject:dict];
//        }
//        
//        
//    } failure:^(NSError *error) {
//        
//    }];
    
    //添加首页
    JHHomeController *homeCtlt = [[JHHomeController alloc] init];
    [self addChildViewCtrlWithTitle:@"首页" image:@"tabbar_home" ctrl:homeCtlt];
    
    //添加分类
    JHClassificationController *msgCtlt = [[JHClassificationController alloc] init];
    [self addChildViewCtrlWithTitle:@"分类" image:@"tabbar_message_center" ctrl:msgCtlt];
    
    
    //添加热卖
    JHSellingVC *hotCtlt = [[JHSellingVC alloc] init];
    [self addChildViewCtrlWithTitle:@"热卖" image:@"tabbar_discover" ctrl:hotCtlt];
    
    
    //添加钱包
    
    JHWalletVC *walletCtlt = [[JHWalletVC alloc] init];
    [self addChildViewCtrlWithTitle:@"钱包" image:@"tabbar_wallet" ctrl:walletCtlt];
    
    //添加我的
    //    JHLoginViewController *myCtlt = [[JHLoginViewController alloc] init];
    //    [self addChildViewCtrlWithTitle:@"我的" image:@"tabbar_profile" ctrl:mineCtlt];
    
    JHMyController *myCtlt = [[JHMyController alloc] init];
    [self addChildViewCtrlWithTitle:@"我的" image:@"tabbar_profile" ctrl:myCtlt];
    
    
    
//    JHHomeController *homeCtlt = [[JHHomeController alloc] init];
//    [self setupOneChildVC:homeCtlt title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
//    self.home = homeCtlt;
//    
//    JHClassificationController *msgCtlt = [[JHClassificationController alloc] init];
//    [self setupOneChildVC:msgCtlt title:@"分类" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
////    [msgCtlt iniTitleStr:@"分类"];
//    self.msg = msgCtlt;
//    
//    JHSellingVC *hotCtlt = [[JHSellingVC alloc] init];
//    [self setupOneChildVC:hotCtlt title:@"热卖" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
////    [hotCtlt iniTitleStr:@"热卖"];
//    self.hot = hotCtlt;
//    
//    JHWalletVC *walletCtlt = [[JHWalletVC alloc] init];
////    [walletCtlt iniTitleStr:@"钱包"];
//    [self setupOneChildVC:walletCtlt title:@"钱包" imageName:@"tabbar_wallet" selectedImageName:@"tabbar_wallet_selected"];
//    self.wallet = walletCtlt;
//    
//    JHMyController *myCtlt = [[JHMyController alloc] init];
//    [self setupOneChildVC:myCtlt title:@"我的" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
////    [myCtlt iniTitleStr:@"我的"];
//    self.my = myCtlt;

    
    
}



- (void)setupOneChildVC:(UIViewController *)child title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    child.title = title;
    child.tabBarItem.image = [UIImage imageWithName:imageName];
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    if (DK_CURRENT_SYS_VERSION >= 7.0) {
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    child.tabBarItem.selectedImage = selectedImage;
    
    JHNavigationController *navVC = [[JHNavigationController alloc] initWithRootViewController:child];
    [self addChildViewController:navVC];
    
    [self.customTabBar addTabBarButton:child.tabBarItem];
}

#pragma mark -IWTabBarDelegate
- (void)tabBar:(JHTabBar *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to btn:(JHTabBarButton *)btn oldBtn:(JHTabBarButton *)oldBtn
{
    
    DKLog(@"---tabBarindex =%ld", to);
    
    if (to == 4) {
        //        BOOL isLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:@"checkLogin"] boolValue];
        if ([JHUtilTool getCurrentToken]) {
            self.selectedIndex = to;
        } else {
            JHLoginViewController *loginVC = [[JHLoginViewController alloc] init];
//            loginVC.delegate = self;
//            loginVC.tabBarBtn = btn;
//            loginVC.oldTabBarBtn = oldBtn;
//            loginVC.tabBar = tabBar;
//            loginVC.from = from;
//            loginVC.to = to;
            
            JHNavigationController *nav = [[JHNavigationController alloc] initWithRootViewController:loginVC];
            //            [self.navigationController pushViewController:loginVC animated:YES];
            [self presentViewController:nav animated:YES completion:nil];
        }
    } else {
        self.selectedIndex = to;
    }
    
}

- (void)loginSuccess:(UIViewController *)controller tabBarBtn:(JHTabBarButton *)tabBarBtn oldTabBarBtn:(JHTabBarButton *)oldTabBarBtn tabBar:(JHTabBar *)tabBar to:(NSInteger)to from:(NSInteger)from
{
    oldTabBarBtn.selected = NO;
    tabBarBtn.selected = YES;
    
    tabBar.selectedTabBarButton = tabBarBtn;
    [self tabBar:tabBar didSelectButtonFrom:from to:to btn:tabBarBtn oldBtn:oldTabBarBtn];
    
    //    [tabBar setValue:tabBarBtn forKey:@"selectedTabBarButton"];
    //    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
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
    dic[NSForegroundColorAttributeName] = KGreenColor;
    
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
