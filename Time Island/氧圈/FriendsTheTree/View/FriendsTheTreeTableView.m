//
//  FriendsTheTreeTableView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "FriendsTheTreeTableView.h"
#import "FriendsTreeHeadCell.h"
#define FriendsTreeHead @"FriendsTreeHeadCell"
#import "EnergyCompeteCell.h"
#define EnergyCompete @"EnergyCompeteCell"
#import "HisDynamicCell.h"
#define HisDynamic @"HisDynamicCell"
#import "DanmuCell.h"
#define Danmucell @"DanmuCell"
#import "BarrageView.h"
#import "IntroduceCell.h"
#define Introduce @"IntroduceCell"
#import "TreeDetailCell.h"
#define TreeDetail @"TreeDetailCell"
@interface FriendsTheTreeTableView()<UITableViewDelegate, UITableViewDataSource,FriendsTreeHeadDelegate>
{
    UIButton *selectBtn;
    UIView *lineView;
    NSInteger state1;
}

@end

@implementation FriendsTheTreeTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[FriendsTreeHeadCell class] forCellReuseIdentifier:FriendsTreeHead];
        [self registerClass:[EnergyCompeteCell class] forCellReuseIdentifier:EnergyCompete];
        [self registerClass:[HisDynamicCell class] forCellReuseIdentifier:HisDynamic];
        [self registerClass:[DanmuCell class] forCellReuseIdentifier:Danmucell];
        [self registerClass:[IntroduceCell class] forCellReuseIdentifier:Introduce];
        [self registerClass:[TreeDetailCell class] forCellReuseIdentifier:TreeDetail];
    }
    
    return self;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section >= 2) {
        if (state1 == 0) {
            return self.DynamicModels.count;
        }
        else if (state1 == 1){
            return 1;
        }else
            return 8;
        
    }
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        FriendsTreeHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:FriendsTreeHead forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.donation = self.donation;
        cell.model = self.model;
        
        cell.energyModels = self.energyModels;
        
        if ([USERXX isBlankString:self.barrageModel.content] == NO) {
            cell.barrageModel = self.barrageModel;
            self.barrageModel = nil;
        }
        
        return cell;
    }
    if (indexPath.section == 1) {
        EnergyCompeteCell *cell = [tableView dequeueReusableCellWithIdentifier:EnergyCompete forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.CompeteModel = self.CompeteModel;
        return cell;
    }

    if (state1 == 0) {
        DynamicModel * model = self.DynamicModels[indexPath.row];
        if ([model.type isEqualToString:@"7"]) {
            DanmuCell *cell = [tableView dequeueReusableCellWithIdentifier:Danmucell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.dynamicModel = model;
            return cell;
        }
        
        HisDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:HisDynamic forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dynamicModel = self.DynamicModels[indexPath.row];
        return cell;
    }
    else if (state1 == 1){
        IntroduceCell * cell = [tableView dequeueReusableCellWithIdentifier:Introduce forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    NSArray * arr = @[@"树木名称",@"树木级别",@"树木产地",@"认养时间",@"养护单位",@"养护负责人",@"养护记录",@"历史认养人"];
    //    self.model.tree[@"productName"];
    NSArray * detail = @[self.model.tree[@"productName"],self.model.tree[@"rank"],self.model.tree[@"area"],[NSString stringWithFormat:@"%@-%@",[self.model.startDatetime convertToDetailDateWithoutHour],[self.model.endDatetime convertToDetailDateWithoutHour] ],self.model.tree[@"maintainer"][@"company"][@"name"],self.model.tree[@"maintainer"][@"company"][@"charger"],@"",@""];
    TreeDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:TreeDetail forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titlearr = arr[indexPath.row];
    cell.detailstr = detail[indexPath.row];
    if (indexPath.row == 6 || indexPath.row == 7) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
    
    
}

-(void)FriendsTreeHeadButton:(NSInteger)tag
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:tag];
}

//泡泡点击
-(void)paopaoclick:(MyTreeEnergyModel *)model{
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629350";
    http.parameters[@"code"] = model.code;
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
//        [self reloadData];
        
        [self getdata];
        [self getcompetedata];
//        [self getHistory];
        [self getHistroyData];
        
    } failure:^(NSError *error) {
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return kHeight(432);
    }
    if (indexPath.section == 1) {
        return kHeight(140);
    }
    if (indexPath.section >= 2) {
        if (state1 == 0) {
            DynamicModel *model = [DynamicModel mj_objectWithKeyValues:_DynamicModels[indexPath.row]];
            if ([model.type isEqualToString:@"7"] || [model.type isEqualToString:@"4"]) {
                return 65;
            }
            return 48;
        }else if (state1 == 1){
            return 60;
        }
        else
            return 50;
        
    }
    return 0.01;
}




-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:scrollView:)]) {
        [self.refreshDelegate refreshTableView:self scrollView:scrollView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section >= 2) {
        if (state1 == 0) {
            return 35;
        }
        else
            return 0.001;
    }
    return 0.001;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    
    
    if (section >= 2) {
        if (state1 == 0) {
            UIView *headerView = [UIView new];
            
            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
            backView.backgroundColor = kWhiteColor;
            [headerView addSubview:backView];
            
            //        UILabel *nameLabel;
            if (self.DynamicModels.count > 0) {
                UILabel * nameLabel = [UILabel labelWithFrame:CGRectMake(15, 6, SCREEN_WIDTH - 30, 18) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(18) textColor:kTextBlack];
                nameLabel.text = [LangSwitcher switchLang:@"今天" key:nil];
                [headerView addSubview:nameLabel];
                
                UIView *roundView = [[UIView alloc]initWithFrame:CGRectMake(30, nameLabel.yy + 5 , 6, 6)];
                roundView.backgroundColor = kHexColor(@"#CCCCCC");
                kViewRadius(roundView, 3);
                [backView addSubview:roundView];
            }
            return headerView;
        }
        
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 62.5;
    }
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UIView *headView = [UIView new];
        
        NSArray *btnArray = @[@"最新动态",@"认养人介绍",@"树木详情"];
        for (int i = 0; i < 3; i ++) {
            UIButton *btn = [UIButton buttonWithTitle:btnArray[i] titleColor:kHexColor(@"#666666") backgroundColor:kWhiteColor titleFont:15];
            btn.frame = CGRectMake(i % 3 * SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 45);
            [btn setTitleColor:kHexColor(@"#23AD8C") forState:(UIControlStateSelected)];
            if (i == state1) {
                btn.selected = YES;
                //                selectBtn = btn;
            }else
            {
                btn.selected = NO;
            }
            btn.tag = 100 + i;
            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [headView addSubview:btn];
        }
        
        lineView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3/2 - 30 + state1*(SCREEN_WIDTH/3), 45 - 2, 60, 2)];
        lineView.backgroundColor = kHexColor(@"#23AD8C");
        kViewRadius(lineView, 1.5);
        [headView addSubview:lineView];
        
        return headView;
    }
    return [UIView new];
}
-(void)BtnClick:(UIButton *)sender
{
    state1 = sender.tag - 100;
    [self reloadData];
    [self.refreshDelegate refreshTableViewButtonClick:self button:sender state:@"点击"];
}

//泡泡
-(void)getdata{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629355";
    http.parameters[@"status"] = @(0);
    http.parameters[@"limit"] = @(5);
    http.parameters[@"start"] = @(1);
    http.parameters[@"adoptTreeCode"] = self.model.code;
    if (self.model.code) {
        [http postWithSuccess:^(id responseObject) {
            self.energyModels = [MyTreeEnergyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            [self reloadData_tl];
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    NSLog(@"123");
}


//比拼数据
-(void)getcompetedata{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629900";
    http.parameters[@"toUserId"] = self.model.user[@"userId"];
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        self.CompeteModel = [CompeteModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self reloadData_tl];
    } failure:^(NSError *error) {
        
    }];
}
-(void)getHistroyData{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629305";
    //    http.parameters[@"status"] = @(0);
    http.parameters[@"limit"] = @(10);
    http.parameters[@"start"] = @(1);
    http.parameters[@"adoptTreeCode"] = self.model.code;
    http.parameters[@"adoptUserId"] = self.model.user[@"userId"];
    http.parameters[@"queryUserId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        self.DynamicModels = [DynamicModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        [self reloadData_tl];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
//动态
-(void)getHistory{
CoinWeakSelf;
    
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"629305";
    helper.parameters[@"status"] = @(0);
    [helper modelClass:[DynamicModel class]];
    helper.parameters[@"adoptTreeCode"] = self.model.code;
    helper.parameters[@"adoptUserId"] = self.model.user[@"userId"];
    helper.parameters[@"queryUserId"] = [TLUser user].userId;
    helper.tableView = self;
    helper.isCurrency = YES;
    
    
    [self addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            if (objs.count > 0) {
                weakSelf.DynamicModels = objs;
            }
            [weakSelf reloadData_tl];
            [weakSelf endRefreshHeader];
        } failure:^(NSError *error) {
            [weakSelf endRefreshHeader];
        }];
    }];
    [self addLoadMoreAction:^{
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            if (objs.count > 0) {
                weakSelf.DynamicModels = objs;
                [weakSelf reloadData];
                [weakSelf endRefreshHeader];
            }
            [weakSelf reloadData_tl];
        } failure:^(NSError *error) {
            [weakSelf endRefreshHeader];
        }];
    }];
    
    [self beginRefreshing];
}

-(void)setModel:(PersonalCenterModel *)model{
    _model = model;
    [self getdata];
    [self getcompetedata];
    if ([self.state isEqualToString:@"Barrage"]) {
        [self getHistroyData];
    }
    else
        [self getHistory];
}


@end
