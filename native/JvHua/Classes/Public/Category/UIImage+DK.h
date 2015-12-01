//
//  UIImage+DK.h
//  dadadaka
//
//  Created by 大咖 on 15/4/9.
//  Copyright (c) 2015年 daka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DK)
/**
 *  返回一张图片
 *
 *  @param name 图片名
 */
+ (instancetype)imageWithName:(NSString *)name;

/**
 *  返回一张能自由拉伸的图片
 *
 *  @param name 图片名
 *
 */
+ (instancetype)resizableImage:(NSString *)name;

/**
 *  返回一张能自由拉伸的图片
 *
 *  @param name      图片名
 *  @param leftRatio 左边有多少比例不需要拉伸(0~1)
 *  @param topRatio  顶部有多少比例不需要拉伸(0~1)
 *
 */
+ (instancetype)resizableImage:(NSString *)name leftRatio:(CGFloat)leftRatio topRatio:(CGFloat)topRatio;

/**
 *  等比例缩放
 *
 *  @param size 大小
 *
 *  @return 图片
 */
- (UIImage*)scaleToSize:(CGSize)size;

/**
 *  获取网络图片的大小
 *
 *  @param imageURL 图片的名称
 *
 *  @return 图片的大小
 */
+(CGSize)downloadImageSizeWithURL:(id)imageURL;
@end
