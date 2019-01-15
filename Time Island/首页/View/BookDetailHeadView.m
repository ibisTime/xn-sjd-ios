//
//  BookDetailHeadView.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BookDetailHeadView.h"

@implementation BookDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self initNoticeView];
     
    }
    return self;
}

- (void)initNoticeView
{
   
    UILabel *moreLab = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(0, 0, 0) font:18];
    moreLab.frame = CGRectMake(15, 20, kScreenWidth-30, 25);
    moreLab.textAlignment = NSTextAlignmentLeft;
    moreLab.text = @"我的第一次认养";
    self.moreLab = moreLab;
    [self addSubview:moreLab];
    [moreLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    UILabel *detailLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:13];
    detailLab.frame = CGRectMake(15, moreLab.yy+11, 100, 24);
    detailLab.textAlignment = NSTextAlignmentLeft;
    detailLab.text = @"作者: 威震天";
    self.detailLab = detailLab;
    [self addSubview:detailLab];
    
    UILabel *moneyLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kHexColor(@"#23AD8C") font:13];
    moneyLab.frame = CGRectMake(kScreenWidth-155, moreLab.yy+10, 140, 24);
    moneyLab.textAlignment = NSTextAlignmentLeft;
    moneyLab.text = @"关联古树: 爱心树";
    self.moneyLab = moneyLab;
    [self addSubview:moneyLab];
    
    UILabel *timeLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:13];
    timeLab.frame = CGRectMake(15, detailLab.yy+10, 90, 24);
    timeLab.textAlignment = NSTextAlignmentLeft;
    timeLab.text = @"2018.01.15";
    self.timeLab = timeLab;
    [self addSubview:timeLab];
    
    UILabel *collectLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:13];
    collectLab.frame = CGRectMake(moneyLab.x, moneyLab.yy+12, 80, 24);
    collectLab.textAlignment = NSTextAlignmentLeft;
    collectLab.text = @"收藏 100";
    self.collectLab = collectLab;
    [self addSubview:collectLab];
    
    UILabel *praiseLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:13];
    praiseLab.frame = CGRectMake(collectLab.xx, detailLab.yy+12, 80, 24);
    praiseLab.textAlignment = NSTextAlignmentLeft;
    praiseLab.text = @"评论 100";
    self.praiseLab = praiseLab;
    [self addSubview:praiseLab];
    
    UIView *line = [UIView new];
    line.frame = CGRectMake(0, collectLab.yy+20, kScreenWidth, 1);
    line.backgroundColor = RGB(244, 244, 244);
    [self addSubview:line];
    
}
@end
