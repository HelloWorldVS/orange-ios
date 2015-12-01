//
//  JHSettingItemCell.m
//  JvHua
//
//  Created by 乔耐 on 15/11/27.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHSettingItemCell.h"
#import "JHItem.h"
#import "JHItemArrow.h"
#import "JHItemSwitch.h"
#import "JHItemLabel.h"


@interface JHSettingItemCell ()
@property (nonatomic, strong) UISwitch *switchView;
@property (nonatomic, strong) UILabel *lblView;
@end


@implementation JHSettingItemCell

- (UISwitch *)switchView{
    if (_switchView == nil) {
        _switchView  = [UISwitch new];
        
        [_switchView addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        //加载开关的状态
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        _switchView.on = [userDefaults boolForKey:self.item.title];
        
    }
    return _switchView;
}

- (UILabel *)lblView{
    if (_lblView == nil) {
        _lblView = [UILabel new];
        _lblView.textColor = [UIColor grayColor];
        _lblView.font = [UIFont systemFontOfSize:13];
    }
    return _lblView;
}

- (void)valueChanged:(UISwitch *)sender{
    //保存开关的状态
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setBool:sender.isOn forKey:self.item.title];
}

//因为要创建可重用的cell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *reuseId = @"item";
    JHSettingItemCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:reuseId];
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    return cell;
    
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    return [self cellWithTableView:tableView style:UITableViewCellStyleSubtitle];
}

- (void)setItem:(JHItem *)item{
    _item = item;
    self.textLabel.text = item.title;
    if (item.icon) {
        
        self.imageView.image = [UIImage imageNamed:item.icon];
    }
    
    if (item.subTitle) {
        self.detailTextLabel.text = item.subTitle;
        
    }
    
    if ([item isKindOfClass:[JHItemArrow class]]) {
        //箭头的cell
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if([item isKindOfClass:[JHItemSwitch class]]){
        //开关的cell
        //取消cell选中的样式
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryView = self.switchView;
    }else if([item isKindOfClass:[JHItemLabel class]]){
        self.lblView.text = item.time;
        [self.lblView sizeToFit];
        self.accessoryView = self.lblView;
    }else{
        self.accessoryView = nil;
    }
}

@end
