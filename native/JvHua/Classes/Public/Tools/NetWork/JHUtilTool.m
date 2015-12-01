//
//  DKUtilTool.m
//  dadadaka
//
//  Created by 乔耐 on 15/11/24.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHUtilTool.h"

@implementation JHUtilTool

#pragma mark - 判断网络是否连接
+ (BOOL)isConnectionAvailable {
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
    }
    return isExistenceNetwork;
}

#pragma mark - 将拿到的data转化为dictionary

+ (NSDictionary*)dictionaryWithData:(NSData*)data{
    NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (str != nil && ![str isEqualToString:@""]) {
        NSString* json = str;
        NSError *error = nil;
        NSMutableDictionary* dic = [[NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSASCIIStringEncoding]
                                                                    options:NSJSONReadingAllowFragments
                                                                      error:&error] mutableCopy];
        return dic;
    } else
        return nil;
}

+ (void)checkLoginviewController:(UIViewController *)vc success:(SUCCESS_LOGIN)success failure:(FAILURE_LOGIN)failure
{
    BOOL isLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:@"checkLogin"] boolValue];
    if (isLogin) {
        success();
    } else {
        failure();
    }
}

#pragma mark - 删除指定路径下的文件
+ (void)removeFileAtPath:(NSString *)filePath {
    NSError *error = nil;
    if ([JHUtilTool filePath: filePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:[JHUtilTool filePath: filePath] error:&error];
        
        if (error) {
            DKLog(@"移除文件失败，错误信息：%@", error);
        }
        else {
            DKLog(@"成功移除文件");
        }
    }
    else {
        DKLog(@"文件不存在");
    }
}

#pragma mark - 拼接路径
+ (NSString*)filePath:(NSString*)fileName {
    NSString *archiveDirPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/Information"];
    
    NSError* error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:archiveDirPath]) {
        
        if (![[NSFileManager defaultManager] createDirectoryAtPath:archiveDirPath
                                       withIntermediateDirectories:YES
                                                        attributes:nil
                                                             error:&error])
        {
            DKLog(@"Create directory tmp/cachedModels directory error: %@", error);
            return nil;
        }
    }
    
    NSString *archivePath = [archiveDirPath stringByAppendingFormat:@"/%@", fileName];
    return archivePath;
}

#pragma mark - 保存账号和密码
+ (void)savePhone:(NSString*)phone password:(NSString*)password {
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
}

#pragma mark - 删除账号和密码
+ (void)removePassword {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
}

#pragma mark - 保存用户名
+ (void)saveUserName:(NSString*)userName {
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"userName"];
}
#pragma mark
#pragma mark - 获取用户名

+ (NSString *)getUserName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
}

+ (void)removeUserName
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
}

#pragma mark 保存头像
+ (void)saveUserIcon:(NSString*)userIcon
{
    [[NSUserDefaults standardUserDefaults] setObject:userIcon forKey:@"userIcon"];
}
#pragma mark 获取头像
+ (NSString *)getUserIcon
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userIcon"];
}
#pragma mark - 保存token

+ (void)saveUserToken:(NSString *)token
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *phoneAndKey = [JHUtilTool filePath:@"properties.plist"];
    [array addObject:token];
    [array writeToFile:phoneAndKey atomically:YES];
}


#pragma mark
#pragma mark - 删除token

+ (void)removeToken {
    [self removeFileAtPath:@"properties.plist"];
}

#pragma mark 删除过期的token
+ (void)removeLastToken
{
    if ([JHUtilTool getCurrentToken]) {
        NSDictionary *dict = @{
                               @"token" : [JHUtilTool getCurrentToken]
                               };
        [JHHttpTool getWithURL:DK_API_FOR_IS_TOKEN params:dict success:^(id json) {
            if ([json[@"code"] integerValue] == 901) {
                DKLog(@"----.token过期----");
                [JHUtilTool removeToken];
            } else if ([json[@"code"] integerValue] == 902) {
                DKLog(@"----token不存在----");
                [JHUtilTool removeToken];
            } else if ([json[@"code"] integerValue] == 903) {
                DKLog(@"----token有效----");
            } else if ([json[@"code"] integerValue] == 904) {
                DKLog(@"----token值参数为空----");
            }
        } failure:^(NSError *error) {
            
        }];
    }

}

#pragma mark
#pragma mark - 获取sid

+ (NSString *)getCurrentToken {
    NSString* fileName = [JHUtilTool filePath:@"properties.plist"];
    NSString *token = nil;
    if ([[NSFileManager defaultManager]fileExistsAtPath:fileName]) {
        NSArray* dataArray = [[NSArray alloc]initWithContentsOfFile:fileName];
        token = [dataArray objectAtIndex:0];
    }
    return token;
}

+ (void)clear
{
    // 1.清除内存中的缓存图片
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache]cleanDisk];

    
    // 2.取消所有的下载请求
    [[SDWebImageManager sharedManager] cancelAll];
}
/**
 *  保存用户名ID
 */
+ (void)saveUserID:(NSString *)userID
{
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:@"userid"];
}
/**
 *   获取用户名ID
 */
+ (NSString *)getUserID
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
}
/**
 *  删除用户名ID
 */
+ (void)removeUserID
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userid"];
}

@end
