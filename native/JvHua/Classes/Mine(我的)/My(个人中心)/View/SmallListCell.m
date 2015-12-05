//
//  SmallListCell.m
//  JvHua
//
//  Created by 乔耐 on 15/12/5.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "SmallListCell.h"
#import "Masonry.h"

@interface SmallListCell()
@end

@implementation SmallListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        //__creat&make SUBRelations__
        UIImageView *iconImageView=[[UIImageView alloc]init];
        self.iconImageView=iconImageView;
        [self.contentView addSubview:iconImageView];
        
        UILabel *titleLabel=[[UILabel alloc]init];
        self.titleLabel=titleLabel;
        [self.contentView addSubview:titleLabel];
        
        
        //__makingConstraints__
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(15));
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(@(15));
            make.width.equalTo(@(20));
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconImageView.mas_right).offset(15);
            make.centerY.equalTo(self.mas_centerY);
            make.width.equalTo(@(100));
            make.height.equalTo(@(30));
        }];
        
    //__settingDatas__
        
    //===复用smallCell,在控制器中创建的时候设置===
    
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
