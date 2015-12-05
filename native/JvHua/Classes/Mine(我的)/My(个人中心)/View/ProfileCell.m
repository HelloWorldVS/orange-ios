//
//  ProfileCell.m
//  JvHua
//
//  Created by 乔耐 on 15/12/5.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "ProfileCell.h"
//三方约束
#import "Masonry.h"
@interface ProfileCell()
//控件属性
@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneNoLabel;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *barcodeButton;
@end
@implementation ProfileCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
    //__create & make subRelations__
        UIImageView *iconImgView=[[UIImageView alloc]init];
        self.iconImgView=iconImgView;
        [self.contentView addSubview:iconImgView];
        
        UILabel *nameLabel=[[UILabel alloc]init];
        self.nameLabel=nameLabel;
        [self.contentView addSubview:nameLabel];
        
        UIButton *barcodeButton=[[UIButton alloc]init];
        self.barcodeButton=barcodeButton;
        [self.contentView addSubview:barcodeButton];
        
        
        UILabel *phoneNoLabel=[[UILabel alloc]init];
        self.phoneNoLabel=phoneNoLabel;
        [self.contentView addSubview:phoneNoLabel];
        
        UIButton *confirmButton=[[UIButton alloc]init];
        self.confirmButton=confirmButton;
        [self.contentView addSubview:confirmButton];
        
        
        
    //__making constraints__
        [iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(15));
            make.top.equalTo(@(20));
            make.bottom.equalTo(@(-20));
//            make.height.equalTo(@(70));
//            make.height.equalTo(@(50));
            make.width.equalTo(@(50));
        }];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImgView.mas_right).offset(10);
            make.top.equalTo(@(24));
            make.width.equalTo(@(50));
            make.height.equalTo(@(25));
        }];
        
        [barcodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel.mas_right).offset(-5);
            make.top.equalTo(nameLabel.mas_top);
            make.height.equalTo(@(20));
            make.width.equalTo(@(20));
        }];
    
        [phoneNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel.mas_left);
            make.width.equalTo(@(150));
            make.height.equalTo(@(30));
            make.bottom.equalTo(@(-20));
        }];
        
        [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-15));
            make.width.equalTo(@(100));
            make.bottom.equalTo(@(-25));
            make.height.equalTo(@(40));
        }];
        
        
        //__settingDatas__
        iconImgView.image=[UIImage imageNamed:@"image@2x"];
        
        nameLabel.text=@"乔耐";
        nameLabel.font=[UIFont systemFontOfSize:16];
        nameLabel.textColor=[UIColor blackColor];
        
        [barcodeButton setBackgroundImage:[UIImage imageNamed:@"icon_personal_code@2x"] forState:UIControlStateNormal];
        
        
        phoneNoLabel.text=@"1850****734";
        phoneNoLabel.font=[UIFont systemFontOfSize:13];
        phoneNoLabel.textColor=[UIColor lightGrayColor];
        
        [confirmButton setTitle:@"待认证" forState:UIControlStateNormal];
        [confirmButton setBackgroundImage:[UIImage imageNamed:@"Login_validate@2x"] forState:UIControlStateNormal];
        
        
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
