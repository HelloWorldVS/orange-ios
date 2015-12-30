//
//  JHCustomVC.m
//  JvHua
//
//  Created by 乔耐 on 15/12/30.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHCustomVC.h"
#import "JHHomeController.h"
#import "JHHeaderButton.h"
#import "JHHeaderView.h"
#import "JHPrivilegeModel.h"
#import "JHPrivilegeTableView.h"
#import "JHCoverView.h"
#define kHeaderViewHeight 40

@interface JHCustomVC ()<JHHeaderViewDelegate>
{
    JHHeaderView *_headerView;
    
    JHCoverView *_coverView;
    
    JHPrivilegeTableView *_privilegeTableView;
    
    NSMutableArray *_privilegeData;
}


@end

@implementation JHCustomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self regitsterNotification];
    
    [self setupData];
    
    [self setupUI];
    
    
    [self setNav];
}

- (void)setupData {
    _privilegeData = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        JHPrivilegeModel *model = [[JHPrivilegeModel alloc] init];
        model.name = @"合力屋(8店通用)";
        model.image = @"i";
        model.info = @"6.2折享便便蛋糕";
        if (i % 2 == 0) {
            model.statusType = @"1";
        } else {
            model.statusType = @"0";
        }
        
        model.leftCount = @"0";
        model.free = @"免费";
        
        [_privilegeData addObject:model];
    }
}

//- (void)regitsterNotification {
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(didStartSearch)
//                                                 name:kNotificationStartSearch
//                                               object:nil];
//}

- (void)setupUI {
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    [self setupHeaderView];
    
    [self setupPrivilegeTableView];
    
    [self setupCoverView];
    
}

- (void)setupPrivilegeTableView {
    _privilegeTableView = [[JHPrivilegeTableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame), kScreenSize.width, kViewContentHeight - kHeaderViewHeight)];
    
    _privilegeTableView.privilegeData = _privilegeData;
    
    [self.view addSubview:_privilegeTableView];
}

- (void)setupCoverView {
    _coverView = [[JHCoverView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame), kScreenSize.width, kViewContentHeight - kHeaderViewHeight)];
    
    _coverView.hidden = YES;
    
    _coverView.delegate = self;
//    
    [self.view addSubview:_coverView];
    
    // 把指定的view 带到最顶层
    [self.view bringSubviewToFront:_headerView];
}

- (void)setupHeaderView {
    _headerView = [[JHHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kHeaderViewHeight)];
    
    _headerView.delegate = self;
    
    [self.view addSubview:_headerView];
}


//// 设置titleView
//- (void)setupTitleView {
//    // 把文字给清空
//    self.navigationItem.title = nil;
//    
//    // 实例化 titleView
//    CZTitleView *titleView = [[CZTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kNavigationBarHeight)];
//    
//    titleView.delegate = self;
//    
//    titleView.placeString = @"请输入商户名称";
//    
//    self.navigationItem.titleView = titleView;
//}
//
- (void)headerView:(JHHeaderView *)headerView didClickButton:(JHHeaderButton *)button {
    
    _coverView.hidden = !button.isSelected;
    
    // 通知 其他类被点击了
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDidClickHeaderButton object:button];
}

//// coverView 代理方法
//- (void)didClickCoverView {
//    
//    [_headerView resetButtonState];
//}
//
////// 实现titleView的代理方法
////- (void)titleView:(JHTitleView *)titleView didClickTitleViewType:(CZTitleViewType)type {
////    if (CZTitleViewTypeMapButton == type) {
////        NSLog(@"点击了 地图按钮");
////    } else {
////        [self.navigationController pushViewController:[[CZSearchController alloc] init] animated:YES];
////    }
////}
////
////- (void)didStartSearch {
////    NSLog(@"开始搜索");
////    
////    [self resetPrivilegeState];
////}
////
//
//// 恢复控制器的正常状态
//- (void)resetPrivilegeState {
//    _coverView.hidden = YES;
//    [_headerView resetButtonState];
//}
//

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    
//    [self resetPrivilegeState];
//}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}





#pragma mark - 导航控制器

- (void)setNav{
    
    //设置左边的item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back_withtext" hltImage:@"navigationbar_back_withtext" target:self action:@selector(homeshow:)];
    
    //设置右边的文字按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"首页" style:UIBarButtonItemStylePlain target:self action:@selector(pop:)];
    
    
    
}

- (void)homeshow:(UIButton *)btn{
    NSLog(@"%s",__func__);
    
    JHHomeController *ctrl = [[JHHomeController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)pop:(UIButton *)btn{
    NSLog(@"%s",__func__);
    
    JHHomeController *ctrl = [[JHHomeController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
    
}





@end
