//
//  ExpressTableView.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "ExpressTableView.h"
#import "ExpressCell.h"

@interface ExpressTableView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation ExpressTableView
static NSString *identifierCell = @"ExpressCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = kBackgroundColor;
        
        [self registerClass:[ExpressCell class] forCellReuseIdentifier:identifierCell];
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *identifier = [NSString stringWithFormat:@"%ld%ldcell", indexPath.section, indexPath.row];
    ExpressCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell = [[ExpressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.statusLab.text = @"货物开始配送,感谢您使用申通快递,正在派件 派件员: 张三 手机号 13588723322";
    cell.timeLab.text = @"2019-01-25 12:40:30";
    if (indexPath.row == 0) {
        cell.isTop = YES;
    }else if (indexPath.row == 9) {
        cell.isBottom = YES;
    }else{
        cell.iscenterView = YES;
    }
    return cell;
   
    
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 130;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView =[UIView new];
    headView.frame = CGRectMake(0, 0, kScreenWidth, 40);
    UILabel *shopCard = [UILabel labelWithFrame:CGRectMake(15, 10, kWidth(120), 22) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
    shopCard.text = @"店铺名称";
    UILabel *orderStatus = [UILabel labelWithFrame:CGRectMake(kScreenWidth-135, 10, kWidth(120), 22) textAligment:NSTextAlignmentRight backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
    orderStatus.text = @"待收货";
    [headView addSubview:shopCard];
    [headView addSubview:orderStatus];
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}



@end
