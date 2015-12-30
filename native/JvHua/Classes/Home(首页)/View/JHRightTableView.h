//
//  JHRightTableView.h
//  JvHua
//
//  Created by 乔耐 on 15/12/30.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHRightTableView : UITableView
@property (nonatomic, strong) NSMutableArray *rightArray;

@property (nonatomic, assign) id<JHDisplayDelegate> rightDelegate;
@end
