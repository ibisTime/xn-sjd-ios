//
//  ShopCartSubmitOrderTableView.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/8.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLTableView.h"
#import "JVShopcartBrandModel.h"
#import "AddressModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ShopCartSubmitOrderTableView : TLTableView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic , strong)AddressModel *addressModel;
@property (nonatomic,strong) NSMutableArray<JVShopcartBrandModel *> * JVShopcartBrandModels;
@property (nonatomic,strong) void (^remark)(NSString * remark);
@property (nonatomic,strong) NSString * postalFee;
@property (nonatomic,strong) NSString * remarkstring;
@property (nonatomic,strong) void (^postfree)(NSString * money);
@end

NS_ASSUME_NONNULL_END
