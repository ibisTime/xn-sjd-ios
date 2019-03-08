//
//  ShopCartPayTableview.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/8.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLTableView.h"
#import "ShopcartPayModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ShopCartPayTableview : TLTableView
@property (nonatomic,strong) NSMutableArray<ShopcartPayModel *> * ShopcartPayModels;
@end

NS_ASSUME_NONNULL_END
