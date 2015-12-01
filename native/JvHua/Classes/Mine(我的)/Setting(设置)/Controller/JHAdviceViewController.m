//
//  JHAdviceViewController.m
//  JvHua
//
//  Created by 乔耐 on 15/11/25.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHAdviceViewController.h"
#import "JHComposeView.h"

@interface JHAdviceViewController ()<UITextViewDelegate>

@property (nonatomic, strong) JHComposeView *tv;

@end

@implementation JHAdviceViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupInputView];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //主动显示键盘
    [self.tv becomeFirstResponder];
}
- (void)setupInputView{
    JHComposeView *tv = [[JHComposeView alloc] init];
    tv.frame = CGRectMake(10, 10, self.view.width - 20, 300);
    tv.placeholder = @"请输入您的宝贵意见,非常感谢~. ~";
    [self.view addSubview:tv];
    tv.delegate =self;
    self.tv = tv;
    
}

- (IBAction)commitBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if ([self.delegate respondsToSelector:@selector(adviceViewControllerDidClickButton:)]) {
        [self.delegate adviceViewControllerDidClickButton:self];
    }
    

    
}

@end
