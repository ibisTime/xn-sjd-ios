//
//  InviteVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "InviteVC.h"
#import "InviteVCCell.h"

@interface InviteVC ()<RefreshDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) TLTableView * table;
@property (nonatomic,retain) UIView * topview;

@end

@implementation InviteVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请记录";
    self.topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 85)];
    
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    view1.backgroundColor = kHexColor(@"#F6533F");
    view1.alpha = 0.1;
//    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 11, SCREEN_WIDTH - 15, 18.5) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#F6533F")];
//    label.text = @"您已成功邀请10人注册";
//    label.alpha = 1;
//    [view1 addSubview:label];
    [self.topview addSubview:view1];
    
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH - 30, 45)];
    
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 18.5, 30, 18)];
    label1.textColor = kBlackColor;
    label1.text = @"昵称";
    label1.font = FONT(12);
    label1.textAlignment = NSTextAlignmentCenter;
    [view2 addSubview:label1];
    
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 3, 18.5, 30, 18)];
    label2.textColor = kBlackColor;
    label2.text = @"佣金";
    label2.font = FONT(12);
    label2.textAlignment = NSTextAlignmentCenter;
    [view2 addSubview:label2];
    
    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 2 / 3, 18.5, 55, 18)];
    label3.textColor = kBlackColor;
    label3.text = @"注册时间";
    label3.font = FONT(12);
    label3.textAlignment = NSTextAlignmentCenter;
    [view2 addSubview:label3];
    
    [self.topview addSubview:view2];
    
    
    
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 11, SCREEN_WIDTH - 15, 18.5) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#F6533F")];
    label.text = @"您已成功邀请10人注册";
    label.alpha = 1;
    [self.topview addSubview:label];
    
    
    

    
    self.table = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.refreshDelegate = self;
    self.table.tableHeaderView = self.topview;
    [self.view addSubview:self.table];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InviteVCCell * cell = [[InviteVCCell alloc]init];
    cell.namelab.text = @"隐隐约约隐隐约约隐隐约约隐隐约约有";
    cell.moneylab.text = @"123456789098765";
    cell.selectionStyle = UIAccessibilityTraitNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s",__func__);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}
@end
