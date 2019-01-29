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
@interface MyTreeTableView()<UITableViewDelegate, UITableViewDataSource,MyTreeHeadDelegate,MyFreeDynamicDelegate>
{
    UIButton *selectBtn;
    UIView *lineView;
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
        
    }
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 10;
    }
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        MyTreeHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:MyTreeHead forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.energyModels = self.energyModels;
        return cell;
    }
    
    if (indexPath.section == 1) {
        MyFreeDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:MyFreeDynamic forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
    
    CollectEnergyDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectEnergyDetails forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return kHeight(432);
    }
    if (indexPath.section == 1) {
        return 70;
    }
    
    return 40;
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
            if (i == 0) {
                btn.selected = YES;
                selectBtn = btn;
            }
            btn.tag = 100 + i;
            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [headView addSubview:btn];
        }
        
        
        
        lineView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3/2 - 30, 45 - 2, 60, 2)];
        lineView.backgroundColor = kHexColor(@"#23AD8C");
        kViewRadius(lineView, 1.5);
        [headView addSubview:lineView];
        
        return headView;
    }
    
    return [UIView new];
}

-(void)BtnClick:(UIButton *)sender
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 2) {
        return 41 + kBottomInsetHeight;
    }
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 2) {
        UIView *footView = [[UIView alloc]init];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = kLineColor;
        [footView addSubview:lineView];
        
        UIButton *moreBtn = [UIButton buttonWithTitle:@"更多查看" titleColor:kTextBlack backgroundColor:kClearColor titleFont:13];
        moreBtn.frame = CGRectMake(0, 1, SCREEN_WIDTH, 40);
        [footView addSubview:moreBtn];
        
        return footView;
    }
    return [UIView new];
}

@end
