//
//  JHMoneyCell.h
//  JvHua
//
//  Created by 乔耐 on 15/12/29.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHMoneyCell : UITableViewCell
@property (nonatomic, strong) UILabel *creditLineLbl;
@property (nonatomic, strong) UILabel *usableLineLbl;
@property (nonatomic, strong) UILabel *creditLineDetailLbl;
@property (nonatomic, strong) UILabel *usableLineDetailLbl;

@property (nonatomic, strong) UIView *separatorLineView;

@end
