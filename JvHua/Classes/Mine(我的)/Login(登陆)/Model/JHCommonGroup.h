//
//  JHCommonGroup.h
//  JvHua
//
//  Created by 乔耐 on 15/11/19.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHCommonItem.h"

@interface JHCommonGroup : JHCommonItem

/** 所有的cell */
@property (nonatomic, strong) NSArray *items;

+ (instancetype)group;

@end
