//
//  JHRightTableView.m
//  JvHua
//
//  Created by 乔耐 on 15/12/30.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHRightTableView.h"
#import "JHRightCell.h"

@interface JHRightTableView()<UITableViewDelegate,UITableViewDataSource>
{
    JHRightCell *_currentCell;
}
@end

@implementation JHRightTableView
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.delegate = self;
        
        self.dataSource = self;
        
    }
    
    return self;
}

- (void)setRightArray:(NSMutableArray *)rightArray {
    _rightArray = rightArray;
    
    [self reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rightArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"rightCell";
    
    JHRightCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[JHRightCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = _rightArray[indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JHRightCell *rightCell = (JHRightCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    [_currentCell setSelected:NO];
    
    _currentCell = rightCell;
    [_currentCell setSelected:YES];
    
    // 通知代理
    if ([self.rightDelegate respondsToSelector:@selector(displayTableView:didClickCell:)]) {
        [self.rightDelegate displayTableView:self didClickCell:rightCell];
    }
    
}

@end
