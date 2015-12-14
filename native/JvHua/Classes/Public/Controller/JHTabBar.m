//
//  JHTabBar.m
//  JvHua
//
//  Created by 乔耐 on 15/11/24.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHTabBar.h"
#import "JHTabBarButton.h"


@interface JHTabBar()
@property (nonatomic, strong) NSMutableArray *tabBarButtons;


@end

@implementation JHTabBar
/**
 *  数组的懒加载
 */
- (NSMutableArray *)tabBarButtons
{
    if (!_tabBarButtons) {
        self.tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置背景
        [self setupBg];
    }
    return self;
}

/**
 *  添加一个选项卡按钮
 *
 *  @param item 选项卡按钮对应的模型数据(标题\图标\选中的图标)
 */
- (void)addTabBarButton:(UITabBarItem *)item
{
    // 创建按钮
    JHTabBarButton *button = [[JHTabBarButton alloc] init];
    button.item = item;
    [button addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchDown];
    button.tag = self.tabBarButtons.count;
    [self addSubview:button];
    
    // 加到数组中
    [self.tabBarButtons addObject:button];
    
    // 默认让最前面的按钮选中
    if (self.tabBarButtons.count == 1) {
        [self tabBarButtonClick:button];
    }
}

/**
 *  点击选项卡按钮
 */
- (void)tabBarButtonClick:(JHTabBarButton *)button
{
    
    
    
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:btn:oldBtn:)]) {
        NSInteger from = self.selectedTabBarButton.tag;
        NSInteger to = button.tag;
        [self.delegate tabBar:self didSelectButtonFrom:from to:to btn:button oldBtn:self.selectedTabBarButton];
    }
    
    BOOL isLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:@"checkLogin"] boolValue];
    
    if (isLogin) {
        // 更改按钮状态
        self.selectedTabBarButton.selected = NO;
        button.selected = YES;
        self.selectedTabBarButton = button;
    } else {
        if (button.tag != 5) {
            self.selectedTabBarButton.selected = NO;
            button.selected = YES;
            self.selectedTabBarButton = button;
        }
    }
    
    
    
}

/**
 *  设置背景
 */
- (void)setupBg
{
    
    //    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
}

/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 2.设置选项卡按钮的位置和尺寸
    [self setupTabBarButtonFrame];
}

/**
 *  设置选项卡按钮的位置和尺寸
 */
- (void)setupTabBarButtonFrame
{
    NSUInteger count = self.tabBarButtons.count;
    CGFloat buttonW = self.width / count;
    CGFloat buttonH = self.height;
    for (int i = 0; i < count; i++) {
        JHTabBarButton *button = self.tabBarButtons[i];
        button.width = buttonW;
        button.height = buttonH;
        button.x = buttonW * i;
        button.y = 0;
    }
}

@end
