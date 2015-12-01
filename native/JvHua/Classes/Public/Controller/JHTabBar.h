//
//  JHTabBar.h
//  JvHua
//
//  Created by 乔耐 on 15/11/24.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JHTabBar, JHTabBarButton;

@protocol JHTabBarDelegate <NSObject>
@optional
- (void)tabBar:(JHTabBar *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to btn:(JHTabBarButton *)btn oldBtn:(JHTabBarButton *)oldBtn;

@end

@interface JHTabBar : UIView
/**
 *  添加一个选项卡按钮
 *
 *  @param item 选项卡按钮对应的模型数据(标题\图标\选中的图标)
 */
- (void)addTabBarButton:(UITabBarItem *)item;

@property (nonatomic, weak) id<JHTabBarDelegate> delegate;
@property (nonatomic, weak) JHTabBarButton *selectedTabBarButton;
@end