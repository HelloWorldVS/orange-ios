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
@interface JHHomeViewController ()

@property (nonatomic,weak) JHHomeTitleButton *titleBtn;

@end

@implementation JHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setNav];
}

- (void)setNav{
    //设置导航栏左右的按钮
    
    //设置左边的item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"tabbar_profile_selected" hltImage:@"tabbar_profile_selected" target:self action:@selector(friendsearch:)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_pop" hltImage:@"navigationbar_pop_highlighted" target:self action:@selector(pop:)];
    

    
    //设置导航栏
    JHHomeTitleButton *titleBtn = [[JHHomeTitleButton alloc] init];
    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
   
    [titleBtn sizeToFit];
    
    self.navigationItem.titleView = titleBtn;
    self.titleBtn = titleBtn;


}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}


#pragma mark - 私有方法

- (void)friendsearch:(UIButton *)btn{
    NSLog(@"%s",__func__);
    JHTemp2Controller *ctrl = [[JHTemp2Controller alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)pop:(UIButton *)btn{
    NSLog(@"%s",__func__);
}

@end

