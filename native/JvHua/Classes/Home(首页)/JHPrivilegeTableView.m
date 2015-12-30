//
//  JHPrivilegeTableView.m
//  JvHua
//
//  Created by 乔耐 on 15/12/30.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHPrivilegeTableView.h"
#import "JHPrivielgeCell.h"
#define kPrivilegeCellHeight 90

@interface JHPrivilegeTableView()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation JHPrivilegeTableView
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
    }
    
    return self;
}

- (void)setPrivilegeData:(NSMutableArray *)privilegeData {
    _privilegeData = privilegeData;
    
    [self reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _privilegeData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identified = @"privilegeCell";
    JHPrivielgeCell *cell = [tableView dequeueReusableCellWithIdentifier:identified];
    if (cell == nil) {
        cell = [[JHPrivielgeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
    }
    
    cell.model = _privilegeData[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kPrivilegeCellHeight;
}





@end
