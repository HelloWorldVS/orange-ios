//
//  OZHNetWork.h
//  JvHua
//
//  Created by 乔耐 on 15/11/5.
//  Copyright © 2015年 juzi. All rights reserved.
//


#ifndef yiduoduo_Interface_h
#define yiduoduo_Interface_h


#pragma mark -

//测试地址  域名出来后进行更换
#define KMainInterface @"http://www.yddmi.com/"
#define KTestInterface @"http://192.168.199.180:82/"

#define KImageInterface @"http://www.yddmi.com/images/WallImages/imagepath/"

//首页
#define KHomeURL @"http://www.yddmi.com/WebServices/Ydd_Consultation.asmx/GetIndex"



#define KCaseId @"?ClassId=%%@"


//用户信息数据
#define KUserInfoURL @"http://api.juhuaba.com/api/user/info"


#pragma mark - 登陆注册
//登陆
#define KLoginURL @"http://api.juhuaba.com/api/user/login"

//注册
#define KRegisterYZURL @"http://api.juhuaba.com/api/user/getCode/"
#define KRegisterSendURL @"http://api.juhuaba.com/api/user/getCode/"
#define KUserRegisterURL @"http://api.juhuaba.com/api/user/register"



//检查token是否有效(要换地址)
#define DK_API_FOR_IS_TOKEN @"v1/oauth/check_token"
//修改密码
#define KChangePassWordURL @"http://www.yddmi.com/WebServices/Ydd_Consultation.asmx/UpdatePwd"
//忘记密码
#define KFindPassWordURL @"http://www.yddmi.com/WebServices/Ydd_Consultation.asmx/FindPwd"

#pragma mark - 完善用户信息

#define KPostUserInfo @"http://www.yddmi.com/WebServices/Ydd_User.asmx/UpdateUserInfo"
#define KValidateDoctor @"http://www.yddmi.com/WebServices/Ydd_User.asmx/ValidateDoctor"
//#define KValidateDoctor @"http://192.168.199.180:82/WebServices/Ydd_User.asmx/ValidateDoctor"

#endif
