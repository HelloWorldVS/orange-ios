//
//  JHAddressController.m
//  JvHua
//
//  Created by 乔耐 on 15/12/15.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHAddressController.h"
#import "JHAddressCell.h"

@interface JHAddressController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

@end

static NSString *ID = @"cellID";
@implementation JHAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"账号设置";
    
    _dataArray = [NSMutableArray array];
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setTitleColor:KGreenColor forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(editAddress:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.frame = CGRectMake(0, 0, SCREENW, SCREENH - 50);
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    [_tableView registerNib:[UINib nibWithNibName:@"JHAddressCell" bundle:nil] forCellReuseIdentifier:ID];
    [self.view addSubview:_tableView];
    
//    UIButton *bottomBtn = [[UIButton alloc] init];
//    bottomBtn.backgroundColor = [UIColor blackColor];
//    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [bottomBtn setTitle:@"新增收货人地址" forState:UIControlStateNormal];
//    [bottomBtn addTarget:self action:@selector(addAddress:) forControlEvents:UIControlEventTouchUpInside];
//    bottomBtn.frame = CGRectMake(0, SCREENH - 50 - 64, SCREENH, 50);
//    [self.view addSubview:bottomBtn];

    
    
}



@end
