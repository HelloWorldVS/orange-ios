//
//  OZHNetWork.m
//  JvHua
//
//  Created by 乔耐 on 15/11/5.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "OZHNetWork.h"
#import "AFNetworking.h"
#import "Interface.h"

@implementation OZHNetWork

/**
 网络请求控制器
 */
+(instancetype)sharedNetworkTools
{
    static OZHNetWork *tools;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        
        tools = [[OZHNetWork alloc]init];
        
        
        
    });
    return tools;
}


/**
 登陆
 */
- (void)LoginWithUserName:(NSString *)username AndPassWord:(NSString *)password Success:(successBlock)success andFailure:(failureBlock)failure
{
    // TODO: 这里还有一个可选参数 registerId，根据需求改
    NSDictionary *para = @{@"loginName":username,@"password":password};
    
    AFHTTPRequestOperationManager *OperationManager = [AFHTTPRequestOperationManager manager];
    
    OperationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [OperationManager POST:KLoginURL parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success(self,@{@"msg" : (operation.responseString ? operation.responseString : @"")});
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (operation.responseString) {
            success(self, [self dictionaryWithJsonStr:operation.responseString]);
        } else {
            failure(self,error);
        }
    }];
}

/**
 获取用户信息
 */
- (void)getUserInfomationWithId:(NSString *)Id Success:(successBlock)success andFailure:(failureBlock)failure {
    // TODO: 你们的api不需要传用户id什么的，要是信息出不来问问后台那边请求头要带什么过去
    //    NSDictionary *para = @{@"UserId":Id};
    
    AFHTTPRequestOperationManager *OperationManager = [AFHTTPRequestOperationManager manager];
    
    OperationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [OperationManager POST:KUserInfoURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //KBG格式
        NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
        NSDictionary *jsonDict = [self StringToJsonDictWithJsonString:[[NSString alloc] initWithData:responseObject encoding:encoding]];
        
        success(self,jsonDict);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (operation.responseString) {
            success(self, [self dictionaryWithJsonStr:operation.responseString]);
        } else {
            failure(self,error);
        }
    }];
}

/**
 注册验证手机号
 */
- (void)testCellPhoneNumber:(NSString *)phoneNumber withSuccess:(successBlock)success andFailure:(failureBlock)failure {
    
    NSDictionary *para = @{ @"register" : @0
                            };
    
    AFHTTPRequestOperationManager *OperationManager = [AFHTTPRequestOperationManager manager];
    
    OperationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *requestURL = [KRegisterYZURL stringByAppendingString:phoneNumber];
    [OperationManager POST:requestURL parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //KBG格式
        NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
        NSDictionary *dict = [self dictionaryWithJsonStr:[[NSString alloc] initWithData:responseObject encoding:encoding]];
        
        success(self,dict);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (operation.responseString) {
            success(self, [self dictionaryWithJsonStr:operation.responseString]);
        } else {
            failure(self,error);
        }
    }];
    
}

/**
 注册发送手机验证码
 */
- (void)sendIdentifyingCodeWithPhoneNumber:(NSString *)phoneNumber withSuccess:(successBlock)success andFailure:(failureBlock)failure {
    NSDictionary *para = @{ @"register" : @1
                            };
    
    AFHTTPRequestOperationManager *OperationManager = [AFHTTPRequestOperationManager manager];
    
    OperationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *requestURL = [KRegisterSendURL stringByAppendingString:phoneNumber];
    
    [OperationManager POST:requestURL parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success(self,@{@"msg" : (operation.responseString ? operation.responseString : @"")});
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (operation.responseString) {
            success(self, [self dictionaryWithJsonStr:operation.responseString]);
        } else {
            failure(self,error);
        }
        
    }];
}
/**
 注册提交注册信息
 */

- (void)postRegisterUserInfoWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password code:(NSString *)code withSuccess:(successBlock)success andFailure:(failureBlock)failure {
    
    NSDictionary *para = @{@"telephone":phoneNumber,
                           @"password":password,
                           @"code" : code
                           };
    
    AFHTTPRequestOperationManager *OperationManager = [AFHTTPRequestOperationManager manager];
    
    OperationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [OperationManager POST:KUserRegisterURL parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success(self,@{@"msg" : (operation.responseString ? operation.responseString : @"")});
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (operation.responseString) {
            NSDictionary *dict = [self dictionaryWithJsonStr:operation.responseString];
            success(self, dict);
        } else {
            failure(self,error);
        }
    }];
}

- (void)changePassWordWithUserID:(NSString *)ID andNew:(NSString *)newPW andSuccess:(successBlock)success andFailure:(failureBlock)failure {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:KChangePassWordURL parameters:@{@"UserId":ID,@"NewPwd":newPW} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
        NSDictionary *jsonDict = [self StringToJsonDictWithJsonString:[[NSString alloc] initWithData:responseObject encoding:encoding]];
        
        success(self,jsonDict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(self,error);
    }];
}



- (void)findPassWordWithPhoneNumber:(NSString *)phoneNumber andNew:(NSString *)newPW andSuccess:(successBlock)success andFailure:(failureBlock)failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:KFindPassWordURL parameters:@{@"Tel":phoneNumber,@"NewPwd":newPW} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
        NSDictionary *jsonDict = [self StringToJsonDictWithJsonString:[[NSString alloc] initWithData:responseObject encoding:encoding]];
        
        success(self,jsonDict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(self,error);
    }];
}



#pragma mark - json字符串 转换
/**
 json字符串转为字典
 */
- (NSDictionary *)StringToJsonDictWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@"huiche"];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"<p>" withString:@"huiche"];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"<br />" withString:@"huiche"];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@"kongge"];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    //  jsonString = [jsonString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    
    
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        ////NSLog(@"字典json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/**
 json字符串转为数组
 */

- (NSArray *)StringToJsonArrayWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                   options:NSJSONReadingMutableContainers
                                                     error:&err];
    if(err) {
        ////NSLog(@"数组json解析失败：%@",err);
        return nil;
    }
    return arr;
}

- (NSDictionary *)dictionaryWithJsonStr:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&err];
    if(err) {
        NSLog(@"json serialze failed:  %@", err);
        return nil;
    }
    return dict;
}

@end
