//
//  RankingTableView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "RankingTableView.h"
#import "RankingCell.h"
#import "MineRankCell.h"
#define Ranking @"RankingCell"
#define MineRank @"MineRankCell"

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
        [self registerClass:[MineRankCell class] forCellReuseIdentifier:MineRank];
        
    }
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        if ([self.state isEqualToString:@"rank"]) {
            return self.RankModels.count;
        }
        else if ([self.state isEqualToString:@"friend"]){
            return self.FriendsModels.count;
        }
    
    }
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        MineRankCell *cell = [tableView dequeueReusableCellWithIdentifier:MineRank forIndexPath:indexPath];
        
            if ([self.state isEqualToString:@"friend"]){
                for (int i = 0; i < self.FriendsModels.count; i++) {
                    FriendsModel * model = self.FriendsModels[i];
                    if ([[TLUser user].userId isEqualToString:model.toUser]) {
                        cell.FriendsModel = model;
                    }
                }
            }
            else if ([self.state isEqualToString:@"rank"]){
                for (int i = 0; i < self.RankModels.count; i++) {
                RankModel * model = self.RankModels[i];
                if ([[TLUser user].userId isEqualToString:model.userId]) {
                    cell.RankModel = model;
                }
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    
    RankingCell *cell = [tableView dequeueReusableCellWithIdentifier:Ranking forIndexPath:indexPath];
    if ([self.state isEqualToString:@"rank"]) {
        cell.RankModel = self.RankModels[indexPath.row];
    }
    else if ([self.state isEqualToString:@"friend"]){
        cell.FriendsModel = self.FriendsModels[indexPath.row];
    }
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
-(void)setRankModels:(NSMutableArray<RankModel *> *)RankModels{
    _RankModels = RankModels;
}
@end
