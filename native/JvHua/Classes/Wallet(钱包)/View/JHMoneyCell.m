//
//  JHMoneyCell.m
//  JvHua
//
//  Created by 乔耐 on 15/12/29.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHMoneyCell.h"
#import "Masonry.h"
@implementation JHMoneyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        //__create&making SUBRelations__
        UILabel *creditLineLbl=[[UILabel alloc]init];
        self.creditLineLbl=creditLineLbl;
        [self.contentView addSubview:creditLineLbl];
        
        UILabel *usableLineLbl=[[UILabel alloc]init];
        self.usableLineLbl=usableLineLbl;
        [self.contentView addSubview:usableLineLbl];
        
        UILabel *creditLineDetailLbl=[[UILabel alloc]init];
        self.creditLineDetailLbl=creditLineDetailLbl;
        [self.contentView addSubview:creditLineDetailLbl];
        
        UILabel *usableLineDetailLbl=[[UILabel alloc]init];
        self.usableLineDetailLbl=usableLineDetailLbl;
        [self.contentView addSubview:usableLineDetailLbl];
        
        
        UIView *separatorLineView=[[UIView alloc]init];
        self.separatorLineView=separatorLineView;
        [self.contentView addSubview:separatorLineView];
        
        //__makingConstraints__
        
        [creditLineLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(15));
            make.height.equalTo(@(20));
            make.width.equalTo(@(150));
            make.left.equalTo(@(10));
        }];
        
        [creditLineDetailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(creditLineLbl.mas_bottom).offset(10);
            make.height.equalTo(@(15));
            make.centerX.equalTo(creditLineLbl.mas_centerX);
            make.width.equalTo(@(100));
        }];
        
        
        [usableLineLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(10));
            make.top.equalTo(creditLineLbl.mas_top);
            make.width.equalTo(creditLineLbl.mas_width);
            make.height.equalTo(creditLineLbl.mas_height);
        }];
        
        [usableLineDetailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(usableLineLbl.mas_centerX);
            make.top.equalTo(creditLineDetailLbl.mas_top);
            make.width.equalTo(creditLineDetailLbl.mas_width);
            make.height.equalTo(creditLineDetailLbl.mas_height);
        }];
        
        
        [separatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.top.equalTo(@(10));
            make.bottom.equalTo(@(-10));
            make.width.equalTo(@(0.5));
        }];
        
        //__settingDatas__
        creditLineDetailLbl.textColor=[UIColor redColor];
        creditLineDetailLbl.font=[UIFont systemFontOfSize:16];
        creditLineDetailLbl.text=@"5000";
        creditLineDetailLbl.textAlignment=NSTextAlignmentCenter;
        
        creditLineLbl.textColor=[UIColor lightGrayColor];
        creditLineLbl.text=@"信用账户可用额度(元)";
        creditLineLbl.font=[UIFont systemFontOfSize:14];
        
        usableLineDetailLbl.text=@"5000";
        usableLineDetailLbl.textColor=[UIColor redColor];
        usableLineDetailLbl.font=[UIFont systemFontOfSize:16];
        usableLineDetailLbl.textAlignment=NSTextAlignmentCenter;
        
        usableLineLbl.textColor=[UIColor lightGrayColor];
        usableLineLbl.text=@"信用账户已用额度(元)";
        usableLineLbl.font=[UIFont systemFontOfSize:14];
        
        separatorLineView.backgroundColor=[UIColor lightGrayColor];
        
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
