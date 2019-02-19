//
//  MyTreeTableView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/10.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MyTreeTableView.h"
#import "MyTreeHeadCell.h"
#define MyTreeHead @"MyTreeHeadCell"
#import "MyFreeDynamicCell.h"
#define MyFreeDynamic @"MyFreeDynamicCell"
#import "CollectEnergyDetailsCell.h"
#define CollectEnergyDetails @"CollectEnergyDetailsCell"
#import "DanmuCell.h"
#define Danmucell @"DanmuCell"
#import "PersonalCenterExpressionCell.h"
#define PersonalCenterExpression @"PersonalCenterExpressionCell"
#import "IntroduceCell.h"
#define Introduce @"Introduce.h"
#import "TreeDetailCell.h"
#define TreeDetail @"TreeDetailCell"
@interface MyTreeTableView()<UITableViewDelegate, UITableViewDataSource,MyTreeHeadDelegate,MyFreeDynamicDelegate>
{
    UIButton *selectBtn;
    UIView *lineView;
    NSInteger state;
}

@end

@implementation MyTreeTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[MyTreeHeadCell class] forCellReuseIdentifier:MyTreeHead];
        [self registerClass:[MyFreeDynamicCell class] forCellReuseIdentifier:MyFreeDynamic];
        [self registerClass:[CollectEnergyDetailsCell class] forCellReuseIdentifier:CollectEnergyDetails];
//        [self registerClass:[PersonalCenterExpressionCell class] forCellReuseIdentifier:PersonalCenterExpression];
        [self registerClass:[DanmuCell class] forCellReuseIdentifier:Danmucell];
        [self registerClass:[IntroduceCell class] forCellReuseIdentifier:Introduce];
        [self registerClass:[TreeDetailCell class] forCellReuseIdentifier:TreeDetail];
    }
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        if (state == 0) {
            return 1;
        }else
        {
            return 0;
        }
    }
    if (section == 2) {
        if (state == 0) {
            return self.DynamicModels.count;
        }
        else if (state == 1){
            return 1;
        }
        else{
            return 8;
        }
        
    }
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        MyTreeHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:MyTreeHead forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.energyModels = self.energyModels;
        cell.model = self.model;
        return cell;
    }
    
    if (indexPath.section == 1) {
        MyFreeDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:MyFreeDynamic forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.DynamicPhotoModels = self.DynamicPhotoModels;
        cell.delegate = self;
        return cell;
    }
    
    
    if (state == 0) {
        DynamicModel *model = [DynamicModel mj_objectWithKeyValues:self.DynamicModels[indexPath.row]];
        
        if ([model.type isEqualToString:@"7"]) {
            DanmuCell *cell = [tableView dequeueReusableCellWithIdentifier:Danmucell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.dynamicModel = model;
            
            
            return cell;
        }
        
        CollectEnergyDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectEnergyDetails forIndexPath:indexPath];
        cell.model = self.model;
        cell.DynamicModel = self.DynamicModels[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (state == 1){
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
    return cell;
    
    
    
}

-(void)MyTreeHeadButton:(NSInteger)tag
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:tag];
}

-(void)MyFreeDynamicButton:(NSInteger)tag
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:tag];
}
-(void)paopaoclick:(MyTreeEnergyModel *)model{
    NSLog(@"%s",__func__);
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629350";
    http.parameters[@"code"] = model.code;
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        [self reloadData];
    } failure:^(NSError *error) {
        
    }];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return kHeight(432);
    }
    else if (indexPath.section == 1) {
        return kHeight(60);
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    if (section == 1) {
        return 45;
    }
    return 0.1;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:scrollView:)]) {
        [self.refreshDelegate refreshTableView:self scrollView:scrollView];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        
        UIView *headView = [UIView new];
        
        NSArray *btnArray = @[@"最新动态",@"认养人介绍",@"树木详情"];
        for (int i = 0; i < 3; i ++) {
            UIButton *btn = [UIButton buttonWithTitle:btnArray[i] titleColor:kHexColor(@"#666666") backgroundColor:kWhiteColor titleFont:15];
            btn.frame = CGRectMake(i % 3 * SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 45);
            [btn setTitleColor:kHexColor(@"#23AD8C") forState:(UIControlStateSelected)];
            if (i == state) {
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
        
        lineView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3/2 - 30 + state*(SCREEN_WIDTH/3), 45 - 2, 60, 2)];
        lineView.backgroundColor = kHexColor(@"#23AD8C");
        kViewRadius(lineView, 1.5);
        [headView addSubview:lineView];
        
        return headView;
    }
    
    return [UIView new];
}

-(void)BtnClick:(UIButton *)sender
{
    state = sender.tag - 100;
    [self reloadData];
    [self.refreshDelegate refreshTableViewButtonClick:self button:sender state:@"点击"];
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 2) {
        if (state == 0) {
            return 41 + kBottomInsetHeight;
        }
        
    }
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 2) {
        if (state == 0) {
            UIView *footView = [[UIView alloc]init];
            
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = kLineColor;
            [footView addSubview:lineView];
            
            UIButton *moreBtn = [UIButton buttonWithTitle:@"更多查看" titleColor:kTextBlack backgroundColor:kClearColor titleFont:13];
            moreBtn.frame = CGRectMake(0, 1, SCREEN_WIDTH, 40);
            [footView addSubview:moreBtn];
            
            return footView;
        }
        
    }
    return [UIView new];
}


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
    
}

-(void)getCollectEnergyDetailsdata{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629305";
    http.parameters[@"status"] = @(0);
    http.parameters[@"limit"] = @(10);
    http.parameters[@"start"] = @(1);
    http.parameters[@"adoptTreeCode"] = self.model.code;
    http.parameters[@"queryUserId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        self.DynamicModels = [DynamicModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        self.DynamicPhotoModels = [NSMutableArray array];
        DynamicModel * model1;
        for (int i = 0; i < self.DynamicModels.count; i ++) {
            model1 = self.DynamicModels[i];
            if ([model1.type isEqualToString:@"3"]) {
                [self.DynamicPhotoModels addObject:self.DynamicModels[i]];
            }
        }
        
        [self reloadData_tl];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)setModel:(PersonalCenterModel *)model{
    _model = model;
    
    [self getdata];
    [self getCollectEnergyDetailsdata];
    
    

}
@end
