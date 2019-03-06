//
//  MallCancelOrderCell.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/5.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MallCancelOrderModel.h"
NS_ASSUME_NONNULL_BEGIN
@class MallCancelOrderCell;
@protocol MallOrderCellDelegrate <NSObject>

- (void)MallOrderCell:(MallCancelOrderCell *)tableViewCell clickDeleteButton:(UIButton *)sender;

@end
@interface MallCancelOrderCell : UITableViewCell

@property (nonatomic,strong) UIButton * ShopNameBtn;
@property (nonatomic,strong) UIImageView * GoodsImage;
@property (nonatomic,strong) UILabel * ShopName;
@property (nonatomic,strong) UILabel * GoodsName;
@property (nonatomic,strong) UILabel * GoodsDescribe;
@property (nonatomic,strong) UILabel * GoodsTotal;
@property (nonatomic,strong) UILabel * GoodsCount;
@property (nonatomic,strong) UILabel * GoodsMoney;
@property (nonatomic,strong) UILabel * OrderTime;
@property (nonatomic,strong) UILabel * TotalMoney;
@property (nonatomic,assign) int OrderState;
@property (nonatomic,strong) UILabel * StateLab;
@property (nonatomic,strong) MallCancelOrderModel * model;
//@property (nonatomic,assign) int uuu;
@property (nonatomic,strong) UIView * details;

@property(nonatomic,weak)id<MallOrderCellDelegrate>delagate;
@end

NS_ASSUME_NONNULL_END
