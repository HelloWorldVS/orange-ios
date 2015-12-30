//
//  JHHeaderButton.m
//  JvHua
//
//  Created by 乔耐 on 15/12/30.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHHeaderButton.h"

#define kHeaderImageWidth 10
@interface JHHeaderButton()
{
    UIView *_rightLineView;
}
@end

@implementation JHHeaderButton


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self setTitleColor:rgbColor(0xe8ae26) forState:UIControlStateSelected];
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [self setImage:[UIImage imageNamed:@"orderDownArrow"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"orderUpArrow"] forState:UIControlStateSelected];
        
        
        [self addRightLineView];
    }
    
    return self;
}

- (void)setHideLine:(BOOL)hideLine {
    _rightLineView.hidden = hideLine;
}

- (void)addRightLineView {
    CGFloat lineX = kViewSize.width - kNormalLineHeight;
    
    _rightLineView = [UIView grayLineViewWithFrame:CGRectMake(lineX, kMargin, kNormalLineHeight, kViewSize.height - 2 * kMargin)];
    
    [self addSubview:_rightLineView];
}

- (void)setHighlighted:(BOOL)highlighted {
    
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageX = kViewSize.width - kMargin - kHeaderImageWidth;
    CGFloat imageY = (kViewSize.height - kHeaderImageWidth) / 2;
    
    return CGRectMake(imageX, imageY, kHeaderImageWidth, kHeaderImageWidth);
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    return CGRectMake(0, 0, kViewSize.width * 0.8, kViewSize.height);
}



@end
