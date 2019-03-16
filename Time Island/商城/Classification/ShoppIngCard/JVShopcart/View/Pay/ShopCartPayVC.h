//
//  ShopCartPayVC.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/8.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallBaseVC.h"
#import "JVShopcartBrandModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ShopCartPayVC : MallBaseVC
@property (nonatomic,strong) NSString * code;
@property (nonatomic,strong) NSMutableArray<JVShopcartBrandModel *> * JVShopcartBrandModels;
@property (nonatomic,assign) CGFloat paycount;
@end

NS_ASSUME_NONNULL_END
