//
//  IWHomeTitleButton.m
//  WeiBo
//
//  Created by apple on 15/7/10.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "JHHomeTitleButton.h"
#import "UIView+extension.h"

@implementation JHHomeTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //先调整label的位置
    self.titleLabel.x = 0;
    
    //再调整imageView的位置
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
    
    //下面这句代码会产生递归调用
//    [self sizeToFit];
    
    //尽量不要在layoutSubviews这个方法里面去调整自己的位置
    self.width = self.titleLabel.width + self.imageView.width +5;
    self.centerX = self.superview.centerX;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    
//    [self sizeToFit];
//    self.width = self.titleLabel.width + self.imageView.width +5;
    [self adjustSize];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    [self adjustSize];
}

/**
 *  调整size
 */
- (void)adjustSize{
    [self sizeToFit];
    self.width = self.titleLabel.width + self.imageView.width +5;
}

@end
