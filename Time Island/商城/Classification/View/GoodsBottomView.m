//
//  GoodsBottomView.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "GoodsBottomView.h"
@interface GoodsBottomView()
@property (nonatomic ,strong) UIButton *store;

@property (nonatomic ,strong) UIButton *service;

@property (nonatomic ,strong) UIButton *shop;

@property (nonatomic ,strong) UIButton *buy;


@end
@implementation GoodsBottomView

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
    self.store = [UIButton buttonWithTitle:@"店铺" titleColor:kHexColor(@"#F68646") backgroundColor:kClearColor titleFont:10];
    [self.store setImage:kImage(@"店铺") forState:UIControlStateNormal];
    self.store.frame = CGRectMake(20, 7.4, 48, self.height);
    [self addSubview:self.store];
    [self.store addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.store.tag = 101;
    [self.store setImageEdgeInsets:UIEdgeInsetsMake(-30, 0, 0, 0)];
    [self.store setTitleEdgeInsets:UIEdgeInsetsMake(0, -37, 0, 0)];
    self.service = [UIButton buttonWithTitle:@"客服" titleColor:kTextColor2 backgroundColor:kClearColor titleFont:10];
    self.service.frame = CGRectMake(20+kWidth(48), 7.4, 48, self.height);
    [self addSubview:self.service];
    [self.service setImage:kImage(@"客服") forState:UIControlStateNormal];
    [self.service setImageEdgeInsets:UIEdgeInsetsMake(-30, 0, 0, 0)];
    [self.service setTitleEdgeInsets:UIEdgeInsetsMake(0, -37, 0, 0)];
    self.service.tag = 102;
    [self.service addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.shop =  [UIButton buttonWithTitle:@"加入购物车" titleColor:kWhiteColor backgroundColor:kHexColor(@"#524A46") titleFont:16];
    self.shop.layer.cornerRadius = 4;
    self.shop.clipsToBounds = YES;
    [self addSubview:self.shop];
    self.shop.frame = CGRectMake(self.service.xx+10, (self.height-44)/2, kWidth(115), 42);
    self.shop.tag = 103;
    [self.shop addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.buy =  [UIButton buttonWithTitle:@"立即购买" titleColor:kWhiteColor backgroundColor:kHexColor(@"#F68646") titleFont:16];
    self.buy.layer.cornerRadius = 4;
    self.buy.clipsToBounds = YES;
    self.buy.tag = 104;
    [self.buy addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.buy.frame = CGRectMake(self.shop.xx+10, (self.height-44)/2, kWidth(115), 42);
    [self addSubview:self.buy];

}

- (void)btnClick:(UIButton *)btn
{
    if (self.clickMoreBlock) {
        self.clickMoreBlock(btn.tag-100);
    }
    
}
@end
