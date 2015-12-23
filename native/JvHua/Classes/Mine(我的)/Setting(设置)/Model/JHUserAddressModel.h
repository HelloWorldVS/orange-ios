//
//  JHUserAddressModel.h
//  JvHua
//
//  Created by 乔耐 on 15/12/17.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHUserAddressModel : NSObject

@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *consignee;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, copy) NSString *post_code;
@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *street;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *update_at;
@property (nonatomic, copy) NSString *user_id;

@end
