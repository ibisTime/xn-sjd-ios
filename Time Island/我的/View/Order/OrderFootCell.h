//
//  OrderFootCell.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderFootCell : UITableViewCell
//@property (nonatomic,strong) UILabel * OrderIdlab;
//@property (nonatomic,strong) UILabel * OrderStatelab;
//
//@property (nonatomic,strong) UIImageView * TreeImage;
//@property (nonatomic,strong) UILabel * TreeName;
//@property (nonatomic,strong) UILabel * treeAddress;
//@property (nonatomic,strong) UILabel * TreeAge;
//@property (nonatomic,strong) UILabel * TreeMoney;
@property (nonatomic,strong) OrderModel * OrderModel;
//子订单数量
//@property (nonatomic,assign) NSInteger  OrderCount;
//@property (nonatomic,assign) NSInteger  count;
@end

NS_ASSUME_NONNULL_END
