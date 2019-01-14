//
//  RankingTableView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "RankingTableView.h"
#import "RankingCell.h"
#define Ranking @"RankingCell"


@interface RankingTableView()<UITableViewDelegate, UITableViewDataSource>
{
    UIButton *selectBtn;
    UIView *lineView;
}

@end

@implementation RankingTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[RankingCell class] forCellReuseIdentifier:Ranking];

        
    }
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        return 100;
    }
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        RankingCell *cell = [tableView dequeueReusableCellWithIdentifier:Ranking forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.numberImg.hidden = YES;
        cell.numberLbl.text = @"99";
        return cell;
    }
    
    
    
    RankingCell *cell = [tableView dequeueReusableCellWithIdentifier:Ranking forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.numberImg.hidden = NO;
        cell.numberLbl.hidden = YES;
        cell.numberImg.image = kImage(@"冠军");
        
    }
    if (indexPath.row == 1) {
        cell.numberImg.hidden = NO;
        cell.numberLbl.hidden = YES;
        cell.numberImg.image = kImage(@"亚军");
        
    }
    if (indexPath.row == 2) {
        cell.numberImg.hidden = NO;
        cell.numberLbl.hidden = YES;
        cell.numberImg.image = kImage(@"季军");
        
    }
    if (indexPath.row >= 3) {
        cell.numberImg.hidden = YES;
        cell.numberLbl.hidden = NO;
        cell.numberLbl.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    }
    
    return cell;
    
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 65;
}





- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 10;
    }
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

@end
