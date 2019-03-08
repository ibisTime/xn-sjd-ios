//
//  ShopCartSubmitOrderVC.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/8.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallBaseVC.h"
#import "JVShopcartBrandModel.h"
#import "AddressModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ShopCartSubmitOrderVC : MallBaseVC
@property (nonatomic,strong) NSMutableArray<JVShopcartBrandModel *> * JVShopcartBrandModels;
@property(nonatomic , strong)AddressModel *addressModel;
@property (nonatomic,assign) CGFloat  totalprice;
@property (nonatomic,strong) NSString * postalFee;
@property (nonatomic,strong) NSString * remark;
@property (nonatomic,assign) CGFloat paycount;

@end

NS_ASSUME_NONNULL_END
