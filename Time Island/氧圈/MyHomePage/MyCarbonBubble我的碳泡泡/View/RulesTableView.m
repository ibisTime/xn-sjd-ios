//
//  RulesTableView.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/21.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "RulesTableView.h"
#import "RulesCell.h"
#define Rules @"RulesCell"
@implementation RulesTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[RulesCell class] forCellReuseIdentifier:Rules];
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.RulesModels.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RulesCell * cell = [tableView dequeueReusableCellWithIdentifier:Rules forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 1) {
        cell.RulesModel = self.RulesModels[indexPath.row];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 51;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
@end
