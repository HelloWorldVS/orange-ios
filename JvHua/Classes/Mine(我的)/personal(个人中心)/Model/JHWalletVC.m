//
//  JHWalletVC.m
//  JvHua
//
//  Created by 乔耐 on 15/11/18.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHWalletVC.h"
#import "JHHomeViewController.h"
#import "JHCommonItem.h"
#import "JHCommonCell.h"


@interface JHWalletVC () <UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation JHWalletVC

- (NSMutableArray *)groups
{
    if (!_groups) {
        self.groups = [NSMutableArray array];
    }
    return _groups;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIButton *BT1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.size.width, 150)];
    BT1.backgroundColor = KGreenColor;
    
    [self.view addSubview:BT1];
    
    self.tableView.dataSource = self;
    
    
    [self setNav];
    

    // 设置tableview属性
    [self setupTable];
}

//设置tableview属性
- (void)setupTable{
    //1. 设置分割线
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //2 设置每一组头部尾部的高度
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 20;
    
    //3 设置背景颜色
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark 数据源方法
//返回组的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//返回section这个组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.imageView.image = [UIImage imageNamed:@"icon_personal_activity"];
    cell.textLabel.text = @"我的订单";

    return cell;
    
}













#pragma mark - 导航控制器

- (void)setNav{
    
    //设置左边的item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back_withtext" hltImage:@"navigationbar_back_withtext" target:self action:@selector(homeshow:)];
    
    //设置右边的扫码
    
     self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_code_withtext" hltImage:@"navigationbar_code_withtext" target:self action:@selector(pop:)];
    
}

- (void)homeshow:(UIButton *)btn{
    NSLog(@"%s",__func__);
    
    JHHomeViewController *ctrl = [[JHHomeViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)pop:(UIButton *)btn{
    NSLog(@"%s",__func__);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"您目前还未进行线下认证,请耐心等待工作人员与您联系" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    [alertView show];

}





@end
