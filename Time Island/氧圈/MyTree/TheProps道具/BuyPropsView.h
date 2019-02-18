//
//  BuyPropsView.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/18.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol BuyPropsdelegate <NSObject>

-(void)UsedBtn:(NSString *)code;

@end

@interface BuyPropsView : UIView
@property (nonatomic , strong)UIButton *ShutDownBtn;
@property (nonatomic,strong) NSMutableArray * array;
@property (nonatomic,weak) id<BuyPropsdelegate> delegate;
@end

NS_ASSUME_NONNULL_END
