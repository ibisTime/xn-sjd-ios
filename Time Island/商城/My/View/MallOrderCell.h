//
//  MallOrderCell.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/21.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MallOrderCell;
@protocol MallOrderCellDelegrate <NSObject>

- (void)MallOrderCell:(MallOrderCell *)tableViewCell clickDeleteButton:(UIButton *)sender;

@end

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
@property (nonatomic,assign) int OrderState;
@property (nonatomic,strong) UILabel * StateLab;

//@property (nonatomic,assign) int uuu;


@property(nonatomic,weak)id<MallOrderCellDelegrate>delagate;
@end

NS_ASSUME_NONNULL_END
