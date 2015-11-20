//
//  JHPersonal.m
//  JvHua
//
//  Created by 乔耐 on 15/11/17.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHPersonal.h"

@implementation JHPersonal

+ (instancetype)personalWithDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    if(self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}


@end
