//
//  OrderDetailsVC.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/18.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLBaseVC.h"
#import "OrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailsVC : TLBaseVC<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) OrderModel * OrderModel;
@end

NS_ASSUME_NONNULL_END
