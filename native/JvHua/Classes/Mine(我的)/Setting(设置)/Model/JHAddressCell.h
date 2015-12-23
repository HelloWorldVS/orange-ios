//
//  JHAddressCell.h
//  JvHua
//
//  Created by 乔耐 on 15/12/17.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHUserAddressModel.h"

@interface JHAddressCell : UITableViewCell

@property (nonatomic, strong) JHUserAddressModel *addressModel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


@property (nonatomic, strong) void(^editAddress)();
- (IBAction)editAddress:(UIButton *)sender;

- (IBAction)deleteAddress:(UIButton *)sender;

+ (CGFloat)addressCellHeight:(JHUserAddressModel *)model;

@end
