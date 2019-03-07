//
//  orderDetailCell.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MallOrderModel.h"
typedef void(^ShopcartCellBlock)(BOOL isSelected);
typedef void(^ShopcartCellEditBlock)(NSInteger count);
@protocol ClickButtonDelegrate <NSObject>

-(void)clickBtn:(UIButton *)sender;

@end
@interface orderDetailCell : UITableViewCell

@property (nonatomic, copy) ShopcartCellBlock shopcartCellBlock;
@property (nonatomic, copy) ShopcartCellEditBlock shopcartCellEditBlock;
@property (nonatomic,assign) NSInteger shownum;

@property (nonatomic,strong) MallOrderModel * model;
@property (nonatomic,strong) UIButton * btn1;
@property (nonatomic,strong) UIButton * btn2;

- (void)configureShopcartCellWithProductURL:(NSString *)productURL
                                productName:(NSString *)productName
                                productSize:(NSString *)productSize
                               productPrice:(NSString *)productPrice
                               productCount:(NSString *)productCount
                            productSelected:(BOOL)productSelected;
@property (nonatomic,weak) id<ClickButtonDelegrate> delegate;
@end
