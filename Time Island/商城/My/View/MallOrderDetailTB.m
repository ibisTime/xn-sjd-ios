//
//  MallOrderDetailTB.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallOrderDetailTB.h"
#import "orderDetailCell.h"
@interface MallOrderDetailTB()<UITableViewDelegate,UITableViewDataSource,ClickButtonDelegrate>{
    orderDetailCell *cell;
}

@end

@implementation MallOrderDetailTB
static NSString *identifierCell = @"orderDetailCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = kBackgroundColor;
        
        [self registerClass:[orderDetailCell class] forCellReuseIdentifier:identifierCell];
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
    return self.model.detailList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    static NSString *rid=identifierCell;
    
    cell=[tableView dequeueReusableCellWithIdentifier:identifierCell];
    
    if(cell==nil){

        cell=[[orderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:identifierCell];
        
    }
    cell.shownum = indexPath.row;
    cell.model= self.model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;cell.btn2.tag = indexPath.row;
    [cell.btn2 addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.btn1.tag = indexPath.row;
    [cell.btn1 addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];

    

    
    return cell;
   
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

        return 163;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView =[UIView new];
    headView.frame = CGRectMake(0, 0, kScreenWidth, 40);
    UILabel *shopCard = [UILabel labelWithFrame:CGRectMake(15, 10, kWidth(120), 22) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
    shopCard.text = self.model.sellersName;
    UILabel *orderStatus = [UILabel labelWithFrame:CGRectMake(kScreenWidth-kWidth(135), 10, kWidth(120), 22) textAligment:NSTextAlignmentRight backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
    orderStatus.text = @"待收货";
    [headView addSubview:shopCard];
    [headView addSubview:orderStatus];
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
-(void)clickBtn:(UIButton *)sender{
    if (self.payback) {

//        self.payback(<#NSString *code#>);
    }
//    [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:inse]
}

-(void)click:(UIButton *)sender{
    [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
}
@end
