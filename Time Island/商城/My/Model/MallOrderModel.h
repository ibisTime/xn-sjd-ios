//
//  MallOrderModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/21.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MallOrderModel : NSObject
@property (nonatomic,strong) UIImageView * GoodsImage;
@property (nonatomic,strong) NSString * ShopName;
@property (nonatomic,strong) NSString * GoodsName;
@property (nonatomic,strong) NSString * GoodsDescribe;
@property (nonatomic,strong) NSString * GoodsTotal;
@property (nonatomic,strong) NSString * GoodsCount;
@property (nonatomic,strong) NSString * GoodsMoney;
@property (nonatomic,strong) NSString * OrderTime;
@property (nonatomic,assign) int OrderState;//1为待付款。2为待收货。3为待发货。4待评价
@end

NS_ASSUME_NONNULL_END
