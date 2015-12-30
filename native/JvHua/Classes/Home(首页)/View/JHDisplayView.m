//
//  JHDisplayView.m
//  JvHua
//
//  Created by 乔耐 on 15/12/30.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHDisplayView.h"

#import "JHLeftTableView.h"
#import "JHRightTableView.h"
#import "JHInfoTableView.h"
#import "JHHeaderButton.h"
#import "JHDisplayTool.h"
#import "JHBassCell.h"
#import "JHDisplayDelegate.h"

#define kLeftTableViewWidth (kViewSize.width * 0.3)

@interface JHDisplayView ()<JHDisplayDelegate>
{
    JHLeftTableView *_leftTableView;
    
    JHRightTableView *_rightTableView;
    
    JHInfoTableView *_infoTableView;
    
    NSArray *_dataArray;
    
    JHDisplayTool *_displayTool;

}

@end

@implementation JHDisplayView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self registerNotification];
        
        [self setupData];
        
        [self setupUI];
    }
    
    return self;
}

- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didClickHeaderButton:)
                                                 name:kNotificationDidClickHeaderButton
                                               object:nil];
}

- (void)setupData {
    _dataArray = @[@{@"全部商户":@[@"全部商户1",@"全部商户2",@"全部商户3"]},
                   @{@"美食":@[@"美食1",@"美食2",@"美食3",@"美食4",@"美食5"]},
                   @{@"休闲娱乐":@[@"休闲娱乐1"]},
                   @{@"丽人":@[@"丽人1"]},
                   @{@"生活服务":@[@"生活服务1"]},
                   @{@"购物":@[@"购物1"]},
                   @{@"酒店":@[@"酒店1"]}];
    
    _displayTool = [[JHDisplayTool alloc] init];
    _displayTool.dataArray = _dataArray;
    
}

- (void)setupUI {
    
    [self setupLeftTableView];
    
    [self setupRightTableView];
    
    [self setupInfoTableView];
}

- (void)setupLeftTableView {
    _leftTableView = [[JHLeftTableView alloc] initWithFrame:CGRectMake(0, 0, kLeftTableViewWidth, kViewSize.height)];
    
    _leftTableView.leftArray = _displayTool.leftData;
    
    _leftTableView.leftDelegate = self;
    
    [self addSubview:_leftTableView];
}

- (void)setupRightTableView {
    _rightTableView = [[JHRightTableView alloc] initWithFrame:CGRectMake(kLeftTableViewWidth, 0, kViewSize.width - kLeftTableViewWidth, kViewSize.height)];
    
    _rightTableView.rightArray = _displayTool.rightData;
    
    _rightTableView.rightDelegate = self;
    
    [self addSubview:_rightTableView];
}

- (void)setupInfoTableView {
    _infoTableView = [[JHInfoTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kViewSize.height)];
    
    [self addSubview:_infoTableView];
}

- (void)didClickHeaderButton:(NSNotification *)noti {
   JHHeaderButton *button = [noti object];
    
    switch (button.tag) {
        case CZHeaderButtonTypeShop:  // 显示left, 和right tableView
        {
            [self showLeftAndRightTableView];
        }
            break;
        case CZHeaderButtonTypeCircle:  // 显示 info tableVeiw
        {
            [self showInfoTableView];
        }
            break;
        case CZHeaderButtonTypeSort:   // 显示 info tableVeiw
        {
            [self showInfoTableView];
        }
            break;
            
        default:
            break;
    }
}

- (void)showLeftAndRightTableView {
    [_infoTableView removeFromSuperview];
    
    [self addSubview:_leftTableView];
    [self addSubview:_rightTableView];
}

- (void)showInfoTableView {
    [_leftTableView removeFromSuperview];
    [_rightTableView removeFromSuperview];
    
    [self addSubview:_infoTableView];
}


- (void)displayTableView:(UITableView *)tableView didClickCell:(JHBassCell *)cell {
    if ([tableView isKindOfClass:[JHLeftTableView class]]) { // 点击了左侧的cell
        // 在数据中, 拿到对应的value 交给 rightTableVeiw 让它去加载数据
        NSString *key = cell.textLabel.text;
        
        NSMutableArray *tempArray = [_displayTool getDataWith:key];
        
        _rightTableView.rightArray = tempArray;
        
    } else { // 点击了右侧的cell, coverView 要隐藏掉, 然后开始搜索
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationStartSearch object:nil];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
