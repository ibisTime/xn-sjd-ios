//
//  PersonalCenterTableVIew.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/28.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "PersonalCenterTableVIew.h"


#import "FriendsTreeHeadCell.h"
#define FriendsTreeHead @"FriendsTreeHeadCell"
#import "EnergyCompeteCell.h"
#define EnergyCompete @"EnergyCompeteCell"
#import "HisDynamicCell.h"
#define HisDynamic @"HisDynamicCell"
@interface PersonalCenterTableVIew()<UITableViewDelegate, UITableViewDataSource,FriendsTreeHeadDelegate>
{
    UIButton *selectBtn;
    UIView *lineView;
}

@end

@implementation PersonalCenterTableVIew

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 48;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}


@end
