//
//  JHHeaderView.h
//  JvHua
//
//  Created by 乔耐 on 15/12/30.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHHeaderView, JHHeaderButton;

@protocol JHHeaderViewDelegate <NSObject>

- (void)headerView:(JHHeaderView *)headerView didClickButton:(JHHeaderButton *)button;

@end

@interface JHHeaderView : UIView

@property (nonatomic, assign) id<JHHeaderViewDelegate> delegate;

@end
