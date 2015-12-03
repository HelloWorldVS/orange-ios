//
//  JHNewFeatureViewController.m
//  橘花
//
//  Created by 乔耐 on 15/10/23.
//  Copyright (c) 2015年 橘子星球网络科技有限公司. All rights reserved.
//

#import "JHNewFeatureViewController.h"
#import "ViewController.h"
#import "UIView+extension.h"
//总共有多少页
#define PAGE_COUNT 4

@interface JHNewFeatureViewController ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIScrollView *scrollView;

@property (nonatomic,weak) UIPageControl *control;


@end

@implementation JHNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupScrollView];
    
//    [self setupPageControl];
    
}


- (void)setupScrollView{
    //初始化一个scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
    //打开分页
    scrollView.pagingEnabled = YES;
    //隐藏水平方向的滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    //设置scrollView的代理
    scrollView.delegate = self;
    //添加到父控件里面去
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    for (int i = 0; i < PAGE_COUNT; ++i) {
        
        //准备image
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i+1];
        UIImage *image = [UIImage imageNamed:name];
        //初始化一个imageView
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        //设置imageView的大小
        imageView.size = scrollView.size;
        //设置imageView的x
        imageView.x = i*scrollView.width;
        
        [scrollView addSubview:imageView];
        
        
        if (i==PAGE_COUNT-1) {
            [self setupLastPageWithView:imageView];
        }
        
    }
    //设置内容大小。--滚动
    [scrollView setContentSize:CGSizeMake(PAGE_COUNT*scrollView.width, scrollView.height)];
}


/**
 *  设置最后一页的子控件
 */

- (void)setupLastPageWithView:(UIView *)lastView{
    lastView.userInteractionEnabled = YES;
    
    //设置进入的按钮
    
    UIButton *enterButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.size.width, self.view.size.height)];
    
    
    
    //添加点击事件
    [enterButton addTarget:self action:@selector(enterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [lastView addSubview:enterButton];
    
}


- (void)enterBtnClick:(UIButton *)btn{
    //保存当前app的版本号
    
    //    NSDictionary *infoDictionary = [NSBundle mainBundle].infoDictionary;
    //
    //    CGFloat currentVersion = [infoDictionary[KEY_VERSION] doubleValue];
    CGFloat currentVersion = [JHUtils appVersion];
    //保存到偏好设置里面去
    [[NSUserDefaults standardUserDefaults] setObject:@(currentVersion) forKey:KEY_VERSION];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //进入主页
    ViewController *Ctrl = [[ViewController alloc] init];
    //设置跟控制器
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window setRootViewController:Ctrl];
    
//    UITabBarController *tabbarCtrl = [[UITabBarController alloc] init];
//    //    设置根控制器
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    [window setRootViewController:tabbarCtrl];
}


#pragma mark - scrollView的delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.x);
    CGFloat page = scrollView.contentOffset.x/scrollView.width;
    self.control.currentPage = (int)(page+0.5);
}


@end
