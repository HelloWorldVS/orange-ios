//
//  JHAdviceViewController.h
//  JvHua
//
//  Created by 乔耐 on 15/11/25.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHAdviceViewController;

//自定义代理
@protocol JHAdviceViewControllerDelegate <NSObject>

@optional
- (void)adviceViewControllerDidClickButton:(JHAdviceViewController *)adviceViewController;

@end

@interface JHAdviceViewController : UIViewController

@property (nonatomic, weak) id<JHAdviceViewControllerDelegate> delegate;

@end
