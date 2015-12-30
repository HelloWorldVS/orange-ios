//
//  JHBassCell.m
//  JvHua
//
//  Created by 乔耐 on 15/12/30.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHBassCell.h"

#define kBasseCellFont 14

@implementation JHBassCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = rgbColor(0xf7f7f7);
        
        self.textLabel.font = [UIFont systemFontOfSize:kBasseCellFont];
        
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) { // 被选中状态
        self.textLabel.textColor = rgbColor(0xe8ae26);
        self.backgroundColor = [UIColor whiteColor];
        
    } else {  // 未被选中状态
        self.textLabel.textColor = [UIColor blackColor];
        self.backgroundColor = rgbColor(0xf7f7f7);
    }
}

@end
