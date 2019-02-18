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
//    UIButton *selectBtn;
    UIView *lineView;
    UIView *backView;
    UIView * bottomView;
    NSInteger state;
    UIButton *selectBtn;
    
    UILabel *nameLbl;
    UILabel *promptLbl;
    UILabel *timeLbl;
    UILabel *integralLbl;
}

@end

@implementation ThePropsView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        backView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - HEIGHT, SCREEN_WIDTH, kHeight(52))];
        backView.backgroundColor = kWhiteColor;
        [self addSubview:backView];
        
        
        NSArray *btnArray = @[@"保护罩",@"一键收取"];
        for (int i = 0; i < 2; i ++) {
            UIButton *btn = [UIButton buttonWithTitle:btnArray[i] titleColor:kHexColor(@"#666666") backgroundColor:kWhiteColor titleFont:15];
            btn.frame = CGRectMake(50 + i % 2 * (SCREEN_WIDTH/2 - 50), 0, SCREEN_WIDTH/2 - 50, kHeight(48));
            [btn setTitleColor:kHexColor(@"#23AD8C") forState:(UIControlStateSelected)];
            if (i == state) {
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
        
        lineView = [[UIView alloc]initWithFrame:CGRectMake(0 + state*(SCREEN_WIDTH/3) , kHeight(48), 46, kHeight(2))];
        lineView.backgroundColor = kHexColor(@"#23AD8C");
        kViewRadius(lineView, 1.5);
        lineView.centerX = selectBtn.centerX;
        [backView addSubview:lineView];
        
        UIView *bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight(50), SCREEN_WIDTH, 1)];
        bottomLineView.backgroundColor = kLineColor;
        [backView addSubview:bottomLineView];
        
        
//        [self CreateUI];
        [self getdata];
    }
    return self;
}

-(void)getdata{
    self.array = [NSMutableArray array];
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629507";
    http.parameters[@"type"] = @(state);
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"status"] = @(1);
    [http postWithSuccess:^(id responseObject) {
        self.array = responseObject[@"data"];
        
        [self CreateUI];
        
    } failure:^(NSError *error) {
        
    }];
}
-(void)CreateUI{
    
    [bottomView removeFromSuperview];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, backView.yy, SCREEN_WIDTH, HEIGHT + 100 - 55)];
    
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.directionalLockEnabled = YES;
    scrollView.backgroundColor = kWhiteColor;
    
    scrollView.contentSize = CGSizeMake(kWidth(35) + 5*(kWidth(280 + 25)), 0);
    [self addSubview:scrollView];
    
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, backView.yy, SCREEN_WIDTH, HEIGHT + 100 - 55)];
    bottomView.backgroundColor = kWhiteColor;
    
//    [scrollView addSubview:bottomView];
//    [self addSubview:scrollView];
//    [self addSubview:bottomView];
    
    NSMutableArray *nameArray = [NSMutableArray array];
    NSMutableArray *promptArray = [NSMutableArray array];
    NSMutableArray * timearray = [NSMutableArray array];
    NSMutableArray * pricearray = [NSMutableArray array];
    for (int i = 0 ; i < self.array.count; i++) {
        [nameArray addObject:self.array[i][@"name"]];
        [promptArray addObject:self.array[i][@"description"]];
        [timearray addObject:[NSString stringWithFormat:@"%@",self.array[i][@"validityTerm"]]];
        [pricearray addObject:self.array[i][@"price"]];


        nameLbl.text = nameArray[i];
        promptLbl.text = promptArray[i];
        timeLbl.text = timearray[i];
        integralLbl.text = [NSString stringWithFormat:@"%.2f 积分",[pricearray[i] floatValue] / 1000];
    }

    
    for (int i = 0; i < self.array.count; i ++) {
        UIButton *shieldingBackBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        shieldingBackBtn.frame = CGRectMake(kWidth(74/2) + i % 2 * (kWidth(274/2 + 56/2)), kHeight(30), kWidth(274/2), kHeight(204));
        kViewBorderRadius(shieldingBackBtn, 7.5, 1, kHexColor(@"#E5E5E5"));
        self.shieldingBackBtn = shieldingBackBtn;
//        [bottomView addSubview:shieldingBackBtn];
        [scrollView addSubview:shieldingBackBtn];
        
        nameLbl = [UILabel labelWithFrame:CGRectMake(0, kHeight(15), kWidth(274/2), kHeight(20)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(14) textColor:kTextBlack];
        nameLbl.text = nameArray[i];
        [shieldingBackBtn addSubview:nameLbl];
        
        promptLbl = [UILabel labelWithFrame:CGRectMake(kWidth(15), nameLbl.yy + kHeight(4), kWidth(274/2) - kWidth(30), kHeight(24)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(12) textColor:kHexColor(@"#FFA40F")];
        kViewBorderRadius(promptLbl, kHeight(12), 1, kHexColor(@"#FFA40F"));
        promptLbl.text = promptArray[i];
        [shieldingBackBtn addSubview:promptLbl];
        
        
        UIImageView *shieldingImg = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth(274/2)/2 - kHeight(138/2)/2, promptLbl.yy + kHeight(16), kHeight(138/2), kHeight(138/2))];
        shieldingImg.image = kImage(@"保护罩小图");
        [shieldingBackBtn addSubview:shieldingImg];
        
        timeLbl = [UILabel labelWithFrame:CGRectMake(shieldingImg.x, shieldingImg.y + kHeight(51), shieldingImg.width, kHeight(16.5)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#438A0F")];
//        timeLbl.text = @"1天";
        timeLbl.text = timearray[i];
        [shieldingBackBtn addSubview:timeLbl];
        
        integralLbl = [UILabel labelWithFrame:CGRectMake(kWidth(15), shieldingImg.yy + kHeight(12.5), kWidth(274/2) - kWidth(30), kHeight(32)) textAligment:(NSTextAlignmentCenter) backgroundColor:kHexColor(@"#23AD8C") font:FONT(15) textColor:kWhiteColor];
//        integralLbl.text = @"200积分";
        
        if ([self.array[i][@"isBuy"] isEqualToString:@"1"]) {
            integralLbl.text = @"立即使用";
        }
        else
            integralLbl.text = [NSString stringWithFormat:@"%.2f 积分",[pricearray[i] floatValue] / 1000];

        kViewRadius(integralLbl, 2.5);
        [shieldingBackBtn addSubview:integralLbl];
        
        UIButton * btn = [UIButton buttonWithTitle:@"" titleColor:kClearColor backgroundColor:kClearColor titleFont:0];
        btn.frame = CGRectMake(kWidth(15), shieldingImg.yy + kHeight(12.5), kWidth(274/2) - kWidth(30), kHeight(32));
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(ClickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [shieldingBackBtn addSubview:btn];
        
    }
    
    UIButton *myPointsBtn = [UIButton buttonWithTitle:@"我的积分：3455" titleColor:kHexColor(@"#666666") backgroundColor:kClearColor titleFont:14];
    myPointsBtn.frame = CGRectMake(0, self.shieldingBackBtn.yy, SCREEN_WIDTH, kHeight(50));
    [myPointsBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:4 imagePositionBlock:^(UIButton *button) {
        [button setImage:kImage(@"积分更多") forState:(UIControlStateNormal)];
    }];
    [bottomView addSubview:myPointsBtn];
    
}
-(void)ClickBtn:(UIButton *)sender{
    NSLog(@"%s",__func__);
    int i = (int)sender.tag - 100;
//    [self.delegate ClickButton:self.array[i]];
    NSMutableArray * arr = [NSMutableArray array];
    [arr addObject:self.array[i]];
    if (self.delegate) {
        [self.delegate ClickButton:arr];
    }
}


-(void)BtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    selectBtn.selected = !sender.selected;
    selectBtn = sender;
    NSLog(@"%s",__func__);
    state = sender.tag - 100;
    [UIView animateWithDuration:0.3 animations:^{
     lineView.centerX = sender.centerX;
    }];
    [self getdata];
}

@end
