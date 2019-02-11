//
//  BalanceView.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/11.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarbonModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol BalanceViewDelegate <NSObject>

-(void)BtnClick:(NSInteger)tag;

@end

@interface BalanceView : UIView
@property (nonatomic,strong) CarbonModel * CarbonModel;
@property (nonatomic,strong) UILabel *amountLbl;
@property (nonatomic,strong) NSArray * array;
@property (nonatomic,strong) UILabel *currentLbl;
@property (nonatomic,assign) int state;
@property (nonatomic,copy) void (^ClickBtn)(NSInteger t);
@property (nonatomic,weak) id<BalanceViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
