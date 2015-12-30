//
//  JHDisplayTool.h
//  JvHua
//
//  Created by 乔耐 on 15/12/30.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHDisplayTool : NSObject
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSMutableArray *leftData;

@property (nonatomic, strong) NSMutableArray *rightData;

- (NSMutableArray *)getDataWith:(NSString *)key;
@end
