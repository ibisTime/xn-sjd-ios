//
//  OxygenCircleView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/10.
//  Copyright © 2019 ChengLian. All rights reserved.
//


#import "OxygenCircleView.h"


#define Width (kScreenWidth)/546
#define Height (kScreenHeight)/(977 + kBottomInsetHeight*2)

@implementation OxygenCircleView



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initView];
    }
    return self;
}

-(void)initView
{
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, -1, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - kTabBarHeight + 1)];
    backImg.image = kImage(@"氧圈");
    [self addSubview:backImg];
    
    
//    UIView *headPortraitView = [[UIView alloc]initWithFrame:CGRectMake(-50.5, 14, 101, 39)];
//    headPortraitView.backgroundColor = kWhiteColor;
//    kViewRadius(headPortraitView, 39/2);
//    headPortraitView.alpha = 0.3;
//    [self addSubview:headPortraitView];
    
    UIButton *headPortraitView = [UIButton buttonWithType:(UIButtonTypeCustom)];
    headPortraitView.frame = CGRectMake(-50.5, 14, 101, 39);
    headPortraitView.backgroundColor = kWhiteColor;
    kViewRadius(headPortraitView, 39/2);
    headPortraitView.alpha = 0.3;
    [headPortraitView addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    headPortraitView.tag = 104;
    [self addSubview:headPortraitView];
    
    
    UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(14.5, 18.5, 30, 30)];
    kViewBorderRadius(headImg, 15, 1, kTabbarColor);
    headImg.image = kImage(@"头像");
    [self addSubview:headImg];
    
    UIButton *rankingBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    rankingBtn.frame = CGRectMake(SCREEN_WIDTH - kWidth(14.5) - kWidth(37.5), kHeight(14), kWidth(37.5), kHeight(42));
    [rankingBtn setImage:kImage(@"氧圈排行榜") forState:(UIControlStateNormal)];
    [rankingBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    rankingBtn.tag = 100;
    [self addSubview:rankingBtn];
    
    
    UIButton *myTreeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    myTreeBtn.frame = CGRectMake(Width*240, 83 * Height, 78*Width, 40 * Height);
    [myTreeBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    myTreeBtn.tag = 101;
    [self addSubview:myTreeBtn];
    
    
    UIButton *friendsListBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    friendsListBtn.frame = CGRectMake(42 *Width, 330 * Height, 78*Width, 40 * Height);
    [friendsListBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    friendsListBtn.tag = 102;
    [self addSubview:friendsListBtn];
    
    
    
    UIButton *myArticleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    myArticleBtn.frame = CGRectMake(385 *Width, 370 * Height, 78*Width, 40 * Height);
    [myArticleBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    myArticleBtn.tag = 103;
    [self addSubview:myArticleBtn];
    
    

    
}

-(void)buttonClick:(UIButton *)sender
{
    [_delegate OxygenCircleButton:sender.tag - 100];
}


@end
