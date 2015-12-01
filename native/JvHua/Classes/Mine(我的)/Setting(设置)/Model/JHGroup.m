//
//  JHGroup.m
//  JvHua
//
//  Created by 乔耐 on 15/11/27.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHGroup.h"

@implementation JHGroup


+ (instancetype)groupWithItems:(NSArray *)items{
    JHGroup *group = [[self alloc] init];
    group.items = items;
    return group;
}

+ (instancetype)groupWithItems:(NSArray *)items header:(NSString *)header{
    JHGroup *group = [self groupWithItems:items header:header footer:nil];
    return group;
}
+ (instancetype)groupWithItems:(NSArray *)items footer:(NSString *)footer{
    JHGroup *group = [self groupWithItems:items header:nil footer:footer];
    return group;
}
+ (instancetype)groupWithItems:(NSArray *)items header:(NSString *)header footer:(NSString *)footer{
    JHGroup *group = [self groupWithItems:items];
    group.header = header;
    group.footer = footer;
    return group;
}

@end
