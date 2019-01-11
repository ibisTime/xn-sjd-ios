//
//  ThePropsView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "ThePropsView.h"

#define HEIGHT kHeight(652/2)

@interface ThePropsView()
{
    UIButton *selectBtn;
    UIView *lineView;
}

@end

@implementation ThePropsView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - HEIGHT, SCREEN_WIDTH, HEIGHT + 100)];
        backView.backgroundColor = kWhiteColor;
        [self addSubview:backView];
        
        
        NSArray *btnArray = @[@"保护罩",@"一键收取"];
        for (int i = 0; i < 2; i ++) {
            UIButton *btn = [UIButton buttonWithTitle:btnArray[i] titleColor:kHexColor(@"#666666") backgroundColor:kWhiteColor titleFont:15];
            btn.frame = CGRectMake(50 + i % 2 * (SCREEN_WIDTH/2 - 50), 0, SCREEN_WIDTH/2 - 50, kHeight(48));
            [btn setTitleColor:kHexColor(@"#23AD8C") forState:(UIControlStateSelected)];
            if (i == 0) {
                btn.selected = YES;
                selectBtn = btn;
            }
            btn.tag = 100 + i;
            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [backView addSubview:btn];
        }
        
        UIButton *deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        deleteBtn.frame = CGRectMake(SCREEN_WIDTH - kHeight(48), 0, kHeight(48), kHeight(48));
        [deleteBtn setImage:kImage(@"删除 灰色") forState:(UIControlStateNormal)];
        self.deleteBtn = deleteBtn;
        [backView addSubview:deleteBtn];
        
        lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight(48), 46, kHeight(2))];
        lineView.backgroundColor = kHexColor(@"#23AD8C");
        kViewRadius(lineView, 1.5);
        lineView.centerX = selectBtn.centerX;
        [backView addSubview:lineView];
        
        UIView *bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight(50), SCREEN_WIDTH, 1)];
        bottomLineView.backgroundColor = kLineColor;
        [backView addSubview:bottomLineView];
        
        
        
        NSArray *nameArray = @[@"保护罩",@"钻石保护罩"];
        
        NSArray *promptArray = @[@"每天限量50万",@"钻石会员专享"];
        for (int i = 0; i < 2; i ++) {
            UIButton *shieldingBackBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            shieldingBackBtn.frame = CGRectMake(kWidth(74/2) + i % 2 * (kWidth(274/2 + 56/2)), bottomLineView.yy + kHeight(20), kWidth(274/2), kHeight(204));
            kViewBorderRadius(shieldingBackBtn, 7.5, 1, kHexColor(@"#E5E5E5"));
            self.shieldingBackBtn = shieldingBackBtn;
            [backView addSubview:shieldingBackBtn];
            
            UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(0, kHeight(15), kWidth(274/2), kHeight(20)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(14) textColor:kTextBlack];
            nameLbl.text = nameArray[i];
            [shieldingBackBtn addSubview:nameLbl];
            
            UILabel *promptLbl = [UILabel labelWithFrame:CGRectMake(kWidth(15), nameLbl.yy + kHeight(4), kWidth(274/2) - kWidth(30), kHeight(24)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(12) textColor:kHexColor(@"#FFA40F")];
            kViewBorderRadius(promptLbl, kHeight(12), 1, kHexColor(@"#FFA40F"));
            promptLbl.text = promptArray[i];
            [shieldingBackBtn addSubview:promptLbl];
         
            
            UIImageView *shieldingImg = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth(274/2)/2 - kHeight(138/2)/2, promptLbl.yy + kHeight(16), kHeight(138/2), kHeight(138/2))];
            shieldingImg.image = kImage(@"保护罩小图");
            [shieldingBackBtn addSubview:shieldingImg];
            
            UILabel *timeLbl = [UILabel labelWithFrame:CGRectMake(shieldingImg.x, shieldingImg.y + kHeight(51), shieldingImg.width, kHeight(16.5)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#438A0F")];
            timeLbl.text = @"1天";
            [shieldingBackBtn addSubview:timeLbl];
            
            UILabel *integralLbl = [UILabel labelWithFrame:CGRectMake(kWidth(15), shieldingImg.yy + kHeight(12.5), kWidth(274/2) - kWidth(30), kHeight(32)) textAligment:(NSTextAlignmentCenter) backgroundColor:kHexColor(@"#23AD8C") font:FONT(15) textColor:kWhiteColor];
            integralLbl.text = @"200积分";
            kViewRadius(integralLbl, 2.5);
            [shieldingBackBtn addSubview:integralLbl];
            
            
            
        }
        
        UIButton *myPointsBtn = [UIButton buttonWithTitle:@"我的积分：3455" titleColor:kHexColor(@"#666666") backgroundColor:kClearColor titleFont:14];
        myPointsBtn.frame = CGRectMake(0, self.shieldingBackBtn.yy, SCREEN_WIDTH, kHeight(50));
        [myPointsBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:4 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(@"积分更多") forState:(UIControlStateNormal)];
        }];
        [backView addSubview:myPointsBtn];
        
    }
    return self;
}


-(void)BtnClick:(UIButton *)sender
{
    
}

@end
