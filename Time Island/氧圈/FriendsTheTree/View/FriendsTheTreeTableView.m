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
@interface FriendsTheTreeTableView()<UITableViewDelegate, UITableViewDataSource,FriendsTreeHeadDelegate>
{
    UIButton *selectBtn;
    UIView *lineView;
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
        
    }
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section >= 2) {
        return 5;
    }
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        FriendsTreeHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:FriendsTreeHead forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.donation = self.donation;
        return cell;
    }
    if (indexPath.section == 1) {
        EnergyCompeteCell *cell = [tableView dequeueReusableCellWithIdentifier:EnergyCompete forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    
    HisDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:HisDynamic forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 4) {
        cell.bottomLineView.hidden = YES;
    }else
    {
        cell.bottomLineView.hidden = NO;
    }
    return cell;
    
    
    
}

-(void)FriendsTreeHeadButton:(NSInteger)tag
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:tag];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return kHeight(432);
    }
    if (indexPath.section == 1) {
        return kHeight(140);
    }
    
    return 48;
}




-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:scrollView:)]) {
        [self.refreshDelegate refreshTableView:self scrollView:scrollView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section >= 2) {
        return 35;
    }
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    
    
    if (section >= 2) {
        UIView *headerView = [UIView new];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
        backView.backgroundColor = kWhiteColor;
        [headerView addSubview:backView];
        
        
        
        
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 6, SCREEN_WIDTH - 30, 18) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(18) textColor:kTextBlack];
        nameLabel.text = [LangSwitcher switchLang:@"今天" key:nil];
        [headerView addSubview:nameLabel];
        
        UIView *roundView = [[UIView alloc]initWithFrame:CGRectMake(30, nameLabel.yy + 5 , 6, 6)];
        roundView.backgroundColor = kHexColor(@"#CCCCCC");
        kViewRadius(roundView, 3);
        [backView addSubview:roundView];
        
        return headerView;
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
        UIView *footView = [UIView new];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 52.5)];
        backView.backgroundColor = kWhiteColor;
        [footView addSubview:backView];
        
        
        UIView *footlineView = [[UIView alloc]initWithFrame:CGRectMake(15, 21, 3, 15)];
        footlineView.backgroundColor = kHexColor(@"#23AD8C");
        kViewRadius(footlineView, 1.5);
        [backView addSubview:footlineView];
        
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(footlineView.xx + 6, 20, SCREEN_WIDTH - lineView.xx - 21, 17) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(17) textColor:kTextBlack];
        nameLabel.text = [LangSwitcher switchLang:@"TA的动态" key:nil];
        [backView addSubview:nameLabel];
        
        return footView;
    }
    return [UIView new];
}

@end
