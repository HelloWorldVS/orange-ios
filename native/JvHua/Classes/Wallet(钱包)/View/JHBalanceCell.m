//
//  JHBalanceCell.m
//  JvHua
//
//  Created by 乔耐 on 15/12/29.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHBalanceCell.h"
#import "Masonry.h"

@interface JHBalanceCell()
//控件属性
@property (nonatomic, strong) UILabel *cashLabel;


@end
@implementation JHBalanceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIButton *cashButton = [[UIButton alloc] init];
        cashButton.frame = CGRectMake(0, 0,self.bounds.size.width, 160);
        cashButton.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:cashButton];
        
        UILabel *cashLabel1 = [[UILabel alloc] init];
        self.cashLabel = cashLabel1;
        [self.contentView addSubview:cashLabel1];
        
        UILabel *cashLabel2 = [[UILabel alloc] init];
        self.cashLabel = cashLabel2;
        [self.contentView addSubview:cashLabel2];

        
        //设置约束
        [cashButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGRectMake(0, 0, self.bounds.size.width, 200));
            make.left.equalTo(@(1));
            make.right.equalTo(@(1));
            make.top.equalTo(@(1));
            make.height.equalTo(@(160));
        }];
        
        [cashLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
//            make.centerX.equalTo(self.mas_centerX);
//            make.centerY.equalTo(self.mas_centerY);
//            make.top.equalTo(@(25));
//            make.bottom.equalTo(@(-35));

            make.centerX.equalTo(@(0));
            make.centerY.equalTo(@(-50));
            make.width.equalTo(@(150));
            make.height.equalTo(@(35));
            
        }];
        
        [cashLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
//            make.centerX.equalTo(cashLabel1);
//            make.centerY.equalTo(self.mas_centerY);
//            make.top.equalTo(cashLabel1.mas_bottom);
//            make.bottom.equalTo(@(-35));

            make.centerX.equalTo(cashLabel1);
            make.top.equalTo(cashLabel1.mas_bottom).offset(15);
            make.width.equalTo(@(100));
            make.height.equalTo(@(35));
        }];

        
        cashLabel1.text = @"现金账户余额(元)";
        cashLabel1.font = [UIFont systemFontOfSize:16];
        cashLabel1.textColor = [UIColor whiteColor];
        cashLabel1.textAlignment=NSTextAlignmentCenter;
        
        
        cashLabel2.text = @"0.00";
        cashLabel2.font = [UIFont systemFontOfSize:40];
        cashLabel2.textColor = [UIColor whiteColor];
        cashLabel2.textAlignment=NSTextAlignmentCenter;
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
