//
//  ReceivingAddressVC.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/18.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallBaseVC.h"
#import "AddressModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^AddBlock)(NSString *Name, NSString *Phone, NSString *shengName, NSString *shiName, NSString *xianName,NSString *Details);

@interface ReceivingAddressVC : MallBaseVC<UITableViewDelegate,UITableViewDataSource,RefreshDelegate>
@property int state;
@property (nonatomic, copy) void (^selectCellBlock)(AddressModel* model);
@property (nonatomic,strong) AddressModel * AddressModel;
@property (nonatomic,strong) NSMutableArray * AddressArray;

@property (nonatomic,copy) AddBlock AddressBlock;
@property (nonatomic,strong) NSString * mallstate;
@end

NS_ASSUME_NONNULL_END
