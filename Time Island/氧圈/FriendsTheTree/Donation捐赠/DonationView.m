//
//  DonationView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "DonationView.h"

@implementation DonationView

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        CGFloat height = 594/2;
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(47.5, SCREEN_HEIGHT/2 - height/2, SCREEN_WIDTH - 95, height)];
        backView.backgroundColor = kWhiteColor;
        kViewRadius(backView, 12);
        [self addSubview:backView];
        
        UIButton *ShutDownBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        ShutDownBtn.frame = CGRectMake(SCREEN_WIDTH - 45 - 25, backView.y - 25 - 18, 25, 25);
        [ShutDownBtn setImage:kImage(@"删除") forState:(UIControlStateNormal)];
        self.ShutDownBtn = ShutDownBtn;
        [self addSubview:ShutDownBtn];
        
        
        UIImageView *topImage = [[UIImageView alloc]initWithFrame:CGRectMake(height/2 - 30, 31, 60, 54)];
        topImage.image = kImage(@"捐赠");
        [backView addSubview:topImage];
        
        UILabel *nameLable = [UILabel labelWithFrame:CGRectMake(0, topImage.yy + 10, SCREEN_WIDTH - 95, 18) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(18) textColor:kTextBlack];
        nameLable.text = @"给好友捐赠";
        [backView addSubview:nameLable];
        
        UILabel *introduceLable = [UILabel labelWithFrame:CGRectMake(0, nameLable.yy + 15, SCREEN_WIDTH - 95, 15) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(15) textColor:kHexColor(@"#999999")];
        introduceLable.text = @"帮助好友的古树快快成长";
        [backView addSubview:introduceLable];
        
        UILabel *contactLable = [UILabel labelWithFrame:CGRectMake(0, introduceLable.yy + 29.5, SCREEN_WIDTH - 95, 21) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(15) textColor:kHexColor(@"#666666")];
        contactLable.text = @"将自己的 10g碳泡泡 赠送给好友";
        [backView addSubview:contactLable];
        
        
        UIButton *confirmBtn = [UIButton buttonWithTitle:@"继续捐赠" titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:16];
        confirmBtn.frame = CGRectMake(35, contactLable.yy + 28.5, SCREEN_WIDTH - 93 - 70, 45);
        self.confirmBtn = confirmBtn;
        [backView addSubview:confirmBtn];
        
        
    }
    return self;
}

@end
