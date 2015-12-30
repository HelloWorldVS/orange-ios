//
//  JHCoverView.h
//  JvHua
//
//  Created by 乔耐 on 15/12/30.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHCoverView;

@protocol JHCoverViewDelegate <NSObject>

- (void)didClickCoverView;

@end

@interface JHCoverView : UIView

@property (nonatomic, assign) id<JHCoverViewDelegate> delegate;


@end
