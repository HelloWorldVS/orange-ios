//
//  JHLoginViewController.h
//  JvHua
//
//  Created by 乔耐 on 15/11/4.
//  Copyright (c) 2015年 juzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JHLoginViewControllerDelegate <NSObject>

@optional

- (void)doNetWorking;

@end

@interface JHLoginViewController : UIViewController

@property (nonatomic,strong) id <JHLoginViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@end
