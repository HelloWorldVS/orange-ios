//
//  JHGroup.h
//  JvHua
//
//  Created by 乔耐 on 15/11/27.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHGroup : NSObject

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSString *footer;


+ (instancetype)groupWithItems:(NSArray *)items;
+ (instancetype)groupWithItems:(NSArray *)items header:(NSString *)header;
+ (instancetype)groupWithItems:(NSArray *)items footer:(NSString *)footer;

+ (instancetype)groupWithItems:(NSArray *)items header:(NSString *)header footer:(NSString *)footer;

@end
