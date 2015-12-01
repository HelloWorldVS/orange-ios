//
//  UIBarButtonItem+Extension.h
//  橘花
//
//  Created by 乔耐 on 15/10/15.
//  Copyright (c) 2015年 橘子星球网络科技有限公司. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/**
 *  初始化一个UIBarButtonItem
 *
 *  @param image    默认图片
 *  @param hltImage 高亮
 */
+ (UIBarButtonItem *)itemWithImage:(NSString *)image hltImage:(NSString *)hltImage target:(id)target action:(SEL)action;


+ (UIBarButtonItem *)itemWithImage:(NSString *)image hltImage:(NSString *)hltImage target:(id)target action:(SEL)action title:(NSString *)title;

/**
 *  快速创建自定义UIBarButtonItem
 *
 *  @param imageName            默认状态图片
 *  @param highlightedImageName 高亮状态图片
 *  @param target        监听方法调用者
 *  @param sel           监听按钮方法
 */
+ (instancetype)barButtonItemWithImageName:(NSString *)imageName  target:(id)target sel:(SEL)sel;

@end
