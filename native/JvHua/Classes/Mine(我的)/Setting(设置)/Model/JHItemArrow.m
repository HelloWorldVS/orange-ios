//
//  JHItemArrow.m
//  JvHua
//
//  Created by 乔耐 on 15/11/27.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHItemArrow.h"

@implementation JHItemArrow
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon destController:(Class)destController{
    JHItemArrow *item = [super itemWithTitle:title icon:icon];
    item.destController = destController;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon option:(JHItemArrowOption)option{
    JHItemArrow *item = [super itemWithTitle:title icon:icon];
    item.option = option;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title destController:(Class)destController{
    JHItemArrow *item = [self itemWithTitle:title icon:nil destController:destController];
    return item;
}

@end
