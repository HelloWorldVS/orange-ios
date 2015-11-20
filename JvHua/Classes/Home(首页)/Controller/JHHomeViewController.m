//
//  JHHomeViewController.m
//  橘花
//
//  Created by 乔耐 on 15/10/15.
//  Copyright (c) 2015年 橘子星球网络科技有限公司. All rights reserved.
//

#import "JHHomeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "JHTemp2Controller.h"
#import "JHHomeTitleButton.h"
#import "JHPersonal.h"

@interface JHHomeViewController ()

@property (nonatomic,weak) JHHomeTitleButton *titleBtn;

@end

@implementation JHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    [self setNav];
}

- (void)setNav{
    //设置导航栏左右的按钮
    
    //设置左边的item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_person_withtext" hltImage:@"navigationbar_person_withtext" target:self action:@selector(friendsearch:)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_mail_withtext" hltImage:@"navigationbar_mail_withtext" target:self action:@selector(pop:)];
    


}







#pragma mark - 私有方法

- (void)friendsearch:(UIButton *)btn{
    NSLog(@"%s",__func__);
    JHTemp2Controller *PVC = [[JHTemp2Controller alloc] init];
    [self.navigationController pushViewController:PVC animated:YES];
}

- (void)pop:(UIButton *)btn{
    NSLog(@"%s",__func__);
}

@end

