//
//  JHUtils.m
//  JvHua
//
//  Created by 乔耐 on 15/10/24.
//  Copyright (c) 2015年 juzi. All rights reserved.
//

#import "JHUtils.h"

@implementation JHUtils

+ (CGFloat)appVersion{
    NSDictionary *infoDictionary = [NSBundle mainBundle].infoDictionary;
    CGFloat currentVersion = [infoDictionary[@"CFBundleShortVersionString"] doubleValue];
    return currentVersion;
}

@end
