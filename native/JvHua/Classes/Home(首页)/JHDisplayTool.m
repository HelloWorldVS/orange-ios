//
//  JHDisplayTool.m
//  JvHua
//
//  Created by 乔耐 on 15/12/30.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHDisplayTool.h"

@interface JHDisplayTool ()

@end
@implementation JHDisplayTool
- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    
}

- (NSMutableArray *)leftData {
    
    _leftData = [NSMutableArray array];
    
    [_dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSDictionary *dict = obj;
        
        NSString *keys = [dict allKeys][0];
        
        [_leftData addObject:keys];
    }];
    
    return _leftData;
}

- (NSMutableArray *)rightData {
    _rightData = [NSMutableArray array];
    
    [_dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dict = obj;
        
        NSArray *values = [dict allValues][0];
        
        [values enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            [_rightData addObject:obj];
            
        }];
        
        *stop = YES;
        
    }];
    
    return _rightData;
}

- (NSMutableArray *)getDataWith:(NSString *)key {
    NSMutableArray *tempArray = [NSMutableArray array];
    [_dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dict = obj;
        NSString *innerKey = [dict allKeys][0];
        
        if ([key isEqualToString:innerKey]) {
            NSArray *valueArray = [dict allValues][0];
            [valueArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                [tempArray addObject:obj];
                
            }];
        }
    }];
    
    return tempArray;
}

@end
