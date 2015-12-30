//
//  JHHeaderButton.h
//  JvHua
//
//  Created by 乔耐 on 15/12/30.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定义headerButton的类型
typedef NS_ENUM(NSInteger, CZHeaderButtonType) {
    CZHeaderButtonTypeShop = 1,
    CZHeaderButtonTypeCircle,
    CZHeaderButtonTypeSort
};

@interface JHHeaderButton : UIButton

@property (nonatomic, assign) BOOL hideLine;

@end
