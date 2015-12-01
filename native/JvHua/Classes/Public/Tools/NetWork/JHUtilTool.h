//
//  DKUtilTool.h
//  dadadaka
//
//  Created by 大咖 on 15/4/23.
//  Copyright (c) 2015年 daka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHUtilTool : NSObject
/**
 *  判断是否有网络连接
 *
 *  @return bool类型
 */
+ (BOOL)isConnectionAvailable;

/**
 *  通过返回的data拿到字典
 *
 *  @param data             sever返回的数据
 *  @return 字典
 */
+ (NSDictionary*)dictionaryWithData:(NSData*)data;

/**
 *  只检查是否登录
 *
 *  @param success 登录成功
 *  @param failure 登录失败
 */
+ (void)checkLoginviewController:(UIViewController*)vc success:(SUCCESS_LOGIN)success failure:(FAILURE_LOGIN)failure ;

/**
 *  删除指定路径下的文件
 *
 *  @param filePath
 */
+ (void)removeFileAtPath:(NSString *)filePath;

/**
 *  拼接路径
 *
 *  @param fileName
 *
 *  @return nsstring类型
 */
+ (NSString*)filePath:(NSString*)fileName;


/**
 *  保存账号和密码
 *
 *  @param phone
 *  @param password
 */
+ (void)savePhone:(NSString*)phone password:(NSString*)password;

/**
 *  删除账号和密码
 */
+ (void)removePassword;

/**
 *  保存用户名
 */
+ (void)saveUserName:(NSString*)userName;
/**
 *   获取用户名
 */
+ (NSString *)getUserName;
/**
 *  删除用户名
 */
+ (void)removeUserName;

/**
 *  保存用户名ID
 */
+ (void)saveUserID:(NSString*)userID;
/**
 *   获取用户名ID
 */
+ (NSString *)getUserID;
/**
 *  删除用户名ID
 */
+ (void)removeUserID;


/**
 *  保存头像
 */
+ (void)saveUserIcon:(NSString*)userIcon;
/**
 *   获取头像名
 */
+ (NSString *)getUserIcon;
/**
 *  删除token
 */
+ (void)removeToken;


/**
 *  保持buid 和 sid
 *
 *  @param buid
 *  @param sid
 */
+ (void)saveUserToken:(NSString*)token;

/**
 *  获取token
 */
+ (NSString *)getCurrentToken;

/**
 删除过期的token
 */
+ (void)removeLastToken;

+ (void)clear;

@end
