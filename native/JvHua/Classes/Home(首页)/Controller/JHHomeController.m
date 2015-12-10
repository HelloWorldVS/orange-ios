//
//  JHHomeController.m
//  JvHua
//
//  Created by 乔耐 on 15/11/24.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHHomeController.h"
#import "UIBarButtonItem+Extension.h"
#import "JHTemp2Controller.h"
#import "JHHomeTitleButton.h"
#import "JHMyController.h"
#import "SDCycleScrollView.h"

@interface JHHomeController ()<SDCycleScrollViewDelegate>

@property (nonatomic,weak) JHHomeTitleButton *titleBtn;

@end

@implementation JHHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // 采用本地图片实现
    NSArray *images = @[[UIImage imageNamed:@"h1.jpg"],
                        [UIImage imageNamed:@"h2.jpg"],
                        [UIImage imageNamed:@"h3.jpg"]
                        ];

    
    CGFloat w = self.view.bounds.size.width;
    
    // 本地加载 --- 创建不带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 180) imagesGroup:images];
    
    cycleScrollView.infiniteLoop = YES;
    cycleScrollView.delegate = self;
    cycleScrollView.dotColor = KGreenColor;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.view addSubview:cycleScrollView];
    //         --- 轮播时间间隔，默认1.0秒，可自定义
    //cycleScrollView.autoScrollTimeInterval = 4.0;

    
    
    
    [self setNav];
}

- (void)setNav{
    //设置导航栏左右的按钮
    
    //设置左边的item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_person_withtext" hltImage:@"navigationbar_person_withtext" target:self action:@selector(friendsearch:)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_mail_withtext" hltImage:@"navigationbar_mail_withtext" target:self action:@selector(pop:)];
    
    
    
}







#pragma mark - 私有方法

- (void)friendsearch:(UIButton *)btn{
    NSLog(@"%s",__func__);
    JHMyController *Mvc = [[JHMyController alloc] init];
    [self.navigationController pushViewController:Mvc animated:YES];
//    JHTemp2Controller *PVC = [[JHTemp2Controller alloc] init];
//    [self.navigationController pushViewController:PVC animated:YES];
    
    
}

- (void)pop:(UIButton *)btn{
    NSLog(@"%s",__func__);
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
}

@end

