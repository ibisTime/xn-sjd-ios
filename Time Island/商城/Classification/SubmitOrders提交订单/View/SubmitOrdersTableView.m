//
//  SubmitOrdersTableView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/11.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SubmitOrdersTableView.h"
#import "SubmitOrderAddressCell.h"
#import "SubmitOrderBankCardCell.h"
#import "SubmitOrderGoodsCell.h"
#import "USERXX.h"
#import "BuyCountCell.h"
#import "TransportCell.h"
#import "BuyRemarkCell.h"
#define SubmitOrderAddress @"SubmitOrderAddressCell"
#define SubmitOrderBankCard @"SubmitOrderBankCardCell"
#define SubmitOrderGoods @"SubmitOrderGoodsCell"
#define buyCountCell @"BuyCountCell"
#define transportCell @"TransportCell"
#define buyRemarkCell @"BuyRemarkCell"

@interface SubmitOrdersTableView ()<UITableViewDelegate,UITableViewDataSource>
{
    SubmitOrderAddressCell *_cell;
    NSDictionary *dataDic;
}
@end

@implementation SubmitOrdersTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[SubmitOrderAddressCell class] forCellReuseIdentifier:SubmitOrderAddress];
        [self registerClass:[SubmitOrderBankCardCell class] forCellReuseIdentifier:SubmitOrderBankCard];
        [self registerClass:[SubmitOrderGoodsCell class] forCellReuseIdentifier:SubmitOrderGoods];
        [self registerClass:[BuyCountCell class] forCellReuseIdentifier:buyCountCell];
        [self registerClass:[TransportCell class] forCellReuseIdentifier:transportCell];
        [self registerClass:[BuyRemarkCell class] forCellReuseIdentifier:buyRemarkCell];

    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if(indexPath.section == 0)
    {
        _cell = [tableView dequeueReusableCellWithIdentifier:SubmitOrderAddress forIndexPath:indexPath];
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([USERXX isBlankString:self.addressModel.addressee] == NO) {
            _cell.model = self.addressModel;
            _cell.backLabel.hidden = YES;
        }else
        {
            _cell.backLabel.hidden = NO;
        }
        return _cell;
    }
    if(indexPath.section == 1)
    {
        SubmitOrderGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:SubmitOrderGoods forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.homeModel;
        if ([USERXX isBlankString:_specificationsStr] == NO) {
            cell.dic = dataDic;
        }
        return cell;
    }
    if(indexPath.section == 2)
    {
        BuyCountCell *cell = [tableView dequeueReusableCellWithIdentifier:buyCountCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.count = self.homeModel.GoodsCount;
        return cell;
    }
    if(indexPath.section == 3)
    {
        TransportCell *cell = [tableView dequeueReusableCellWithIdentifier:transportCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    BuyRemarkCell *cell = [tableView dequeueReusableCellWithIdentifier:buyRemarkCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 || indexPath.section ==3 || indexPath.section ==4) {
        return;
    }
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if ([USERXX isBlankString:self.addressModel.addressee] == NO) {
            return 57 + _cell.addressLbl.frame.size.height;
        }else
        {
            return 50;
        }
    }
    if(indexPath.section == 1)
    {
       
            return kHeight(140);
    

    }
    if(indexPath.section == 2)
    {
        return kHeight(55);
    }
    if(indexPath.section == 3)
    {
        return kHeight(55);
    }
    return 50;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if(section == 0)
    {
        return 0.01;
    }
    return 10;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


@end
