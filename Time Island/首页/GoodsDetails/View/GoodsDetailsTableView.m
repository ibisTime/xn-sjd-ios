//
//  GoodsDetailsTableView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/21.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "GoodsDetailsTableView.h"

#import "GoodsDetailsInfomationCell.h"
#define GoodsDetailsInfomation @"GoodsDetailsInfomationCell"
#import "RenYangListCell.h"
#define RenYangList @"RenYangListCell"
#import "TreeFiledCell.h"
#define TreeFiled @"TreeFiledCell"
#import "GoodsDetailsHeadView.h"
@interface GoodsDetailsTableView()<UITableViewDelegate, UITableViewDataSource,GoodsDetailsHeadDelegate>




@end

@implementation GoodsDetailsTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[GoodsDetailsInfomationCell class] forCellReuseIdentifier:GoodsDetailsInfomation];
        self.SelectHeader = 0;
        [self registerClass:[RenYangListCell class] forCellReuseIdentifier:RenYangList];
        [self registerClass:[TreeFiledCell class] forCellReuseIdentifier:TreeFiled];
    }
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 1) {
        if (self.SelectHeader == 1) {
            return 9;
        }else
        {
            return 20;
        }
    }
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        GoodsDetailsInfomationCell *cell = [tableView dequeueReusableCellWithIdentifier:GoodsDetailsInfomation forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (self.SelectHeader == 1) {
        TreeFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:TreeFiled forIndexPath:indexPath];
        NSArray *titles = @[@"树木名称",@"树木学名",@"树木级别",@"树木品种",@"所在市县",@"乡镇街道",@"树木产地",@"认养时间",@"树木定位"];
        NSArray *details = @[@"习总书记栽种的下姜村一级樟树",@"樟科樟树",@"一级",@"樟树",@"浙江省淳安县",@"下姜村桥头",@"枫树岭镇",@"2018.12.25-2019.12.25",@""];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.moreLab.text = [NSString stringWithFormat:@"[%@]",titles[indexPath.row]];
        cell.detailLab.text = [NSString stringWithFormat:@"%@",details[indexPath.row]];
        if (indexPath.row == 8) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            
        }
        return cell;
    }else
    {
        RenYangListCell *cell = [tableView dequeueReusableCellWithIdentifier:RenYangList forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    
}

-(void)MyTreeHeadButton:(NSInteger)tag
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:tag];
}

-(void)MyFreeDynamicButton:(NSInteger)tag
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:tag];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 180;
    }
    if (indexPath.section == 1) {
        if (self.SelectHeader == 1) {
            return 40;
        }else
        {
            return 50;
        }
    }
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    if (section == 1) {
        return 40;
    }
    return 0.1;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:scrollView:)]) {
        [self.refreshDelegate refreshTableView:self scrollView:scrollView];
    }
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        
        
        GoodsDetailsHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
        if (!headView) {
            headView = [[GoodsDetailsHeadView alloc]initWithReuseIdentifier:@"header"];
        }
        headView.delegate = self;
        return headView;
    }
    
    return [UIView new];
}

-(void)GoodsDetailsHeadButton:(NSInteger)tag
{
    self.SelectHeader = tag;
    [self reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 2) {
        UIView *footView = [[UIView alloc]init];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = kLineColor;
        [footView addSubview:lineView];
        
        UIButton *moreBtn = [UIButton buttonWithTitle:@"更多查看" titleColor:kTextBlack backgroundColor:kClearColor titleFont:13];
        moreBtn.frame = CGRectMake(0, 1, SCREEN_WIDTH, 40);
        [footView addSubview:moreBtn];
        
        return footView;
    }
    return [UIView new];
}

@end
