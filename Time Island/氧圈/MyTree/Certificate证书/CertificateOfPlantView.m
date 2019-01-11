//
//  CertificateOfPlantView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/10.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "CertificateOfPlantView.h"
#define WIDTH kWidth(280)
@implementation CertificateOfPlantView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *ShutDownBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        ShutDownBtn.frame = CGRectMake(SCREEN_WIDTH - kWidth(75), kHeight(177/2), 25, 25);
        [ShutDownBtn setImage:kImage(@"删除") forState:(UIControlStateNormal)];
        self.ShutDownBtn = ShutDownBtn;
        [self addSubview:ShutDownBtn];
        
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kHeight(139), SCREEN_WIDTH, kHeight(435))];
//        scrollView.pagingEnabled = YES;
//        scrollView.delegate = self;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.directionalLockEnabled = YES;
        
        scrollView.contentSize = CGSizeMake(kWidth(35) + 5*(kWidth(280 + 25)), 0);
        [self addSubview:scrollView];
        
        
        for (int i = 0; i < 5; i ++) {
            UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(35 + i % 5 *kWidth(280 + 25), 0, WIDTH, kHeight(435))];
            backImg.image = kImage(@"证书背景");
            [scrollView addSubview:backImg];
            
            
            UIImageView *cerBackImg = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth(140) - kHeight(106.5/2), kHeight(21), kHeight(106.5), kHeight(71))];
            
            cerBackImg.image = kImage(@"植物证书");
            [backImg addSubview:cerBackImg];
            
            UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(cerBackImg.width/2 - kHeight(40), kHeight(46.5), kHeight(80), kHeight(22.5)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(16) textColor:kHexColor(@"#A1622A")];
            nameLbl.text = @"植物证书";
//            nameLbl.backgroundColor = [UIColor whiteColor];
            [cerBackImg addSubview:nameLbl];
            
            UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth(140) - kHeight(45/2), kHeight(120), kHeight(45), kHeight(45))];
            
            headImg.image = kImage(@"头像");
            [backImg addSubview:headImg];
            
            UILabel *contentLbl = [UILabel labelWithFrame:CGRectMake(kWidth(20), headImg.yy + kHeight(10), WIDTH - kWidth(40), kHeight(16)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(16) textColor:kTextBlack];
            contentLbl.text = @"tignting，谢谢你";
            [backImg addSubview:contentLbl];
            
            UILabel *introduceLbl = [UILabel labelWithFrame:CGRectMake(kWidth(20), contentLbl.yy + kHeight(13.5), kWidth(280) - kWidth(40), 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kHexColor(@"#666666")];
            introduceLbl.attributedText = [UserModel ReturnsTheDistanceBetween:@"你已于2018年4月21日认养的樟树，已被认领，将种植到鄂尔多斯地区。"];
            introduceLbl.numberOfLines = 0;
            [introduceLbl sizeToFit];
            [backImg addSubview:introduceLbl];
            
            
            UILabel *codeLabel = [UILabel labelWithFrame:CGRectMake(WIDTH/2 - 35, introduceLbl.yy + kHeight(24), 70, kHeight(22.5)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(16) textColor:kHexColor(@"#23AD8C")];
            codeLabel.text = @"树苗编号";
            [backImg addSubview:codeLabel];
            
            UIImageView *leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2 - 35 - 75, codeLabel.y + kHeight(22.5)/2 - kHeight(1.5), 65, kHeight(3))];
            leftImg.image = kImage(@"编号左");
            leftImg.centerY = codeLabel.centerY;
            [backImg addSubview:leftImg];
            
            UIImageView *rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2 + 35 + 10, codeLabel.y + kHeight(22.5)/2 - kHeight(1.5), 65, kHeight(3))];
            rightImg.image = kImage(@"编号右");
            rightImg.centerY = codeLabel.centerY;
            [backImg addSubview:rightImg];
//
            
            UIImageView *codeBackImg = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth(30), codeLabel.yy + kHeight(13), WIDTH - kWidth(60), kHeight(45))];
            codeBackImg.image = kImage(@"编号框框");
            [backImg addSubview:codeBackImg];
            
            UILabel *codeNumberLbl = [UILabel labelWithFrame:CGRectMake(kWidth(45), codeBackImg.y + kHeight(11), WIDTH - kWidth(90), kHeight(25)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(18) textColor:kHexColor(@"#23AD8C")];
            codeNumberLbl.text = @"NO.SP1883457567798";
            [backImg addSubview:codeNumberLbl];
            
        }
    }
    return self;
}

@end
