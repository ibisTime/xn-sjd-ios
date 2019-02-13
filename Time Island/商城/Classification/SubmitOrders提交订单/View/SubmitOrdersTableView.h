//
//  SubmitOrdersTableView.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/11.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AddressModel.h"
#import "BankCardModel.h"
#import "MallOrderModel.h"
#import "MallGoodsModel.h"
@interface SubmitOrdersTableView : TLTableView


@property(nonatomic , strong)AddressModel *addressModel;
@property (nonatomic,strong) MallGoodsModel * mallGoodsModel;

@property(nonatomic , copy)NSString *specificationsStr;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) NSString * size;
@property (nonatomic,assign) int selectnum;
@property (nonatomic,strong) NSString * remarkstring;
@property (nonatomic,strong) void (^returndata)(NSInteger count,int selectnum);
@property (nonatomic,strong) void (^remark)(NSString * remark);

@end
