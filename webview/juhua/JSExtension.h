//
//  JSExtension.h
//  juhua
//
//  Created by  ChenTaiyu on 15/12/1.
//  Copyright (c) 2015年 juzi. All rights reserved.
//

#import <Foundation/Foundation.h>
@import JavaScriptCore;
#import "ViewController.h"

@protocol JSExtensionJS <JSExport>

- (void)appPayWithType:(NSString *)type targetID:(NSString *)targetID payChannel:(NSString *)payChannel payPwd:(NSString *)payPwd;

@end

@interface JSExtension : NSObject <JSExtensionJS>

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *targetID;
@property (nonatomic, strong) NSString *payChannel;
@property (nonatomic, strong) NSString *payPwd;

@property (nonatomic, weak) ViewController *vc;


+ (instancetype)sharedInstance;

@end
