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
//        [self registerClass:[CollectEnergyDetailsCell class] forCellReuseIdentifier:CollectEnergyDetails];
        
    }
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        FriendsTreeHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:FriendsTreeHead forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
    
//    if (indexPath.section == 1) {
//        MyFreeDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:MyFreeDynamic forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
    
    EnergyCompeteCell *cell = [tableView dequeueReusableCellWithIdentifier:EnergyCompete forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:scrollView:)]) {
        [self.refreshDelegate refreshTableView:self scrollView:scrollView];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

@end
