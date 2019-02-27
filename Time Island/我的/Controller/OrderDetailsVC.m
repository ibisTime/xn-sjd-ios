//
//  OrderDetailsVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/18.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "OrderDetailsVC.h"
#import "OrderFootCell.h"
#import "OrderModel.h"
#define OrderFoot @"OrderFootCell"
#import "OrderCell.h"
#define order @"OrderCell"
#import "OrderTreeListCell.h"
#define OrderTreeList @"OrderTreeListCell"
@interface OrderDetailsVC (){
    UIImageView * State;
    UILabel * StateLab;
    UILabel * BeginTime;
    UILabel * EndTime;
}
@property (nonatomic,strong) UIView * HeadView;
@property (nonatomic,strong) UIView * FootView;
@property (nonatomic,strong) TLTableView * TableView;
@property (nonatomic,strong) OrderModel * ordermodel;
@property (nonatomic,strong) NSArray * SellTypeArray;
@property (nonatomic,strong) NSArray * contentarr;
@property (nonatomic,strong) NSArray * timearr;
@end

@implementation OrderDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self getdata];
//    [self SetHeadView];
//    [self SetFootView];
    
    self.TableView = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.TableView.delegate = self;
    self.TableView.dataSource = self;
    [self.TableView registerClass:[OrderFootCell class] forCellReuseIdentifier:@"cell"];
//    self.TableView.tableHeaderView = self.HeadView;
//    self.TableView.tableFooterView = self.FootView;
    [self.TableView registerClass:[OrderFootCell class] forCellReuseIdentifier:OrderFoot];
    [self.TableView registerClass:[OrderCell class] forCellReuseIdentifier:order];
    [self.TableView registerClass:[OrderTreeListCell class] forCellReuseIdentifier:OrderTreeList];
    self.TableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.TableView];
}
-(void)SetHeadView{
    self.HeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 135)];
    
    State = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 24, 28, 48, 48)];
    State.layer.cornerRadius = 24;
    State.layer.masksToBounds = YES;
    State.image = kImage(@"订单过期");
    [self.HeadView addSubview:State];
    
    StateLab = [UILabel labelWithFrame:CGRectMake(0, State.yy + 10, SCREEN_WIDTH, 21) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(15) textColor:kHexColor(@"#2D2D2D")];
//    StateLab.text = @"订单过期";
    int status = [self.OrderModel.status intValue];
    switch (status) {
        case 3:
            StateLab.text = @"认养中";
            State.image = kImage(@"订单完成");
            break;
        case 1:
            StateLab.text = @"已取消";
            State.image = kImage(@"订单已取消");
            break;
        default:
            break;
    }
    [self.HeadView addSubview:StateLab];
    
}
-(void)SetFootView{
    self.FootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 110)];
    UILabel * label1 = [UILabel labelWithFrame:CGRectMake(10, 17.5, 55, 18.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#2D2D2D")];
    label1.text = @"起始时间";
    [self.FootView addSubview:label1];
    
    BeginTime = [UILabel labelWithFrame:CGRectMake(label1.xx + 38, 17.5, SCREEN_WIDTH - label1.xx + 38 - 15, 18.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#2D2D2D")];
    BeginTime.text = [self.OrderModel.product[@"raiseStartDatetime"] convertToDetailDate];
    [self.FootView addSubview:BeginTime];
    
    [self.FootView addSubview:[self createview:CGRectMake(15, 54, SCREEN_WIDTH - 30, 1)]];
    
    UILabel * label2 = [UILabel labelWithFrame:CGRectMake(10, 72.5, 55, 18.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#2D2D2D")];
    label2.text = @"终止时间";
    [self.FootView addSubview:label2];
    
    EndTime = [UILabel labelWithFrame:CGRectMake(label2.xx + 38, 72.5 , SCREEN_WIDTH - label2.xx + 38 - 15, 18.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#2D2D2D")];
    EndTime.text = [self.OrderModel.product[@"raiseEndDatetime"] convertToDetailDate];
    [self.FootView addSubview:EndTime];
    [self.FootView addSubview:[self createview:CGRectMake(15, 109, SCREEN_WIDTH - 30, 1)]];
    
    self.FootView.backgroundColor = kWhiteColor;
}







-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return self.ordermodel.treeList.count;
    }
    else if (section == 0){
        return 4;
    }
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            OrderFootCell * cell = [tableView dequeueReusableCellWithIdentifier:OrderFoot forIndexPath:indexPath];
            cell.OrderModel = self.OrderModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        NSArray * titlearr = @[@"下单时间",@"订单类型",@"支付方式"];
        
        OrderCell * cell = [tableView dequeueReusableCellWithIdentifier:order forIndexPath:indexPath];
        cell.title = titlearr[indexPath.row - 1];
        cell.content = self.contentarr[indexPath.row - 1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.section == 1){
        OrderTreeListCell * cell = [tableView dequeueReusableCellWithIdentifier:OrderTreeList forIndexPath:indexPath];
        cell.OrderModel = self.ordermodel;
        cell.treeList = self.ordermodel.treeList[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    NSArray * titlearr = @[@"起始时间",@"终止时间"];
    OrderCell * cell = [tableView dequeueReusableCellWithIdentifier:order forIndexPath:indexPath];
    cell.title = titlearr[indexPath.row];
    cell.content = self.timearr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 140;
        }
        else
            return 55;
    }
    else if (indexPath.section == 1){
        return 100;
    }
    return 55;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 16.5)];
        view.backgroundColor = kWhiteColor;
        UILabel * OrderIdlab = [[UILabel alloc]initWithFrame:CGRectMake(15, 9.5, SCREEN_WIDTH - 40 - 30, 16.5) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#666666")];
        OrderIdlab.text = @"树木列表";
        [view addSubview:OrderIdlab];
        [view addSubview:[self createview:CGRectMake(0, 29, SCREEN_WIDTH, 1)]];
        return view;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 30;
    }
    return 0.01;
}
-(UIView*)createview:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kLineColor;
    return view;
}

-(void)getdata{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629046";
    http.parameters[@"code"] = self.OrderModel.code;
    [http postWithSuccess:^(id responseObject) {
        self.ordermodel = [OrderModel mj_objectWithKeyValues:responseObject[@"data"]];
        
        //专属
        TLNetworking * http3 = [[TLNetworking alloc]init];
        http3.code = @"630036";
        http3.parameters[@"parentKey"] = @"sell_type";
        [http3 postWithSuccess:^(id responseObject) {
            NSDictionary * dic = (NSDictionary * )responseObject;
            self.SellTypeArray = dic[@"data"];
            NSString * str;
            for (int i = 0; i < self.SellTypeArray.count; i++) {
                if ([self.ordermodel.product[@"sellType"] isEqualToString:self.SellTypeArray[i][@"dkey"]]) {
                    str = self.SellTypeArray[i][@"dvalue"];
                }
            }
            self.contentarr = @[[self.ordermodel.payDatetime convertToDetailDate],str,@"456"];
            [self.TableView reloadData];
        } failure:^(NSError *error) {
        }];
        
        self.timearr = @[[self.ordermodel.payDatetime convertToDetailDateWithoutHour],[self.ordermodel.endDatetime convertToDetailDateWithoutHour]];
        [self.TableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    
    
}

@end
