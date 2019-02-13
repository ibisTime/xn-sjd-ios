//
//  SubmitOrdersVC.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLBaseVC.h"
#import "MallOrderModel.h"
#import "MallGoodsModel.h"
#import "AddressModel.h"
@interface SubmitOrdersVC : TLBaseVC

//@property (nonatomic , strong) MallOrderModel *model;

@property (nonatomic , strong)NSArray *selectArray;

@property (nonatomic,strong) MallGoodsModel * MallGoodsModel;

@property (nonatomic,assign) NSInteger count;

@property (nonatomic,strong) NSString * size;

@property (nonatomic,assign) int selectnum;

@property (nonatomic,strong) NSString * remark;

@property(nonatomic , strong)AddressModel *addressModel;

@property (nonatomic,strong) NSString * code;


@end
