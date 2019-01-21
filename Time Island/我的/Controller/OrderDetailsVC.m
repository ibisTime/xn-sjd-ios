//
//  OrderDetailsVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/18.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "OrderDetailsVC.h"
#import "OrderFootCell.h"
@interface OrderDetailsVC ()
@property (nonatomic,strong) UIView * HeadView;
@property (nonatomic,strong) UIView * FootView;
@property (nonatomic,strong) TLTableView * TableView;
@end

@implementation OrderDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self SetHeadView];
    [self SetFootView];
    
    self.TableView = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.TableView.delegate = self;
    self.TableView.dataSource = self;
    [self.TableView registerClass:[OrderFootCell class] forCellReuseIdentifier:@"cell"];
    self.TableView.tableHeaderView = self.HeadView;
    self.TableView.tableFooterView = self.FootView;
    [self.view addSubview:self.TableView];
}
-(void)SetHeadView{
    self.HeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 135)];
    
    UIImageView * State = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 24, 28, 48, 48)];
    State.layer.cornerRadius = 24;
    State.layer.masksToBounds = YES;
    State.image = kImage(@"订单过期");
    [self.HeadView addSubview:State];
    
    UILabel * StateLab = [UILabel labelWithFrame:CGRectMake(0, State.yy + 10, SCREEN_WIDTH, 21) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(15) textColor:kHexColor(@"#2D2D2D")];
    StateLab.text = @"订单过期";
    [self.HeadView addSubview:StateLab];
    
}
-(void)SetFootView{
    self.FootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 110)];
    UILabel * label1 = [UILabel labelWithFrame:CGRectMake(10, 17.5, 55, 18.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#2D2D2D")];
    label1.text = @"起始时间";
    [self.FootView addSubview:label1];
    
    UILabel * BeginTime = [UILabel labelWithFrame:CGRectMake(label1.xx + 38, 17.5, 79.5, 18.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#2D2D2D")];
    BeginTime.text = @"2018-10-10";
    [self.FootView addSubview:BeginTime];
    
    [self.FootView addSubview:[self createview:CGRectMake(15, 54, SCREEN_WIDTH - 30, 1)]];
    
    UILabel * label2 = [UILabel labelWithFrame:CGRectMake(10, 72.5, 55, 18.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#2D2D2D")];
    label2.text = @"终止时间";
    [self.FootView addSubview:label2];
    
    UILabel * EndTime = [UILabel labelWithFrame:CGRectMake(label2.xx + 38, 72.5 , 79.5, 18.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#2D2D2D")];
    EndTime.text = @"2019-10-10";
    [self.FootView addSubview:EndTime];
    [self.FootView addSubview:[self createview:CGRectMake(15, 109, SCREEN_WIDTH - 30, 1)]];
    
    self.FootView.backgroundColor = kWhiteColor;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    OrderFootCell * cell = [[OrderFootCell alloc]init];
    OrderFootCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.OrderCount = 1;
    cell.selectionStyle = UIAccessibilityTraitNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140 * 1 - 35 * 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(UIView*)createview:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kLineColor;
    return view;
}
@end
