//
//  JHComposeView.h
//  JvHua
//
//  Created by 乔耐 on 15/11/27.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHComposeView : UITextView

/** 需要提示的内容 */
@property (copy, nonatomic) NSString *placeholder;
/** 设置提示框的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;

@end
