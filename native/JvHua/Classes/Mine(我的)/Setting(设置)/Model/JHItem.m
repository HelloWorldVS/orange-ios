//
//  JHItem.m
//  JvHua
//
//  Created by 乔耐 on 15/11/27.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHItem.h"

@implementation JHItem
+ (instancetype)itemWithTitle:(NSString *)title{
    JHItem *item = [[self alloc] init];
    item.title = title;
    return item;
}
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle{
    JHItem *item = [self itemWithTitle:title];
    item.subTitle = subTitle;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon{
    JHItem *item = [self itemWithTitle:title];
    item.icon = icon;
    return item;
}


@end
