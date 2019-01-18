//
//  MallBaseVC.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/18.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MallBaseVC : UIViewController
@property (nonatomic,strong) UIView *tl_placeholderView;

@property (nonatomic , strong)UIButton *RightButton;

@property (nonatomic , strong)UIButton *backBtn;

@property (nonatomic , strong)NSString *backStr;

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
