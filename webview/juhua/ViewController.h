//
//  ViewController.h
//  juhua
//
//  Created by 乔耐 on 15/10/21.
//  Copyright (c) 2015年 juzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PingppError;

@interface ViewController : UIViewController<UIWebViewDelegate>{
    UIActivityIndicatorView *activityIndicator;
    }

@property (nonatomic, strong) UIWebView *webView;

- (void)requestForCharge;

- (void)handlePaymentResult:(NSString *)result error:(PingppError *)error;

@end

