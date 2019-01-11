//
//  RealNameView.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/11.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "RealNameView.h"
//Macro
#import "TLUIHeader.h"
#import "AppColorMacro.h"
#import "UIColor+theme.h"
//Category
#import "UIButton+EnLargeEdge.h"
#import "NSString+Extension.h"
#import "CoinUtil.h"
#import "TLTextField.h"
//V
#import <SDWebImage/UIImageView+WebCache.h>

@interface RealNameView()
@property (nonatomic, strong) UIView *content;
@property (nonatomic, strong) UIImageView *treeImage;

@property (nonatomic, strong) UIButton *statusButton;//推文
@property (nonatomic, strong) UILabel *TitleLab;
@property (nonatomic, strong) UILabel *infoLable;//价格
@property (nonatomic, strong) UILabel *checkLab;
@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *goButton;
@end
@implementation RealNameView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self initcustomView];
    }
    return self;
}
- (void)initcustomView
{
    self.TitleLab = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kBlackColor font:16];
    [self addSubview:self.TitleLab];
    self.TitleLab.frame = CGRectMake(0, 27, self.frame.size.width, 44);
    self.TitleLab.textAlignment = NSTextAlignmentCenter;
    self.TitleLab.font = [UIFont boldSystemFontOfSize:16];
    self.TitleLab.text = @"完成操作,需进行实名认证";
    self.infoLable = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kBlackColor font:14];
    [self addSubview:self.infoLable];
    self.infoLable.frame = CGRectMake(20, self.TitleLab.yy+24, self.frame.size.width-40, 80);
    self.infoLable.numberOfLines = 0;
    self.infoLable.font = [UIFont systemFontOfSize:14];
    self.infoLable.textAlignment = NSTextAlignmentLeft;

    self.infoLable.text = @"由于认养古树需要签署政府相关认养协议,认养后还有挂牌等服务来展示您的爱心,所以需要您完成实名认证(个人中心头像右侧)";

    self.checkLab = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kBlackColor font:14];
    [self addSubview:self.checkLab];
    self.checkLab.frame = CGRectMake(20, self.infoLable.yy+20, self.frame.size.width-40, 44);
    self.checkLab.textAlignment = NSTextAlignmentLeft;

    self.checkLab.numberOfLines = 0;
    self.checkLab.font = [UIFont systemFontOfSize:14];
    self.checkLab.text = @"请前往选择任意一种认证方式。 (平台只会公开您的昵称)";
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = kLineColor;
    [self addSubview:lineView];
    lineView.frame = CGRectMake(20, self.checkLab.yy+10, kScreenWidth-40, 1);
    
    self.cancleButton = [UIButton buttonWithTitle:@"稍后再去" titleColor:kAppCustomMainColor backgroundColor:kWhiteColor titleFont:13];
//    self.cancleButton.layer.cornerRadius = 15;
//    self.cancleButton.clipsToBounds = YES;
    self.cancleButton.layer.borderWidth = 1;
    self.cancleButton.layer.borderColor = kLineColor.CGColor;
//
    self.cancleButton.frame = CGRectMake(0, self.frame.size.height-45, self.frame.size.width/2, 45);
    [self addSubview:self.cancleButton];
    
    self.goButton =  [UIButton buttonWithTitle:@"前往认证" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:14];
//    self.goButton.layer.borderWidth = 1;
//    self.goButton.layer.borderColor = kAppCustomMainColor.CGColor;
    self.goButton.frame = CGRectMake(self.frame.size.width/2, self.frame.size.height-45, self.frame.size.width/2, 45);
    [self addSubview:self.goButton];
    [self.goButton addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    [self.cancleButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
}

- (void)go
{
    [self removeFromSuperview];

    
}


- (void)cancel
{
    [self removeFromSuperview];
}
@end
