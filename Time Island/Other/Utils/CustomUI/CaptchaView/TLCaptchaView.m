//
//  TLCaptchaView.m
//  WeRide
//
//  Created by  蔡卓越 on 2016/12/7.
//  Copyright © 2016年 trek. All rights reserved.
//

#import "TLCaptchaView.h"
#import "TLUIHeader.h"
#import "AppColorMacro.h"

@implementation TLCaptchaView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUIWith:frame];
        
    }
    return self;
}

- (void)setUpUIWith:(CGRect)frame
{
    
    
//    self.captchaTf = [[TLTextField alloc] initWithFrame:CGRectMake(0, 0,frame.size.width, frame.size.height)
//                                           leftTitle:[LangSwitcher switchLang:@"验证码" key:nil]
//                                          titleWidth:90
//                                         placeholder:[LangSwitcher switchLang:@"请输入验证码" key:nil]];
    self.captchaTf = [[TLTextField alloc]initWithFrame:CGRectMake(0, 0,frame.size.width, frame.size.height) placeholder:@"请输入验证码"];
    [self addSubview:self.captchaTf];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 95, frame.size.height)];

    //获得验证码按钮
    TLTimeButton *captchaBtn = [[TLTimeButton alloc] initWithFrame:CGRectMake(0, 14, 84, 26) totalTime:60.0];
    captchaBtn.centerY = rightView.height/2.0;
    self.captchaBtn = captchaBtn;
    captchaBtn.titleLabel.font = Font(11.0);
    self.captchaTf.keyboardType = UIKeyboardTypeNumberPad;
    captchaBtn.layer.cornerRadius = 4;
    captchaBtn.clipsToBounds = YES;
    captchaBtn.backgroundColor = kAppCustomMainColor;
//    [captchaBtn setTitleColor:[UIColor colorWithHexString:@"#23AD8C"] forState:UIControlStateNormal];
//    [captchaBtn.layer setBorderWidth:1.0];
//    [captchaBtn.layer setBorderColor:[UIColor colorWithHexString:@"#23AD8C"].CGColor];
    [rightView addSubview:captchaBtn];
    
    self.captchaTf.rightView = rightView;

    
    //2.1 添加分割线
//    UIView *sLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 20)];
//    sLine.centerY = captchaBtn.centerY;
//    sLine.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
//    [captchaBtn addSubview:sLine];
    
}

@end
