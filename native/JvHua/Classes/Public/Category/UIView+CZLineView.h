//
//  UIView+CZLineView.h
//  PreWallet
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CZLineView)

+ (UIView *)grayLineViewWithFrame:(CGRect)frame;

+ (UIView *)lineViewWithColor:(UIColor *)color andFrame:(CGRect)frame;

@end
