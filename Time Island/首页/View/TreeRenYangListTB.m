//
//  TreeRenYangListTB.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/10.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TreeRenYangListTB.h"
#import "RenYangListCell.h"
@interface TreeRenYangListTB()<UITableViewDelegate, UITableViewDataSource>


@end

static NSString *identifierCell = @"FiledCell";
@implementation TreeRenYangListTB
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = kBackgroundColor;
        
        [self registerClass:[RenYangListCell class] forCellReuseIdentifier:identifierCell];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}
#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    RenYangListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell forIndexPath:indexPath];
//    NSArray *titles = @[@"树木名称",@"树木学名",@"树木级别",@"树木品种",@"所在市县",@"乡镇街道",@"树木产地",@"认养时间",@"树木定位"];
//    NSArray *details = @[@"习总书记栽种的下姜村一级樟树",@"樟科樟树",@"一级",@"樟树",@"浙江省淳安县",@"下姜村桥头",@"枫树岭镇",@"2018.12.25-2019.12.25",@""];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.moreLab.text = [NSString stringWithFormat:@"[%@]",titles[indexPath.row]];
//    cell.detailLab.text = [NSString stringWithFormat:@"%@",details[indexPath.row]];
//    if (indexPath.row == 8) {
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
//        
//    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}


@end
