//
//  JHBaseTableViewController.m
//  JvHua
//
//  Created by 乔耐 on 15/11/19.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHBaseTableViewController.h"

@interface JHBaseTableViewController ()

@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation JHBaseTableViewController


- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tableview
    [self setupTableView];
    
}

- (void)setupTableView
{
    //设置分组间隙
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 0;
    
    //设置tableView的额外滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    
}


#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    JHCommonGroup *group = self.groups[section];
    
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    JHCommonCell *cell = [JHCommonCell cellWithTableView:tableView];
    
    JHCommonGroup *group = self.groups[indexPath.section];
    
    // 2.给cell传递模型
    cell.item = group.items[indexPath.row];
    
    // 3.返回cell
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出选中的行模型
    JHCommonGroup *group = self.groups[indexPath.section];
    JHCommonItem *item = group.items[indexPath.row];
    
    //判断是否有目标控制器
    if (item.destVc) {
        UIViewController *destVc = [[item.destVc alloc] init];
        [self.navigationController pushViewController:destVc animated:YES];
    }
    
    //判断模型中是否有指定的代码
    if (item.option) {
        item.option();
    }
    
}

- (JHCommonGroup *)addGroup
{
    JHCommonGroup *group = [JHCommonGroup group];
    [self.groups addObject:group];
    return group;
}

/** 懒加载 */

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

@end
