//
//  BalanceTableView.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/11.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLTableView.h"
#import "CarbonModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BalanceTableView : TLTableView
@property (nonatomic,strong) NSMutableArray<CarbonModel *> * CarbonModels;
@end

NS_ASSUME_NONNULL_END
