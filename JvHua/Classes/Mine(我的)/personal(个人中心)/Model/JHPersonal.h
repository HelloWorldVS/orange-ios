//
//  JHPersonal.h
//  JvHua
//
//  Created by 乔耐 on 15/11/17.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHPersonal : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;

+ (instancetype)personalWithDic:(NSDictionary *)dic;
- (instancetype)initWithDic:(NSDictionary *)dic;

@end
