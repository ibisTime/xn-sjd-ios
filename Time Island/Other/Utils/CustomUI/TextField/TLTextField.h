//
//  TLTextField.h
//  WeRide
//
//  Created by  蔡卓越 on 2016/12/7.
//  Copyright © 2016年 trek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLTextField : UITextField<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *leftLbl;
@property (nonatomic,strong) UIView * view;

- (instancetype)initWithFrame:(CGRect)frame
                    leftTitle:(NSString *)leftTitle
                   titleWidth:(CGFloat)titleWidth
                  placeholder:(NSString *)placeholder;

//增加
-(instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder;

- (instancetype)initWithFrame:(CGRect)frame
                    leftTitle:(NSString *)leftTitle
                  placeholder:(NSString *)placeholder;

-(instancetype)initWithFrameChangeLeftLbl:(CGRect)frame
                                leftTitle:(NSString *)leftTitle
                              placeholder:(NSString *)placeholder;
//禁止复制粘贴等功能
@property (nonatomic,assign) BOOL isSecurity;


@end
