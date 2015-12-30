//
//  JHLeftCell.m
//  JvHua
//
//  Created by 乔耐 on 15/12/30.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHLeftCell.h"
@interface JHLeftCell()
{
    UIView *_rightLine;
}
@end

@implementation JHLeftCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat startX = kViewSize.width - kNormalLineHeight;
    
    [_rightLine setFrame:CGRectMake(startX, 0, kNormalLineHeight, kViewSize.height)];
}

- (void)setupUI {
    _rightLine = [[UIView alloc] init];
    [_rightLine setBackgroundColor:[UIColor grayColor]];
    
    [self.contentView addSubview:_rightLine];
    
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        _rightLine.hidden = YES;
    } else {
        _rightLine.hidden = NO;
    }
}


@end
