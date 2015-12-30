//
//  JHHeaderView.m
//  JvHua
//
//  Created by 乔耐 on 15/12/30.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHHeaderView.h"
#import "JHHeaderButton.h"

@interface JHHeaderView ()
{
    JHHeaderButton *_currentButton;
    NSMutableArray *_buttonArray;
}

@end

@implementation JHHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat buttonWidth = kViewSize.width / 3;
    
    NSArray *buttonTitle = @[@"全部商区",@"美食",@"默认排序"];
    
    // 实例化数组
    _buttonArray = [NSMutableArray array];
    
    for (int i = 0; i < buttonTitle.count; i++) {
        JHHeaderButton *button = [[JHHeaderButton alloc] initWithFrame:CGRectMake(i * buttonWidth, 0, buttonWidth, kViewSize.height - kNormalLineHeight)];
        [button setTitle:buttonTitle[i] forState:UIControlStateNormal];
        
        [self addSubview:button];
        
        if (i == buttonTitle.count - 1) {
            button.hideLine = YES;
        }
        
        // 设置tag, 定义类型
        button.tag = i + 1;
        
        // 添加到数组
        [_buttonArray addObject:button];
        
        // 添加点击事件
        [button addTarget:self
                   action:@selector(didClickButton:)
         forControlEvents:UIControlEventTouchUpInside];
    }
    
    // 添加底部的线条
    UIView *bottomLine = [UIView grayLineViewWithFrame:CGRectMake(0, kViewSize.height - kNormalLineHeight, kViewSize.width, kNormalLineHeight)];
    
    [self addSubview:bottomLine];
}

// 恢复按钮状态
- (void)resetButtonState {
    [_buttonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        JHHeaderButton *button = obj;
        
        button.selected = NO;
        
    }];
    
}

- (void)didClickButton:(JHHeaderButton *)button {
    
    if (_currentButton == button) {
        [_currentButton setSelected:!button.isSelected];
    } else {
        [_currentButton setSelected:NO];
        _currentButton = button;
        [button setSelected:YES];
    }
    
    if ([self.delegate respondsToSelector:@selector(headerView:didClickButton:)]) {
        [self.delegate headerView:self didClickButton:button];
    }
}





@end
