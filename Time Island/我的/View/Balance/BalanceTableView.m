//
//  BalanceTableView.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/11.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BalanceTableView.h"
#import "BalanceCell.h"
#define Balance @"BalanceCell"
@interface BalanceTableView ()<UITableViewDelegate, UITableViewDataSource>
{
    UIButton *selectBtn;
    UIView *lineView;
}
@end
@implementation BalanceTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[BalanceCell class] forCellReuseIdentifier:Balance];
        
        
    }
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.CarbonModels.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BalanceCell *cell = [tableView dequeueReusableCellWithIdentifier:Balance forIndexPath:indexPath];
    cell.CarbonModel = self.CarbonModels[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
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
