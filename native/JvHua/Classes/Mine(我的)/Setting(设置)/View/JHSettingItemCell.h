//
//  JHSettingItemCell.h
//  JvHua
//
//  Created by 乔耐 on 15/11/27.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHItem;
@interface JHSettingItemCell : UITableViewCell
@property (nonatomic, strong) JHItem *item;


+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;

@end
