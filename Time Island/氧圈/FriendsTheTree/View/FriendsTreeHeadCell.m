//
//  FriendsTreeHeadCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "FriendsTreeHeadCell.h"

@implementation FriendsTreeHeadCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,  kHeight(432))];
        backImg.image = kImage(@"树 跟背景");
        [self addSubview:backImg];
        
        FloatingBallHeader *floatingBallHeader = [[FloatingBallHeader alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, SCREEN_WIDTH, (kHeight(432) - kNavigationBarHeight) - kHeight(200))];
        floatingBallHeader.delegate = self;
        
        floatingBallHeader.dataList = @[@{@"number":@"68g",@"name":@"BTC"},        @{@"number":@"68g",@"name":@"线下"}, @{@"number":@"2g",@"name":@"线下支付"}, @{@"number":@"268g",@"name":@"支付"},@{@"number":@"63g",@"name":@"线下支付"}, @{@"number":@"638g",@"name":@"线下"}, @{@"number":@"168g",@"name":@"线下支付"}];
        
        [self addSubview:floatingBallHeader];
        self.floatingBallHeader = floatingBallHeader;
        
    
        
        UIView *headPortraitView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 207/2, 72.5 - 64 + kNavigationBarHeight, 207, 39)];
        headPortraitView.backgroundColor = kWhiteColor;
        kViewRadius(headPortraitView, 39/2);
        headPortraitView.alpha = 0.3;
        [self addSubview:headPortraitView];
        
        UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 207/2 + 4.5, 72.5 - 64 + kNavigationBarHeight + 4.5, 30, 30)];
        kViewBorderRadius(headImg, 15, 1, kTabbarColor);
        headImg.image = kImage(@"头像");
        [self addSubview:headImg];
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(headImg.xx + 7.5, 72.5 - 64 + kNavigationBarHeight, SCREEN_WIDTH - headImg.xx - 7.5 - 5, 39) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kHexColor(@"#23AD8C")];
        nameLbl.text = @"1125g";
        [self addSubview:nameLbl];
        
        
        
        UIButton *mapBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        mapBtn.frame = CGRectMake(18 , kHeight(432) - 50.5, 36, 38);
        [mapBtn setImage:kImage(@"地图") forState:(UIControlStateNormal)];
        [mapBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        mapBtn.tag = 100;
        [self addSubview:mapBtn];
        
        UIButton *barrageBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        barrageBtn.frame = CGRectMake(SCREEN_WIDTH - 35 - 36 - 36 , kHeight(432) - 50.5, 36, 38);
        [barrageBtn setImage:kImage(@"弹幕") forState:(UIControlStateNormal)];
        [barrageBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        barrageBtn.tag = 101;
        [self addSubview:barrageBtn];
        
        UIButton *donationBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        donationBtn.frame = CGRectMake(SCREEN_WIDTH - 15 - 36 , kHeight(432) - 50.5, 36, 38);
        [donationBtn setImage:kImage(@"捐赠红色") forState:(UIControlStateNormal)];
        [donationBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        donationBtn.tag = 102;
        [self addSubview:donationBtn];
        
    }
    return self;
}

-(void)buttonClick:(UIButton *)sender
{
    [_delegate FriendsTreeHeadButton:sender.tag - 100];
}

- (void)floatingBallHeader:(FloatingBallHeader *)floatingBallHeader didPappaoAtIndex:(NSInteger)index isLastOne:(BOOL)isLastOne {
    NSLog(@"点了%zd", index);
    if (isLastOne) {
        
        
    }
    
}

@end
