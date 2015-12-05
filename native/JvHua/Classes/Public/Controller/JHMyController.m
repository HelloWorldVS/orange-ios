//
//  JHMyController.m
//  JvHua
//
//  Created by 乔耐 on 15/11/24.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHMyController.h"
#import "JHHomeTitleButton.h"
#import "JHSettingController.h"
//__cells__
#import "ProfileCell.h"
#import "MoneyCell.h"
#import "SmallListCell.h"

#define kFONT [UIFont systemFontOfSize:16]

@interface JHMyController ()<UITableViewDelegate,UITableViewDelegate>
@property (nonatomic,weak) JHHomeTitleButton *titleBtn;
//__section 0__
@property (nonatomic, strong) ProfileCell *profileCell;

//__section 1__
@property (nonatomic, strong) MoneyCell *moneyCell;

//__section 2__
@property (nonatomic, strong) SmallListCell *myActivitiesCell;
@property (nonatomic, strong) SmallListCell *myMessagesCell;
@property (nonatomic, strong) SmallListCell *myServantCell;
@property (nonatomic, strong) SmallListCell *assistanceCell;


@end

@implementation JHMyController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"杜绝BUG 显示内容");
    self.navigationController.title = @"个人中心";
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    //    self.tableView.tableFooterView.height=100;
    self.tableView.height=[UIScreen mainScreen].bounds.size.height;
    [self setNav];
    
    
    ProfileCell *profileCell=[[ProfileCell alloc]init];
    self.profileCell=profileCell;
    
    MoneyCell *moneyCell=[[MoneyCell alloc]init];
    self.moneyCell=moneyCell;
    
    
    SmallListCell *myActivitiesCell=[[SmallListCell alloc]init];
    self.myActivitiesCell=myActivitiesCell;
    myActivitiesCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    myActivitiesCell.titleLabel.text=@"我的活动";
    myActivitiesCell.titleLabel.font=kFONT;
    myActivitiesCell.iconImageView.image=[UIImage imageNamed:@"icon_personal_activity@2x"];
    
    SmallListCell *myMessagesCell=[[SmallListCell alloc]init];
    self.myMessagesCell=myMessagesCell;
    myMessagesCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    myMessagesCell.titleLabel.text=@"我的消息";
    myMessagesCell.titleLabel.font=kFONT;
    myMessagesCell.iconImageView.image=[UIImage imageNamed:@"icon_personal_news@1x"];
    
    
    
    SmallListCell *myServantCell=[[SmallListCell alloc]init];
    self.myServantCell=myServantCell;
    myServantCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    myServantCell.titleLabel.text=@"客服热线";
    myServantCell.titleLabel.font=kFONT;
    myServantCell.iconImageView.image=[UIImage imageNamed:@"icon_personal_callNumber@2x"];
    
    
    SmallListCell *assistanceCell=[[SmallListCell alloc]init];
    self.assistanceCell=assistanceCell;
    assistanceCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    assistanceCell.titleLabel.text=@"使用帮助";
    assistanceCell.titleLabel.font=kFONT;
    assistanceCell.iconImageView.image=[UIImage imageNamed:@"icon_personal_help@3x"];
    
    
    
}

#pragma =====dataSource=====

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        return  90;
        
    }else if(indexPath.section==1){
        
        return 81;
        
    }else if(indexPath.section==2){
        
        return 44;
        
    }else{
        
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==2){
        
        
        return 25;
    }else{
        
        return 0;
        
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section==0){
        return 1;
    }else if(section==1){
        
        return 1;
    }else if(section==2){
        
        
        return 4;
    }else{
        
        
        return 0;
    }
    
    
}
#pragma =====Delegate====
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    static NSString *reuse=@"reuse";
    //
    //    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuse];
    //    if(!cell){
    //
    //        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    //
    //    }
    //__receiveCellModels'Datas
    if(indexPath.section==0){
        
        return self.profileCell;
        
    }else if(indexPath.section==1){
        
        
        return self.moneyCell;
        
    }else if(indexPath.section==2){
        if(indexPath.row==0){
            return self.myActivitiesCell;
            
        }else if(indexPath.row==1){
            
            return self.myMessagesCell;
            
        }else if(indexPath.row==2){
            
            
            return self.myServantCell;
        }else{
            
            return self.assistanceCell;
        }
        
    }else{
        //
        return self.assistanceCell;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}










#pragma mark - 导航控制器

- (void)setNav{
    
    //设置右边的item
    //设置右边设置按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting:)];
    
    
    
    //设置中间的view
    JHHomeTitleButton *titleBtn = [[JHHomeTitleButton alloc] init];
    //    [titleBtn setTitle:@"限时特卖" forState:UIControlStateNormal];
    
    [titleBtn sizeToFit];
    self.navigationItem.titleView = titleBtn;
    self.titleBtn = titleBtn;
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.titleBtn setTitle:@"个人中心" forState:UIControlStateNormal];
    self.titleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [self.titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.tabBarItem.badgeValue = nil;
    
}
- (void)setting:(UIButton *)btn{
    NSLog(@"%s",__func__);
    
    [self.navigationController popViewControllerAnimated:YES];
    JHSettingController *setVC = [[JHSettingController alloc] init];
    setVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setVC animated:YES];
    
    
}



@end

