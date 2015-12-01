//
//  JHItemArrow.h
//  JvHua
//
//  Created by 乔耐 on 15/11/27.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHItem.h"

@interface JHItemArrow : JHItem

////记录跳转的目标控制器
//@property (nonatomic, assign) Class destController;
////记录一个执行的方法
//@property (nonatomic, copy) CZItemArrowOption option;

+ (instancetype)itemWithTitle:(NSString *)title destController:(Class)destController;

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon destController:(Class)destController;

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon option:(JHItemArrowOption)option;

@end
