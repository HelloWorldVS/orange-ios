//
//  JHBaseSettingController.h
//  JvHua
//
//  Created by 乔耐 on 15/11/27.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHGroup.h"
#import "JHItem.h"
#import "JHItemArrow.h"
#import "JHItemSwitch.h"
#import "JHItemLabel.h"

@interface JHBaseSettingController : UITableViewController

- (void)loadGroups;
@property (nonatomic, strong) NSArray *groups;

@end
