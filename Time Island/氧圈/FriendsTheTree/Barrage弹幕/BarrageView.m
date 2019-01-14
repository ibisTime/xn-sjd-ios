//
//  BarrageView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "BarrageView.h"
#import "BarrageEncapsulationView.h"
@implementation BarrageView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kHeight(635)/2, SCREEN_WIDTH, kHeight(635)/2 + 100)];
        backView.backgroundColor = kWhiteColor;
//        backView.alpha = ;
        [self addSubview:backView];
        
        UIButton *ShutDownBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        ShutDownBtn.frame = CGRectMake(SCREEN_WIDTH - 15 - 25, backView.y + 15, 25, 25);
        [ShutDownBtn setImage:kImage(@"删除 灰色") forState:(UIControlStateNormal)];
        self.ShutDownBtn = ShutDownBtn;
        [self addSubview:ShutDownBtn];
        
        
        BarrageEncapsulationView *view1 = [[BarrageEncapsulationView alloc]initWithFrame:CGRectMake(15, kHeight(96)/2, 180, kHeight(40))];
        view1.nameLabel.text = @"感谢帮我收能量";
        view1.rightImg.image = kImage(@"1");
        [backView addSubview:view1];
        
        BarrageEncapsulationView *view2 = [[BarrageEncapsulationView alloc]initWithFrame:CGRectMake(view1.xx + 18 , kHeight(96)/2, 150, kHeight(40))];
        view2.nameLabel.text = @"给你点个赞";
        view2.rightImg.image = kImage(@"点赞@2x");
        [backView addSubview:view2];
        
        
        BarrageEncapsulationView *view3 = [[BarrageEncapsulationView alloc]initWithFrame:CGRectMake(15, view1.yy + kHeight(15), 210, kHeight(40))];
        view3.nameLabel.text = @"我控制不住我自己啊~";
        view3.rightImg.image = kImage(@"2");
        [backView addSubview:view3];
        
        BarrageEncapsulationView *view4 = [[BarrageEncapsulationView alloc]initWithFrame:CGRectMake(15, view3.yy + kHeight(15), 190, kHeight(40))];
        view4.nameLabel.text = @"勤快的宝宝有能量~";
        view4.rightImg.image = kImage(@"3");
        [backView addSubview:view4];
        
        BarrageEncapsulationView *view5 = [[BarrageEncapsulationView alloc]initWithFrame:CGRectMake(view4.xx + 8, view3.yy + kHeight(15), 155, kHeight(40))];
        view5.nameLabel.text = @"我对你已绝望";
        view5.rightImg.image = kImage(@"4");
        [backView addSubview:view5];
        
        BarrageEncapsulationView *view6 = [[BarrageEncapsulationView alloc]initWithFrame:CGRectMake(15, view4.yy + kHeight(15), 335, kHeight(40))];
        view6.nameLabel.text = @"你行行好，别把我的能量全收走，可以吗~";
        view6.rightImg.image = kImage(@"5");
        [backView addSubview:view6];
        
        BarrageEncapsulationView *view7 = [[BarrageEncapsulationView alloc]initWithFrame:CGRectMake(15, view6.yy + kHeight(15), 210, kHeight(40))];
        view7.nameLabel.text = @"你怎么每天这么勤快呢";
        view7.rightImg.image = kImage(@"6");
        [backView addSubview:view7];
    }
    return self;
}

@end
