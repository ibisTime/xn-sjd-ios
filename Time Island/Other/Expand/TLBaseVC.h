//
//  TLBaseVC.h
//  WeRide
//
//  Created by  tianlei on 2016/11/25.
//  Copyright © 2016年 trek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoinHeader.h"

@interface TLBaseVC : UIViewController

@property (nonatomic,strong) UIView *tl_placeholderView;


- (void)tl_placeholderOperation;


- (void)removePlaceholderView; //移除
- (void)addPlaceholderView; // 添加
//更新placeholderView
- (void)setPlaceholderViewTitle:(NSString *)title  operationTitle:(NSString *)optitle;


//导航栏设为透明
-(void)navigationTransparentClearColor;
//导航栏设为默认
-(void)navigationSetDefault;
//导航栏设为白色
-(void)navigationwhiteColor;
@end
