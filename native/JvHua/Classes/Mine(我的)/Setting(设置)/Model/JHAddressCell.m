//
//  JHAddressCell.m
//  JvHua
//
//  Created by 乔耐 on 15/12/17.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHAddressCell.h"

@implementation JHAddressCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setAddressModel:(JHUserAddressModel *)addressModel
{
    _addressModel = addressModel;
    
    _nameLabel.text = addressModel.consignee;
    _phoneLabel.text = addressModel.tel;
    NSString *addressStr = [NSString stringWithFormat:@"%@%@%@%@",addressModel.province,addressModel.city,addressModel.district,addressModel.street];
    _addressLabel.text = addressStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)deleteAddress:(UIButton *)sender {
    
    if (_editAddress) {
        _editAddress();
    }
    

}

+ (CGFloat)addressCellHeight:(JHUserAddressModel *)model
{
    NSString *addressStr = [NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.district,model.street];
    
    CGSize addressSize = [addressStr boundingRectWithSize:CGSizeMake(SCREENW - 77, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:JHFont(14)} context:nil].size;
    
    return 70 + addressSize.height + 12;
}
@end
