//
//  OZHNetWork.h
//  JvHua
//
//  Created by 乔耐 on 15/11/5.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OZHNetWork;

typedef void(^httpRequestSuccess)(OZHNetWork *manager,NSArray *dataArr);

typedef void(^httpRequestFailure)(OZHNetWork *manager,NSError *error);


//OlivierZhang's Block
typedef void (^successBlock)(OZHNetWork *manager,NSDictionary * jsonDict);
typedef void (^failureBlock)(OZHNetWork *manager,NSError *error);

typedef void (^arrayBlock)(OZHNetWork *manager,NSArray *jsonArr);

typedef void (^deatilBlock)(OZHNetWork *manager,NSArray *jsonArr);
typedef void (^publishBlock)(OZHNetWork *manager,NSString *publishState);

typedef void (^responeBlock)(OZHNetWork *manager,id jsonObject);
@interface OZHNetWork : NSObject



/**
 网络请求控制器
 */
+ (instancetype)sharedNetworkTools;


/**
 登陆请求
 */
- (void)LoginWithUserName:(NSString *)username AndPassWord:(NSString *)password Success:(successBlock)success andFailure:(failureBlock)failure;

/**
 获取用户信息
 */
- (void)getUserInfomationWithId:(NSString *)Id Success:(successBlock)success andFailure:(failureBlock)failure;

//修改密码
- (void)changePassWordWithUserID:(NSString *)ID andNew:(NSString *)newPW andSuccess:(successBlock)success andFailure:(failureBlock)failure;

//找回密码
- (void)findPassWordWithPhoneNumber:(NSString *)phoneNumber andNew:(NSString *)newPW andSuccess:(successBlock)success andFailure:(failureBlock)failure;

/**
 注册验证手机号
 */
- (void)testCellPhoneNumber:(NSString *)phoneNumber withSuccess:(successBlock)success andFailure:(failureBlock)failure;

/**
 注册发送手机验证码
 */
- (void)sendIdentifyingCodeWithPhoneNumber:(NSString *)phoneNumber withSuccess:(successBlock)success andFailure:(failureBlock)failure;
/**
 注册提交注册信息
 */

- (void)postRegisterUserInfoWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password code:(NSString *)code withSuccess:(successBlock)success andFailure:(failureBlock)failure;

@end
