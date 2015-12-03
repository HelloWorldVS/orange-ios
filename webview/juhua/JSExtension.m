//
//  JSExtension.m
//  juhua
//
//  Created by  ChenTaiyu on 15/12/1.
//  Copyright (c) 2015年 juzi. All rights reserved.
//

#import "JSExtension.h"
@import JavaScriptCore;

@implementation JSExtension

- (void)appPayWithType:(NSString *)type targetID:(NSString *)targetID payChannel:(NSString *)payChannel payPwd:(NSString *)payPwd
{
    self.type = type;
    self.targetID = targetID;
    self.payChannel = payChannel;
    self.payPwd = payPwd;
    
    //    [self.vc requestForCharge];
}

id _sharedInstance = nil;
+ (instancetype)sharedInstance
{
    if (!_sharedInstance) {
        _sharedInstance = [[self alloc] init];
    }
    return _sharedInstance;
}

@end
