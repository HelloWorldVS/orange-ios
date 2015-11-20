//
//  JHCommonCell.h
//  JvHua
//
//  Created by 乔耐 on 15/11/19.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHCommonItem;

@interface JHCommonCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 数据模型 */
@property (nonatomic, strong) JHCommonItem *item;


@end
