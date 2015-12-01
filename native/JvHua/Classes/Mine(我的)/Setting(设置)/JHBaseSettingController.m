//
//  JHBaseSettingController.m
//  JvHua
//
//  Created by 乔耐 on 15/11/27.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHBaseSettingController.h"
#import "JHSettingItemCell.h"

@interface JHBaseSettingController ()

@end

@implementation JHBaseSettingController
//重写controller的init方法，设置tableView可以分组显示
- (instancetype)init{
    
    return [super initWithStyle:UITableViewStyleGrouped];
    
}

- (NSArray *)groups{
    if (_groups == nil) {
        [self loadGroups];
    }
    return _groups;
}

- (void)loadGroups{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //第一个cell之前的间距
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0,15)];
    
    //设置每一组之间的间距
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 15;
    //设置tableView的背景图片
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    
}

//tableView的代理方法，点击cell的时候执行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //取出模型数据
    JHGroup *group = self.groups[indexPath.section];
    JHItem *item = group.items[indexPath.row];
    
    if (item.option) {
        item.option();
    }else if(item.destController){
        UIViewController *vc = [item.destController new];
        vc.title = item.title;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    JHGroup *group =  self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1 创建可重用的cell
    JHSettingItemCell *cell = [JHSettingItemCell cellWithTableView:tableView];
    //2 给cell内部的属性赋值
    JHGroup *group = self.groups[indexPath.section];
    JHItem *item = group.items[indexPath.row];
    
    cell.item = item;
    
    //3 返回cell
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    JHGroup *group = self.groups[section];
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    JHGroup *group = self.groups[section];
    return group.footer;
}


@end
