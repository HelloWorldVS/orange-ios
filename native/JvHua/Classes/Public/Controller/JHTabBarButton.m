//
//  JHTabBarButton.m
//  JvHua
//
//  Created by 乔耐 on 15/11/24.
//  Copyright © 2015年 juzi. All rights reserved.
//
#define IWTabBarButtonImageRatio 0.6
#import "JHTabBarButton.h"

@interface JHTabBarButton()
@end

@implementation JHTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 文字大小
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        
        // 文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:KGreenColor forState:UIControlStateSelected];
        
    }
    return self;
}

// 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = self.width;
    CGFloat imageH = self.height * IWTabBarButtonImageRatio;
    return CGRectMake(0, 6, imageW, imageH);
}

// 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = self.height * IWTabBarButtonImageRatio + 6;
    CGFloat titleW = self.width;
    CGFloat titleH = self.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    // 文字
    [self setTitle:item.title forState:UIControlStateNormal];
    // 图标
    [self setImage:item.image forState:UIControlStateNormal];
    // 选中的图标
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    
    // self监听item的4个属性值的改变
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
}

#pragma mark 一定要移除监听器
- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}

/**
 *  当利用KVO监听到某个对象的属性改变了, 就会调用这个方法
 *
 *  @param keyPath 被改变的属性的名称
 *  @param object  被监听的那个对象
 *  @param change  存放者被改变属性的值
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    // 2.设置按钮的文字
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];
    
    // 3.设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
}

- (void)setHighlighted:(BOOL)highlighted {
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
@end
