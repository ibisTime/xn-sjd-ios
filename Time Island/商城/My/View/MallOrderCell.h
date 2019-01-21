//
//  MallOrderCell.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/21.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MallOrderCell : UITableViewCell
@property (nonatomic,strong) UIButton * ShopNameBtn;
@property (nonatomic,strong) UIImageView * GoodsImage;
@property (nonatomic,strong) UILabel * ShopName;
@property (nonatomic,strong) UILabel * GoodsName;
@property (nonatomic,strong) UILabel * GoodsDescribe;
@property (nonatomic,strong) UILabel * GoodsTotal;
@property (nonatomic,strong) UILabel * GoodsCount;
@property (nonatomic,strong) UILabel * GoodsMoney;
@property (nonatomic,strong) UILabel * OrderTime;
@property (nonatomic,strong) UILabel * OrderState;
@end

NS_ASSUME_NONNULL_END
