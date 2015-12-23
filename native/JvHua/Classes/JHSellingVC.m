//
//  JHSellingVC.m
//  JvHua
//
//  Created by 乔耐 on 15/11/18.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHSellingVC.h"
#import "JHHomeTitleButton.h"
@interface JHSellingVC ()

@property (nonatomic,weak) JHHomeTitleButton *titleBtn;
@end

@implementation JHSellingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.navigationController.title = @"限时热卖";
    
//    
//    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selling_backgroundImage"]];
////    backgroundView.frame = self.view.bounds;
//    [self.view addSubview:backgroundView];
    
    [self setNav];
    
    
}

#pragma mark - 导航控制器

- (void)setNav{
    
    //设置左边的item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back_withtext" hltImage:@"navigationbar_back_withtext" target:self action:@selector(homeshow:)];
    
    
    //设置中间的view
    JHHomeTitleButton *titleBtn = [[JHHomeTitleButton alloc] init];
//    [titleBtn setTitle:@"限时特卖" forState:UIControlStateNormal];
    
    [titleBtn sizeToFit];
    self.navigationItem.titleView = titleBtn;
    self.titleBtn = titleBtn;
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.titleBtn setTitle:@"限时特卖" forState:UIControlStateNormal];
    self.titleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [self.titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.tabBarItem.badgeValue = nil;
    
}


- (void)homeshow:(UIButton *)btn{
    NSLog(@"%s",__func__);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
