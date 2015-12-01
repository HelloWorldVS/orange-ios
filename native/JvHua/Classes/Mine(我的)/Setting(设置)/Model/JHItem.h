//
//  JHItem.h
//  JvHua
//
//  Created by 乔耐 on 15/11/27.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^JHItemArrowOption)();
@interface JHItem : NSObject
//记录跳转的目标控制器
@property (nonatomic, assign) Class destController;
//记录一个执行的方法
@property (nonatomic, copy) JHItemArrowOption option;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *time;

+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle;

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;


@end
