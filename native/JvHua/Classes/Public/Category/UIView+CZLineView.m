//
//  UIView+CZLineView.m
//  PreWallet
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UIView+CZLineView.h"

@implementation UIView (CZLineView)


+ (UIView *)lineViewWithColor:(UIColor *)color andFrame:(CGRect)frame {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    [view setBackgroundColor:color];
    
    return view;
    
}
+ (UIView *)grayLineViewWithFrame:(CGRect)frame {
    
    
    return [self lineViewWithColor:[UIColor grayColor] andFrame:frame];
}
@end
