//
//  UserModel.h
//  Coin
//
//  Created by 郑勤宝 on 2018/11/6.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJAnimationPopView.h"
@interface UserModel : NSObject

@property (nonatomic , strong)ZJAnimationPopView *cusPopView;

+ (instancetype)user;
//
+(NSMutableAttributedString *)ReturnsTheDistanceBetween:(NSString *)str;

-(void)showPopAnimationWithAnimationStyle:(NSInteger)style showView:(UIView *)showView BGAlpha:(CGFloat)alpha isClickBGDismiss:(BOOL)dismiss;

- (void)showDataPopAnimationWithAnimationStyle:(NSInteger)style showView:(UIView *)showView BGAlpha:(CGFloat )alpha isClickBGDismiss:(BOOL)dismiss popAnimationDuration:(CGFloat)popAnimationDuration dismissAnimationDuration:(CGFloat)dismissAnimationDuration;

-(void)phoneCode:(UIButton *)sender;


@end
