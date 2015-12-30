//
//  JHWalletVC.m
//  JvHua
//
//  Created by 乔耐 on 15/11/18.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHWalletVC.h"
#import "JHHomeController.h"
#import "Masonry.h"

#import "JHBalanceCell.h"
#import "JHMoneyCell.h"
#import "SmallListCell.h"

#define kFONT [UIFont systemFontOfSize:16]

@interface JHWalletVC () <UITableViewDataSource,UITableViewDelegate>

//__section 0__
@property (nonatomic, strong) JHBalanceCell *balanceCell;

//__section 1__
@property (nonatomic, strong) JHMoneyCell *moneyCell;


//__section 2__
@property (nonatomic, strong) SmallListCell *myActivitiesCell;
@property (nonatomic, strong) SmallListCell *myMessagesCell;
@property (nonatomic, strong) SmallListCell *myServantCell;
@property (nonatomic, strong) SmallListCell *assistanceCell;




@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation JHWalletVC

- (NSMutableArray *)groups
{
    if (!_groups) {
        self.groups = [NSMutableArray array];
    }
    return _groups;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    UIButton *BT1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.size.width, 200)];
//    BT1.backgroundColor = [UIColor blackColor];
//    
//    [self.view addSubview:BT1];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self setNav];
    
    JHBalanceCell *balanceCell = [[JHBalanceCell alloc] init];
    self.balanceCell = balanceCell;
    
    JHMoneyCell *moneyCell = [[JHMoneyCell alloc] init];
    self.moneyCell = moneyCell;
    
    SmallListCell *myActivitiesCell=[[SmallListCell alloc]init];
    self.myActivitiesCell=myActivitiesCell;
    myActivitiesCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    myActivitiesCell.titleLabel.text=@"我的订单";
    myActivitiesCell.titleLabel.font=kFONT;
    myActivitiesCell.iconImageView.image=[UIImage imageNamed:@"icon_personal_activity@2x"];
    
    SmallListCell *myMessagesCell=[[SmallListCell alloc]init];
    self.myMessagesCell=myMessagesCell;
    myMessagesCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    myMessagesCell.titleLabel.text=@"我的账单";
    myMessagesCell.titleLabel.font=kFONT;
    myMessagesCell.iconImageView.image=[UIImage imageNamed:@"icon_personal_news@1x"];
    
    
    
    SmallListCell *myServantCell=[[SmallListCell alloc]init];
    self.myServantCell=myServantCell;
    myServantCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    myServantCell.titleLabel.text=@"我的认证";
    myServantCell.titleLabel.font=kFONT;
    myServantCell.iconImageView.image=[UIImage imageNamed:@"icon_personal_callNumber@2x"];
    
    
    SmallListCell *assistanceCell=[[SmallListCell alloc]init];
    self.assistanceCell=assistanceCell;
    assistanceCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    assistanceCell.titleLabel.text=@"安全中心";
    assistanceCell.titleLabel.font=kFONT;
    assistanceCell.iconImageView.image=[UIImage imageNamed:@"icon_wallet_safe"];


}



#pragma =====dataSource=====

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==1){
        return  10;
        
    }else{
    return 0;
}
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        return  160;
        
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
        
        return self.balanceCell;
        
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
    
    //设置左边的item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back_withtext" hltImage:@"navigationbar_back_withtext" target:self action:@selector(homeshow:)];
    
    //设置右边的扫码
    
     self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_code_withtext" hltImage:@"navigationbar_code_withtext" target:self action:@selector(pop:)];
    
}

- (void)homeshow:(UIButton *)btn{
    NSLog(@"%s",__func__);
    
    JHHomeController *ctrl = [[JHHomeController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)pop:(UIButton *)btn{
    NSLog(@"%s",__func__);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"您目前还未进行线下认证,请耐心等待工作人员与您联系" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    [alertView show];

}





@end
