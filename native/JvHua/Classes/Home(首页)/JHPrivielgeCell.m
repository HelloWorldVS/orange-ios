//
//  JHPrivielgeCell.m
//  JvHua
//
//  Created by 乔耐 on 15/12/30.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHPrivielgeCell.h"
#import "JHPrivilegeModel.h"

#define kCellSize (self.frame.size)

#define kShopImageWidth 70

#define kLabelFontSize 13

#define kLabelHeight 12

#define kDeltaY 5

@interface JHPrivielgeCell ()
{
    UILabel *_shopNameLabel;
    UILabel *_infoLabel;
    UILabel *_freeLabel;
    UILabel *_leftCountLabel;
    UIImageView *_statusImageView;
    UIImageView *_shopImageView;
}
@end
@implementation JHPrivielgeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    
    return self;
}

- (void)setModel:(JHPrivilegeModel *)model {
    _model = model;
    
    _shopNameLabel.text = model.name;
    _shopImageView.image = [UIImage imageNamed:model.image];
    
    _infoLabel.text = model.info;
    _leftCountLabel.text = [NSString stringWithFormat:@" 剩余%@张",model.leftCount];
    _freeLabel.text = model.free;
    
    NSString *imageString = [model.statusType integerValue] == 0 ? @"cata_4_disable" : @"cata_4";
    _statusImageView.image = [UIImage imageNamed:imageString];
}

- (void)setupUI {
    _shopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kMargin, kMargin, kShopImageWidth, kShopImageWidth)];
    [self.contentView addSubview:_shopImageView];
    CGFloat startX = CGRectGetMaxX(_shopImageView.frame) + kMargin;
    CGFloat labelWidth = kCellSize.width - startX;
    
    _shopNameLabel = [self labelWithFrame:CGRectMake(startX, kMargin, labelWidth, kLabelHeight)];
    [self.contentView addSubview:_shopNameLabel];
    
    _statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(startX, CGRectGetMaxY(_shopNameLabel.frame) + kDeltaY,labelWidth * 0.3, 20)];
    [self.contentView addSubview:_statusImageView];
    
    CGFloat leftCountLabelX = CGRectGetMaxX(_statusImageView.frame);
    _leftCountLabel = [self labelWithFrame:CGRectMake(leftCountLabelX, CGRectGetMaxY(_shopNameLabel.frame) + kDeltaY + 5, labelWidth - leftCountLabelX, kLabelHeight)];
    [self.contentView addSubview:_leftCountLabel];
    
    _infoLabel = [self labelWithFrame:CGRectMake(startX, CGRectGetMaxY(_statusImageView.frame) + kDeltaY, labelWidth, kLabelHeight)];
    [self.contentView addSubview:_infoLabel];
    
    _freeLabel = [self labelWithFrame:CGRectMake(startX, CGRectGetMaxY(_infoLabel.frame) + kDeltaY, labelWidth, kLabelHeight)];
    [self.contentView addSubview:_freeLabel];
    
}

- (UILabel *)labelWithFrame:(CGRect)frame {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:kLabelFontSize];
    
    return label;
}

@end
