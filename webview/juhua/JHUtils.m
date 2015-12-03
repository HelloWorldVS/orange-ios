//
//  JHUtils.m
//  juhua
//
//  Created by 乔耐 on 15/12/2.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHUtils.h"

@implementation JHUtils

+ (CGFloat)appVersion{
    NSDictionary *infoDictionary = [NSBundle mainBundle].infoDictionary;
    CGFloat currentVersion = [infoDictionary[@"CFBundleShortVersionString"] doubleValue];
    return currentVersion;
}

@end
