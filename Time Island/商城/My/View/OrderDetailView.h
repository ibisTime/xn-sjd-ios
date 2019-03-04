//
//  OrderDetailView.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BaseView.h"
#import "AddressModel.h"

@interface OrderDetailView : BaseView

@property (nonatomic,strong) UILabel * TimeOrder;
@property (nonatomic,strong) UILabel * orderTime;//下单时间

@property (nonatomic,strong) UILabel * iDOrder;
@property (nonatomic,strong) UILabel * OrderID;//订单号

@property (nonatomic,strong) UILabel * moneyOrder;
@property (nonatomic,strong) UILabel * orderMoney;//订单金额

@property (nonatomic,strong) UILabel * sell;
@property (nonatomic,strong) UILabel * seller;//卖家

@property (nonatomic,strong) UILabel * typePay;
@property (nonatomic,strong) UILabel * payType;//支付方式

@property (nonatomic,strong) UILabel * iDPay;
@property (nonatomic,strong) UILabel * payID;//支付流水号
//
//@property (nonatomic , strong)AddressModel *model;
//
//@property (nonatomic , strong)UIImageView *addressImg;
//
//@property (nonatomic , strong)UILabel *backLabel;
//
@property (nonatomic , strong)UILabel *nameLbl;
//
//@property (nonatomic , strong)UILabel *addressLbl;
//
//@property (nonatomic , strong)UILabel *phoneLbl;
//
//@property (nonatomic , strong)UILabel *backContentLabel;
//
//@property (nonatomic , strong)UILabel *nameContentLbl;
//
//@property (nonatomic , strong)UILabel *addressContentLbl;
//
//@property (nonatomic , strong)UILabel *phoneContentLbl;
//
//
//@property (nonatomic , strong)UILabel *payCodeLbl;
//
//@property (nonatomic , strong)UILabel *payCodeContentLbl;

@property (nonatomic, copy) void (^clickBtnBlock)(NSInteger inter);

@end
