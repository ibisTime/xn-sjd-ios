//
//  BalanceView.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/11.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BalanceView.h"

@implementation BalanceView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self refresh];
        
        UIImageView *topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 111 - 64)];
        topView.backgroundColor = kTabbarColor;
        [self addSubview:topView];
        
        
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 160)];
        
        
        bgImage.image = kImage(@"余额-装饰");
        [self addSubview:bgImage];
        
        
        UILabel *currentLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kHexColor(@"#656565") font:13.0];
        currentLbl.frame = CGRectMake(15, 29, SCREEN_WIDTH - 30, 18.5);
        currentLbl.textAlignment = NSTextAlignmentCenter;
        currentLbl.text = @"碳泡泡数量";
        [bgImage addSubview:currentLbl];
        self.currentLbl = currentLbl;
        
        UILabel *amountLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:22.0];
        amountLbl.font = HGboldfont(24);
        amountLbl.frame = CGRectMake(15, currentLbl.yy + 7.5, SCREEN_WIDTH - 30, 29.5);
        amountLbl.textAlignment = NSTextAlignmentCenter;
        //        amountLbl.text = @"2480";
        [bgImage addSubview:amountLbl];
        self.amountLbl = amountLbl;
        
        UIButton * btn1 = [UIButton buttonWithTitle:@"提现" titleColor:kTabbarColor backgroundColor:kClearColor titleFont:15];
        btn1.frame = CGRectMake(87, amountLbl.yy + 27.5, 71, 30);
        btn1.layer.borderColor = kTabbarColor.CGColor;
        btn1.layer.borderWidth = 1;
        btn1.layer.cornerRadius = 2;
        btn1.layer.masksToBounds = YES;
        btn1.tag = 101;
        [btn1 addTarget:self action:@selector(BtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:btn1];
        
        UIButton * btn2 = [UIButton buttonWithTitle:@"充值" titleColor:[UIColor whiteColor] backgroundColor:kTabbarColor titleFont:15];
        btn2.frame = CGRectMake(SCREEN_WIDTH - 87 - 67, amountLbl.yy + 27.5, 67, 30);
        btn2.layer.cornerRadius = 2;
        btn2.layer.masksToBounds = YES;
        btn2.tag = 102;
        [btn2 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn2];
        
        
    }
    return self;
}
-(void)BtnClick:(UIButton *)sender{
    NSLog(@"%s",__func__);
    if (self.ClickBtn) {
        self.ClickBtn(sender.tag - 100);
    }
    
//    if ([self respondsToSelector:@selector(BtnClick:)]) {
//        [_delegate BtnClick:sender.tag];
//    }
}


-(void)refresh{
    TLNetworking * http1 = [[TLNetworking alloc]init];
    http1.code = @"802300";
    http1.parameters[@"userId"] = [TLUser user].userId;
    http1.parameters[@"start"] = @(1);
    http1.parameters[@"limit"] = @(10);
    [http1 postWithSuccess:^(id responseObject) {
        self.array = responseObject[@"data"][@"list"];
//        for (int i = 0; i < 3; i ++) {
            float amount3 = [self.array[0][@"amount"] floatValue] / 1000.00;
            NSString * str3 = [NSString stringWithFormat:@"%.2f",amount3];
            self.amountLbl.text = str3;
//        }
    } failure:^(NSError *error) {
        
        
    }];
}
@end
