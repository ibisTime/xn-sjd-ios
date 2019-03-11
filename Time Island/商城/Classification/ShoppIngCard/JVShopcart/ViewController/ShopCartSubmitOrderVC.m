//
//  ShopCartSubmitOrderVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/8.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "ShopCartSubmitOrderVC.h"
#import "SubmitOrdersTableView.h"
#import "ReceivingAddressVC.h"
#import "GoodsDetailsBottomView.h"
#import "ShopCartSubmitOrderTableView.h"
#import "GoodsDetailsBottomView.h"
#import "ShopCartPayVC.h"
@interface ShopCartSubmitOrderVC ()<RefreshDelegate>
@property (nonatomic,strong) ShopCartSubmitOrderTableView * tableview;
@property (nonatomic , strong)GoodsDetailsBottomView *BottomView;
@property (nonatomic,strong) NSString * moneystr;
@property (nonatomic,strong) NSMutableArray * commodityCodeList;
@property (nonatomic,strong) NSMutableArray * cartList;
@end

@implementation ShopCartSubmitOrderVC

-(ShopCartSubmitOrderTableView *)tableview{
    if (!_tableview) {
        _tableview = [[ShopCartSubmitOrderTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 60)];
        _tableview.refreshDelegate = self;
        _tableview.backgroundColor = kWhiteColor;
    }
    return _tableview;
}
-(GoodsDetailsBottomView *)BottomView
{
    if (!_BottomView) {
        _BottomView = [[GoodsDetailsBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kNavigationBarHeight - 50, SCREEN_WIDTH, 50)];
        [_BottomView.shoppingButton addTarget:self action:@selector(chooseViewClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_BottomView.shoppingButton setTitle:@"确认购买" forState:(UIControlStateNormal)];
        
        
        NSString * str = [NSString stringWithFormat:@"合计 ：%.2f",self.totalprice / 1000];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:kTextColor
                        range:NSMakeRange(0, 4)];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:kHexColor(@"#F68646")
                        range:NSMakeRange(4, str.length - 4)];
        _BottomView.MonthlyPaymentsLabel.attributedText = attrStr;
        
    }
    return _BottomView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提交订单";
    CoinWeakSelf;
    self.tableview.JVShopcartBrandModels = self.JVShopcartBrandModels;
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.BottomView];
    
    self.commodityCodeList = [NSMutableArray array];
    self.cartList = [NSMutableArray array];
    for (int i = 0; i < self.JVShopcartBrandModels.count; i++) {
        for (int j = 0; j < self.JVShopcartBrandModels[i].selectedArray.count; j ++) {
            [self.commodityCodeList addObject:self.JVShopcartBrandModels[i].selectedArray[j][@"commodityCode"]];
            [self.cartList addObject:self.JVShopcartBrandModels[i].selectedArray[j][@"code"]];
        }
    }
    self.tableview.remark = ^(NSString * _Nonnull remark) {
        weakSelf.remark = remark;
    };
   
}
- (void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CoinWeakSelf;
    if (indexPath.section == 0) {
        ReceivingAddressVC *address = [ReceivingAddressVC new];
        address.selectCellBlock = ^(AddressModel * _Nonnull model) {
            weakSelf.addressModel = model;
            weakSelf.tableview.addressModel = model;
            NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:0];
            [weakSelf.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
            [self.navigationController popViewControllerAnimated:YES];
            [self getdata];
//            [weakSelf.tableview reloadData];
        };
        [self.navigationController pushViewController:address animated:YES];
        
    }
    
}
-(void)getdata{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629801";
    if (self.addressModel.code) {
        http.parameters[@"addressCode"] = self.addressModel.code;
        http.parameters[@"commodityCodeList"] = self.commodityCodeList;
        [http postWithSuccess:^(id responseObject) {
            self.postalFee = responseObject[@"data"][@"postalFee"];
            self.tableview.postalFee = self.postalFee;
            
            self.paycount = (self.totalprice + [self.postalFee floatValue]) / 1000;
            NSString * str = [NSString stringWithFormat:@"合计 ：%.2f",(self.totalprice + [self.postalFee floatValue]) / 1000];
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
            [attrStr addAttribute:NSForegroundColorAttributeName
                            value:kTextColor
                            range:NSMakeRange(0, 4)];
            [attrStr addAttribute:NSForegroundColorAttributeName
                            value:kHexColor(@"#F68646")
                            range:NSMakeRange(4, str.length - 4)];
            self.BottomView.MonthlyPaymentsLabel.attributedText = attrStr;
            
            [self.tableview reloadData];
        } failure:^(NSError *error) {
            
        }];
    }
    
}

- (void)chooseViewClick
{
    NSLog(@"去付款");
    if (self.addressModel.code) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"629713";
        http.parameters[@"applyUser"] = [TLUser user].userId;
        http.parameters[@"applyNote"] = self.remark;
        http.parameters[@"expressType"] = @(1);
        http.parameters[@"cartList"] = self.cartList;
        http.parameters[@"addressCode"] = self.addressModel.code;
        [http postWithSuccess:^(id responseObject) {
            ShopCartPayVC * vc = [[ShopCartPayVC alloc]init];
            vc.code = responseObject[@"data"][@"code"];
            vc.JVShopcartBrandModels = self.JVShopcartBrandModels;
            vc.paycount = self.paycount;
            [self.navigationController pushViewController:vc animated:YES];
        } failure:^(NSError *error) {
            
        }];
    }
    else{
        [TLAlert alertWithInfo:@"请选择收货地址"];
    }
    
}
@end
