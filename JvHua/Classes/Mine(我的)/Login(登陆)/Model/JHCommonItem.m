//
//  JHCommonItem.m
//  JvHua
//
//  Created by 乔耐 on 15/11/19.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHCommonItem.h"

@implementation JHCommonItem

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        self.title = title;
    }
    return self;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [[self alloc] initWithTitle:title];
}


- (instancetype)initWithIcon:(NSString *)icon Title:(NSString *)title
{
    if (self = [super init]) {
        self.title = title;
        self.icon = icon;
    }
    return self;
    
}

+ (instancetype)itemWithIcon:(NSString *)icon Title:(NSString *)title
{
    return [[self alloc] initWithIcon:icon Title:title];
}


@end
