//
//  MallTreeModel.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/28.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MallTreeModel : NSObject
@property (nonatomic , copy)NSString *location;
@property (nonatomic , copy)NSString *weight;
@property (nonatomic , copy)NSString *originalPrice;
@property (nonatomic , copy)NSString *originPlace;
@property (nonatomic , copy)NSString *deliverPlace;
@property (nonatomic , copy)NSString *shopCode;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *maxPrice;
@property (nonatomic , copy)NSString *updateDatetime;
@property (nonatomic , copy)NSString *shopName;
@property (nonatomic , copy)NSString *sellUserId;
@property (nonatomic , copy)NSString *name;
@property (nonatomic , copy)NSString *logistics;
@property (nonatomic , copy)NSString *totalInventory;
@property (nonatomic , copy)NSString *updater;
@property (nonatomic , copy)NSString *parentCategoryCode;
@property (nonatomic , copy)NSString *monthSellCount;
@property (nonatomic , copy)NSString *orderNo;
@property (nonatomic , copy)NSString *minPrice;
@property (nonatomic , copy)NSString *categoryCode;
@property (nonatomic , copy)NSString *originalPlace;
@property (nonatomic , copy)NSString *maxJfdkRate;
@property (nonatomic , copy)NSString *code;
@property (nonatomic,copy) NSString * sellType;
@property (nonatomic,copy) NSString * listPic;
@property (nonatomic,copy) NSString * bannerPic;
@property (nonatomic,copy) NSString *Description;
@property (nonatomic,strong) NSMutableArray *specsList;

@end
