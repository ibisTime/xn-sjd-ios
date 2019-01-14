//
//  TeamView.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/11.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TeamView.h"
//Macro
#import "TLUIHeader.h"
#import "AppColorMacro.h"
#import "UIColor+theme.h"
//Category
#import "UIButton+EnLargeEdge.h"
#import "NSString+Extension.h"
#import "CoinUtil.h"
//V
#import <SDWebImage/UIImageView+WebCache.h>
@interface TeamView()
@property (nonatomic, strong) UIButton *statusButton;//推文
@property (nonatomic, strong) UILabel *infoTitle;
@property (nonatomic, strong) UILabel *priceLable;//价格
@property (nonatomic, strong) UILabel *addressLab;//地址
@property (nonatomic, strong) UILabel *totalLab;//地址

@property (nonatomic, strong) UIView *BottomLine;
@property (nonatomic, strong) UIView *progressLine;


@end
@implementation TeamView

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
 
    
    self.BottomLine = [UIView new];
    self.BottomLine.backgroundColor = kLineColor;
    [self addSubview:self.BottomLine];
    self.BottomLine.frame = CGRectMake(10, 10, kScreenWidth-100, 4);
    
    self.progressLine = [UIView new];
    self.progressLine.backgroundColor = [UIColor redColor];
    [self addSubview:self.progressLine];
    self.progressLine.frame = CGRectMake(10, 10, 100, 4);
//    self.statusButton = [UIButton buttonWithTitle:@"集体" titleColor:kWhiteColor backgroundColor:[UIColor redColor] titleFont:14];
//    self.statusButton.frame = CGRectMake(15, 15, 32, 13);
//    self.statusButton.layer.cornerRadius = 5;
//    self.statusButton.clipsToBounds = YES;
//    [self addSubview:self.statusButton];
    
    self.infoTitle = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(0, 0, 0) font:14.0];
    [self.infoTitle setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:self.infoTitle];
    self.infoTitle.frame = CGRectMake(kScreenWidth/5, self.BottomLine.yy+10, kScreenWidth/5, 30);
    self.infoTitle.text = @"目标份数/份";
    self.priceLable = [UILabel labelWithBackgroundColor:kClearColor textColor:kBlackColor font:14.0];
    [self addSubview:self.priceLable];
    self.priceLable.frame = CGRectMake(kScreenWidth/5*3, self.BottomLine.yy+10, kScreenWidth/4, 30);
    
    self.priceLable.text = @"已募集份数/份";
    self.priceLable.textColor = [UIColor blackColor];
    
    self.addressLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kBlackColor font:13.0];
    [self addSubview:self.addressLab];
//    self.addressLab.frame = CGRectMake(self.infoTitle.xx, self.infoTitle.yy+5, 120, 30);
    self.addressLab.font = [UIFont systemFontOfSize:13];
    self.addressLab.text = @"1000";
    self.addressLab.centerX = self.infoTitle.centerX;
    
    self.totalLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kBlackColor font:13.0];
    [self addSubview:self.totalLab];
//    self.totalLab.frame = CGRectMake(self.priceLable.xx, self.priceLable.yy+5, 120, 30);
    self.totalLab.font = [UIFont systemFontOfSize:13];
    self.totalLab.text = @"10000";
    self.totalLab.centerX = self.priceLable.centerX;
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoTitle.mas_bottom).offset(5);
        make.centerX.equalTo(self.infoTitle);
    }];
    [self.totalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLable.mas_bottom).offset(5);
        make.centerX.equalTo(self.priceLable);
    }];
}

@end
