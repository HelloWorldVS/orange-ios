//
//  JHCoverView.m
//  JvHua
//
//  Created by 乔耐 on 15/12/30.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHCoverView.h"

#import "JHDisplayView.h"

@interface JHCoverView()<UIGestureRecognizerDelegate>
{
    JHDisplayView *_displayView;
}
@end

@implementation JHCoverView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //        self.backgroundColor = [UIColor blackColor];
        //
        //        self.alpha = 0.4;
        // 通过 colorWithWhite:0.4 alpha:0.3 方法来设置背景色
        // 那么它的子view 不会跟随父view 的透明化而透明
        self.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.3];
        
        [self setupUI];
        
        [self registerNotification];
        
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickCoverView:)];
        
        tap.delegate = self;
        
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didClickHeaderButton)
                                                 name:kNotificationDidClickHeaderButton
                                               object:nil];
}

- (void)setupUI {
    
    [self setupDisplayView];
}

- (void)setupDisplayView {
    _displayView = [[JHDisplayView alloc] initWithFrame:CGRectMake(0, -kExplandHeight, kScreenSize.width, kExplandHeight)];
    
    [_displayView setBackgroundColor:[UIColor whiteColor]];
    
    
    [self addSubview:_displayView];
}

- (void)didClickHeaderButton {
    
    // 先回复原始状态
    _displayView.transform = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:0.5 animations:^{
        _displayView.transform = CGAffineTransformMakeTranslation(0, kExplandHeight);
    }];
}

- (void)didClickCoverView:(UITapGestureRecognizer *)tap {
    self.hidden = YES;
    
    // 通知代理被点击
    if ([self.delegate respondsToSelector:@selector(didClickCoverView)]) {
        [self.delegate didClickCoverView];
    }
    
}

// 单击手势的代理方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    UIView *view = [touch view];
    
    BOOL result = YES;
    
    // 如果不是 JHCoverView 类型的时候, 就返回NO , 如果为no 的时候,
    //  就不会响应手势的点击事件
    if (![view isKindOfClass:[JHCoverView class]]) {
        result = NO;
    }
    
    return result;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
