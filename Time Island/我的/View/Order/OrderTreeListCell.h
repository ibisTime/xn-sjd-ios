//
//  OrderTreeListCell.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/27.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderTreeListCell : UITableViewCell
@property (nonatomic,strong) OrderModel * OrderModel;
@property (nonatomic,strong) NSDictionary * treeList;
@end

NS_ASSUME_NONNULL_END
