//
//  ShopCartSubmitOrderTableView.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/8.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "ShopCartSubmitOrderTableView.h"
#import "SubmitOrderAddressCell.h"
#import "TransportCell.h"
#import "BuyRemarkCell.h"
#import "ShopCartSubmitOrderGoodsCell.h"
#define SubmitOrderAddress @"SubmitOrderAddressCell"
#define transportCell @"TransportCell"
#define buyRemarkCell @"BuyRemarkCell"
#define SubmitOrderGoods @"ShopCartSubmitOrderGoodsCell"
#import "JVShopcartProductModel.h"
@interface ShopCartSubmitOrderTableView(){
    SubmitOrderAddressCell *_cell;
}
@property (nonatomic,strong) NSMutableArray<JVShopcartProductModel *> * ProductModels;
@property (nonatomic,strong) NSMutableArray * commodityCodeList;
@end
@implementation ShopCartSubmitOrderTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[SubmitOrderAddressCell class] forCellReuseIdentifier:SubmitOrderAddress];
        [self registerClass:[TransportCell class] forCellReuseIdentifier:transportCell];
        [self registerClass:[BuyRemarkCell class] forCellReuseIdentifier:buyRemarkCell];
        [self registerClass:[ShopCartSubmitOrderGoodsCell class] forCellReuseIdentifier:SubmitOrderGoods];
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int goodscount = 0;
    for (int i = 0; i < self.JVShopcartBrandModels.count; i++) {
        goodscount += self.JVShopcartBrandModels[i].cartList.count;
    }
    if (section == 1) {
        return goodscount;
    }
    else
        return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
        if(indexPath.section == 0)
        {
            _cell = [tableView dequeueReusableCellWithIdentifier:SubmitOrderAddress forIndexPath:indexPath];
            _cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if ([USERXX isBlankString:self.addressModel.addressee] == NO) {
                _cell.model = self.addressModel;
                _cell.backLabel.hidden = YES;
                
            }
            else
            {
                _cell.backLabel.hidden = NO;
            }
            return _cell;
        }
        if(indexPath.section == 1)
        {
            self.ProductModels = [NSMutableArray array];
            self.commodityCodeList = [NSMutableArray array];
            ShopCartSubmitOrderGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:SubmitOrderGoods forIndexPath:indexPath];
//            cell.ProductModel = self.
            for (int i = 0; i < self.JVShopcartBrandModels.count; i++) {
                for (int j = 0; j < self.JVShopcartBrandModels[i].cartList.count; j ++) {
//                    cell.ProductModel = self.JVShopcartBrandModels[i].cartList[j];
                    [self.ProductModels addObject:self.JVShopcartBrandModels[i].cartList[j]];
                    [self.commodityCodeList addObject:self.JVShopcartBrandModels[i].cartList[j].commodityCode];
                }
            }
            cell.ProductModel = self.ProductModels[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if(indexPath.section == 2){
            
            TransportCell *cell = [tableView dequeueReusableCellWithIdentifier:transportCell forIndexPath:indexPath];
            cell.postalFee = self.postalFee;
            if ([self.postalFee integerValue] == 0) {
                cell.countLbl.text = @"快递免邮";
            }
            else{
                cell.countLbl.text = [NSString stringWithFormat:@"快递费:%.2f",[self.postalFee floatValue]/1000];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        BuyRemarkCell *cell = [tableView dequeueReusableCellWithIdentifier:buyRemarkCell forIndexPath:indexPath];
        cell.remark = ^(NSString *remark) {
            self.remarkstring = remark;
            if (self.remark) {
                self.remark(remark);
            };
        };
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 || indexPath.section ==2 || indexPath.section ==3) {
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
            return 70;
        }else
        {
            return 50;
        }
    }
    if(indexPath.section == 1)
    {
        
        return 105;
        
    }
    if(indexPath.section == 2)
    {
        return 62;
    }
    if(indexPath.section == 3)
    {
        return 62;
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
-(void)getdata{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629801";
    if (self.addressModel.code) {
        http.parameters[@"addressCode"] = self.addressModel.code;
        http.parameters[@"commodityCodeList"] = self.commodityCodeList;
        [http postWithSuccess:^(id responseObject) {
            self.postalFee = responseObject[@"data"][@"postalFee"];
            NSLog(@"%@",self.postalFee);
            if (self.postfree) {
                self.postfree(self.postalFee);
            }
            [self reloadData];
        } failure:^(NSError *error) {
            
        }];
    }
    
}

@end
