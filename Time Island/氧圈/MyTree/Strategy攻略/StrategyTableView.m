//
//  StrategyTableView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "StrategyTableView.h"
#import "ToObtainABubbleCell.h"
#define ToObtainABubble @"ToObtainABubbleCell"
#import "DonateFriendCell.h"
#define DonateFriend @"DonateFriendCell"
@interface StrategyTableView()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation StrategyTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[ToObtainABubbleCell class] forCellReuseIdentifier:ToObtainABubble];
        
        [self registerClass:[DonateFriendCell class] forCellReuseIdentifier:DonateFriend];
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
        ToObtainABubbleCell *cell = [tableView dequeueReusableCellWithIdentifier:ToObtainABubble forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = kTabbarColor;
        return cell;
    }
    
    
    
    DonateFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:DonateFriend forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = kTabbarColor;
    return cell;
    
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 967/2 + 15;
    }
    
    
    return 865/2 + 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    
    return 0.1;
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    return [UIView new];
}

-(void)BtnClick:(UIButton *)sender
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

@end
