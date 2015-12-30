//
//  CZDisplayDelegate.h
//  PreWallet
//
//  Created by apple on 15/8/5.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class JHBassCell;

@protocol JHDisplayDelegate <NSObject>




- (void)displayTableView:(UITableView *)tableView didClickCell:(JHBassCell *)cell;

@end
