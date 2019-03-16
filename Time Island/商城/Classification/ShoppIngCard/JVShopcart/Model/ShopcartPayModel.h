//
//  ShopcartPayModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/8.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "commodityOrderDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ShopcartPayModel : NSObject
@property (nonatomic,copy) NSDictionary * shop;
@property (nonatomic,copy) NSMutableArray<commodityOrderDetailModel *> * commodityOrderDetails;
@end

NS_ASSUME_NONNULL_END
