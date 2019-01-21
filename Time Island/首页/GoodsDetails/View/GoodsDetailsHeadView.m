//
//  GoodsDetailsHeadView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/21.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "GoodsDetailsHeadView.h"

@implementation GoodsDetailsHeadView
{
    UIButton *selectBtn;
    
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier   ];
    if (self) {
        
        NSArray *btnArray = @[@"图文详情",@"树木参数",@"认养记录"];
        
        for (int i = 0; i < 3; i ++) {
            UIButton *btn = [UIButton buttonWithTitle:btnArray[i] titleColor:kHexColor(@"#666666") backgroundColor:kWhiteColor titleFont:14];
            btn.frame = CGRectMake(i % 3 * SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 38);
            [btn setTitleColor:kRedColor forState:(UIControlStateSelected)];
            if (i == 0) {
                btn.selected = YES;
                selectBtn = btn;
            }
            btn.tag = 100 + i;
            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [self addSubview:btn];
        }
        
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 40 - 1, SCREEN_WIDTH, 1)];
        bottomView.backgroundColor = kLineColor;
        [self addSubview:bottomView];
        
        
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 40 - 1, SCREEN_WIDTH/3, 1)];
        _lineView.backgroundColor = kRedColor;
        kViewRadius(_lineView, 1.5);
        [self addSubview:_lineView];
        
    }
    return self;
}

-(void)BtnClick:(UIButton *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.frame = CGRectMake(SCREEN_WIDTH/3 * (sender.tag - 100), 40 - 1, SCREEN_WIDTH/3, 1);
    }];
    
    
    sender.selected = !sender.selected;
    selectBtn.selected = !selectBtn.selected;
    selectBtn = sender;
    
    CoinWeakSelf;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"InvestmentLoadData" object:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.delegate GoodsDetailsHeadButton:sender.tag - 100];
    });
    
    
}

@end
