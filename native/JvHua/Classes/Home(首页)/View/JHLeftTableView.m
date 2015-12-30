//
//  JHLeftTableView.m
//  JvHua
//
//  Created by 乔耐 on 15/12/30.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHLeftTableView.h"
#import "JHLeftCell.h"

@interface JHLeftTableView()<UITableViewDelegate,UITableViewDataSource>
{
    JHLeftCell *_currentCell;
}
@end

@implementation JHLeftTableView
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.delegate = self;
        
        self.dataSource = self;
        
    }
    
    return self;
}

- (void)setLeftArray:(NSMutableArray *)leftArray {
    _leftArray = leftArray;
    
    [self reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _leftArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"leftCell";
    
    JHLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[JHLeftCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = _leftArray[indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JHLeftCell *leftCell = (JHLeftCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    [_currentCell setSelected:NO];
    
    _currentCell = leftCell;
    [_currentCell setSelected:YES];
    
    // 通知代理
    if ([self.leftDelegate respondsToSelector:@selector(displayTableView:didClickCell:)]) {
        [self.leftDelegate displayTableView:self didClickCell:leftCell];
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self reloadData];
}


@end
