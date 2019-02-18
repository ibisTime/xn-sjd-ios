//
//  ThePropsDetailsView.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/18.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "ThePropsDetailsView.h"

@implementation ThePropsDetailsView{
    UIView * view;
    UILabel * nameLab;
    UILabel * describeLab;
    UILabel * desLab;
    UIButton * button;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *ShutDownBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        ShutDownBtn.frame = CGRectMake(SCREEN_WIDTH - kWidth(50), SCREEN_HEIGHT / 3 - 40, 25, 25);
        [ShutDownBtn setImage:kImage(@"删除") forState:(UIControlStateNormal)];
        self.ShutDownBtn = ShutDownBtn;
        [self addSubview:ShutDownBtn];
        
        
        view = [[UIView alloc]initWithFrame:CGRectMake(45, SCREEN_HEIGHT / 3, SCREEN_WIDTH - 90, SCREEN_HEIGHT / 3)];
        view.backgroundColor = kWhiteColor;
        kViewBorderRadius(view, 7.5, 1, kHexColor(@"#E5E5E5"));
        [self addSubview:view];
        
        nameLab = [UILabel labelWithFrame:CGRectMake(0, 10, view.width, 15) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(17) textColor:kTextBlack];
        [view addSubview:nameLab];
        
        describeLab = [UILabel labelWithFrame:CGRectMake((view.width - view.width) / 2, nameLab.yy + 10, view.width, 24) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(16) textColor:kHexColor(@"#FFA40F")];
        kViewBorderRadius(describeLab, kHeight(12), 1, kHexColor(@"#FFA40F"));
        [view addSubview:describeLab];
        
        desLab = [UILabel labelWithFrame:CGRectMake(0, describeLab.yy + 15, view.width, 26) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(16) textColor:kTextBlack];
        desLab.numberOfLines = 0;
        [view addSubview:desLab];
        
        button = [UIButton buttonWithTitle:@"" titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:15];
        button.frame = CGRectMake(30, view.height - 60, view.width - 60, 30);
        kViewRadius(button, 7.5);
        [button addTarget:self action:@selector(ClickButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:button];
        
        
    }
    return self;
}

-(void)setArray:(NSMutableArray *)array{
    _array = array;
    nameLab.text = array[0][@"name"];
    describeLab.text = array[0][@"description"];
    [describeLab sizeToFit];
    describeLab.frame = CGRectMake((view.width - describeLab.width - 6) / 2, nameLab.yy + 5, describeLab.width + 6, 24);
    desLab.text = array[0][@"description"];
    if ([array[0][@"isBuy"] isEqualToString:@"1"]) {
        [button setTitle:@"立即使用" forState:(UIControlStateNormal)];
    }
    else
        [button setTitle:[NSString stringWithFormat:@"%.2f积分兑换",[array[0][@"price"] floatValue] / 1000] forState:(UIControlStateNormal)];
}

-(void)ClickButton:(UIButton *)sender{
    
    NSLog(@"%s",__func__);
    if (self.delegate) {
        [self.delegate ClickConvertBtn:self.array];
    }
}

@end
