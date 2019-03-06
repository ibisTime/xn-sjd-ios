//
//  OrderDetailView.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "OrderDetailView.h"
#import <Masonry.h>

@implementation OrderDetailView
{
    UIImageView *youImage;
}

-(UILabel *)nameLbl
{
    if(!_nameLbl)
    {
        _nameLbl = [UILabel labelWithFrame:CGRectMake(15, 25, kWidth(80) , 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:kTextColor];
        _nameLbl.text = @"订单信息";
    }
    return _nameLbl;
}

-(UILabel *)TimeOrder{
    if (!_TimeOrder) {
        _TimeOrder = [UILabel labelWithFrame:CGRectMake(15, _nameLbl.yy + 21, kWidth(80), 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kBlackColor];
        _TimeOrder.text = @"下单时间";
    }
    return _TimeOrder;
}
-(UILabel *)orderTime{
    if (!_orderTime) {
        _orderTime = [UILabel labelWithFrame:CGRectMake(kWidth(80), _nameLbl.yy + 21,kScreenWidth - 30 - kWidth(80), 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kBlackColor];
    }
    return _orderTime;
}
-(UILabel *)iDOrder{
    if (!_iDOrder) {
        _iDOrder = [UILabel labelWithFrame:CGRectMake(15, _orderTime.yy + 15, kWidth(80), 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kBlackColor];
        _iDOrder.text = @"订单号";
    }
    return _iDOrder;
}
-(UILabel *)OrderID{
    if (!_OrderID) {
        _OrderID = [UILabel labelWithFrame:CGRectMake(kWidth(80), _orderTime.yy + 15,kScreenWidth - 30 - kWidth(80), 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kBlackColor];
    }
    return _OrderID;
}

-(UILabel *)moneyOrder{
    if (!_moneyOrder) {
        _moneyOrder = [UILabel labelWithFrame:CGRectMake(15, _OrderID.yy + 15, kWidth(80), 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kBlackColor];
        _moneyOrder.text = @"订单金额";
    }
    return _moneyOrder;
}
-(UILabel *)orderMoney{
    if (!_orderMoney) {
        _orderMoney = [UILabel labelWithFrame:CGRectMake(kWidth(80), _OrderID.yy + 15,kScreenWidth - 30 - kWidth(80), 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kBlackColor];
    }
    return _orderMoney;
}
-(UILabel *)sell{
    if (!_sell) {
        _sell = [UILabel labelWithFrame:CGRectMake(15, _orderMoney.yy + 15, kWidth(80), 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kBlackColor];
        _sell.text = @"卖家";
    }
    return _sell;
}
-(UILabel *)seller{
    if (!_seller) {
        _seller = [UILabel labelWithFrame:CGRectMake(kWidth(80),  _orderMoney.yy + 15, kScreenWidth - 30 - kWidth(80), 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kBlackColor];
    }
    return _seller;
}
-(UILabel *)typePay{
    if (!_typePay) {
        _typePay = [UILabel labelWithFrame:CGRectMake(15, _seller.yy + 15, kWidth(80), 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kBlackColor];
        _typePay.text = @"支付方式";
    }
    return _typePay;
}
-(UILabel *)payType{
    if (!_payType) {
        _payType = [UILabel labelWithFrame:CGRectMake(kWidth(80), _seller.yy + 15, kScreenWidth - 30 - kWidth(80), 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kBlackColor];
    }
    return _payType;
}
-(UILabel *)iDPay{
    if (!_iDPay) {
        _iDPay = [UILabel labelWithFrame:CGRectMake(15, _payType.yy + 15, kWidth(80), 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kBlackColor];
        _iDPay.text = @"支付流水号";
    }
    return _iDPay;
}
-(UILabel *)payID{
    if (!_payID) {
        _payID = [UILabel labelWithFrame:CGRectMake(kWidth(80),  _payType.yy + 15, kScreenWidth - 30 - kWidth(80), 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kBlackColor];
    }
    return _payID;
}

-(instancetype)initWithFrame:(CGRect)frame{
    {
        if (self == [super initWithFrame:frame]) {
            self.backgroundColor = kWhiteColor;
            [self addSubview:self.nameLbl];
            
            
            [self addSubview:self.TimeOrder];
            [self addSubview:self.orderTime];
            
            [self addSubview:self.OrderID];
            [self addSubview:self.iDOrder];
            
            [self addSubview:self.orderMoney];
            [self addSubview:self.moneyOrder];
            
            [self addSubview:self.sell];
            [self addSubview:self.seller];
            
            [self addSubview:self.typePay];
            [self addSubview:self.payType];
            
            [self addSubview:self.iDPay];
            [self addSubview:self.payID];
            
            
            
            
            
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
            line.backgroundColor = kLineColor;
            [self addSubview:line];
            UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.payID.yy+20, kScreenWidth, 0.5)];
            line1.backgroundColor = kLineColor;
            [self addSubview:line1];
//            NSArray *titleArray = @[@"查看物流",@"申请售后",@"确认收货"];
//            for (int i = 0; i < 3; i++) {
//                UIButton *btn = [UIButton buttonWithTitle:titleArray[i] titleColor:kTextColor2 backgroundColor:kClearColor titleFont:12 cornerRadius:2];
//
//                CGFloat btnW = (kScreenWidth-105-45)/3;
//                btn.frame = CGRectMake(btnW*(i+1)+i*15, line1.yy+10, btnW, 28);
//                [self addSubview:btn];
//                btn.layer.borderWidth = 1;
//                btn.layer.borderColor = kLineColor.CGColor;
//                if (i == 2) {
//                    btn.layer.borderWidth = 1;
//                    btn.layer.borderColor = kSJDMainTextColor.CGColor;
//                      [btn setTitleColor:kSJDMainTextColor forState:UIControlStateNormal];
//                }
//                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//                btn.tag = i+1000;
//
//            }
    
        }
        return self;
    }
}

- (void)btnClick:(UIButton*)btn
{
    btn.selected = !btn.selected;
    if (self.clickBtnBlock) {
        self.clickBtnBlock(btn.tag-1000);
    }
//    NSInteger inter = btn.tag - 1000;
//    for (UIButton *bt in self.subviews) {
//        bt.layer.borderWidth = 1;
//        bt.layer.borderColor = kLineColor.CGColor;
//
//    }
//    btn.layer.borderWidth = 1;
//    btn.layer.borderColor = kSJDMainTextColor.CGColor;
}
@end
