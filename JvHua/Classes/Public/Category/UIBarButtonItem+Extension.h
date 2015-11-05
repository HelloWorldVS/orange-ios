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

@end
