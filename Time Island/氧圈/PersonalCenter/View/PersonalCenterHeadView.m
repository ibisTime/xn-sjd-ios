//
//  PersonalCenterHeadView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/28.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "PersonalCenterHeadView.h"

@implementation PersonalCenterHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180 - 65 + kNavigationBarHeight)];
        topView.backgroundColor = kTabbarColor;
        [self addSubview:topView];
        
        UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 30, 32 + kStatusBarHeight - 20, 60, 60)];
        headView.image = kImage(@"头像");
        kViewRadius(headView, 30);
        [self addSubview:headView];
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, headView.yy + 10, SCREEN_WIDTH - 30, 18) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(18) textColor:kWhiteColor];
        nameLbl.text = @"赤金炎人";
        [self addSubview:nameLbl];
        
        UILabel *LVLbl = [UILabel labelWithFrame:CGRectMake(10, nameLbl.yy + 7, SCREEN_WIDTH/2 - 20, 11) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(11) textColor:kWhiteColor];
        LVLbl.text = @"LV0 初探氧林";
        [self addSubview:LVLbl];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, nameLbl.yy + 7, 1, 11)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
        UILabel *friendsLbl = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH/2 + 10, nameLbl.yy + 7, SCREEN_WIDTH/2 - 20, 11) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(11) textColor:kWhiteColor];
        friendsLbl.text = @"好友 10";
        [self addSubview:friendsLbl];
        
        
        UILabel *contentLbl = [UILabel labelWithFrame:CGRectMake(15, friendsLbl.yy + 10, SCREEN_WIDTH - 30, 11) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(11) textColor:kWhiteColor];
        contentLbl.text = @"简介：天真烂漫，不知羞耻，胡言乱语，乱七八糟。。。。";
        [self addSubview:contentLbl];
        
        
        UILabel *titleLbl = [UILabel labelWithFrame:CGRectMake(15, topView.yy , 100, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(15) textColor:kTextBlack];
        titleLbl.text = @"认养的树";
        [self addSubview:titleLbl];
        
        
        UIButton *screeningBtn = [UIButton buttonWithTitle:@"筛选" titleColor:RGB(153, 153, 153) backgroundColor:kClearColor titleFont:13];
        screeningBtn.frame = CGRectMake(SCREEN_WIDTH - 15 - 50, topView.yy , 50, 40);
        screeningBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [screeningBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:4 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(@"下拉") forState:(UIControlStateNormal)];
        }];
        [self addSubview:screeningBtn];

        
        UIButton *addressBtn = [UIButton buttonWithTitle:@"所在地区" titleColor:RGB(153, 153, 153) backgroundColor:kClearColor titleFont:13];
        addressBtn.frame = CGRectMake(SCREEN_WIDTH - 15 - 50 - 15 - 80, topView.yy , 80, 40);
        addressBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [addressBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:4 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(@"下拉") forState:(UIControlStateNormal)];
        }];
        [self addSubview:addressBtn];
        
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.yy + 39, SCREEN_WIDTH, 1)];
        bottomView.backgroundColor = kLineColor;
        [self addSubview:bottomView];
        
    }
    return self;
}

@end
