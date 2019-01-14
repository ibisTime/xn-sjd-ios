//
//  BarrageEncapsulationView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "BarrageEncapsulationView.h"

@implementation BarrageEncapsulationView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
        kViewBorderRadius(backView, kHeight(20), 1, kLineColor);
        [self addSubview:backView];
        
        UIView *rightView = [[UIView alloc]init];
        rightView.backgroundColor = kWhiteColor;
        [self addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.width.equalTo(@(kHeight(20)));
            make.right.equalTo(self.mas_right).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
        }];


        self.nameLabel = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextBlack font:14];
        [self addSubview:self.nameLabel];

        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(self.mas_left).offset(kWidth(15));
            make.right.equalTo(self.mas_right).offset(kHeight(45));
            make.bottom.equalTo(self.mas_bottom).offset(0);
        }];

        self.rightImg = [[UIImageView alloc]init];
        [self addSubview:self.rightImg];
        [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.right.equalTo(self.mas_right).offset(0);
            make.width.equalTo(@(kHeight(40)));
            make.bottom.equalTo(self.mas_bottom).offset(0);
        }];
    }
    return self;
}

@end
