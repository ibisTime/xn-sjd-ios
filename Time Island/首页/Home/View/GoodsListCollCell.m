//
//  GoodsListCollCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/19.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "GoodsListCollCell.h"

@implementation GoodsListCollCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIView *backView = [[UIView alloc]init];
        self.backView = backView;
//        backView.backgroundColor = [UIColor redColor];
        [self addSubview:backView];
        
        
        UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 30)/2, (SCREEN_WIDTH - 30)/2)];
        headImage.image = kImage(@"树 跟背景");
        kViewRadius(headImage, 6);
        [backView addSubview:headImage];
        
        
        UILabel *statusLbl = [UILabel labelWithFrame:CGRectMake(0, 0, 40, 18) textAligment:(NSTextAlignmentCenter) backgroundColor:kTabbarColor font:FONT(12) textColor:kWhiteColor];
//        kViewRadius(statusLbl, 4);
        statusLbl.text = @"集体";
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:statusLbl.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(6,6)];//圆角大小
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = statusLbl.bounds;
        maskLayer.path = maskPath.CGPath;
        statusLbl.layer.mask = maskLayer;

        [headImage addSubview:statusLbl];
        
        UILabel *adoptLbl = [UILabel labelWithFrame:CGRectMake((SCREEN_WIDTH - 30)/2 - 55, (SCREEN_WIDTH - 30)/2 - 36, 55, 18) textAligment:(NSTextAlignmentCenter) backgroundColor:RGB(234, 85, 78) font:FONT(11) textColor:kWhiteColor];
        adoptLbl.text = @"不可认养";
        
        UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:adoptLbl.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(4,4)];//圆角大小
        CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
        maskLayer1.frame = adoptLbl.bounds;
        maskLayer1.path = maskPath1.CGPath;
        adoptLbl.layer.mask = maskLayer1;

        [headImage addSubview:adoptLbl];
        
        
        UILabel *titleLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kHexColor(@"#666666") font:13.0];
        titleLab.frame = CGRectMake(5, headImage.yy + 8, (SCREEN_WIDTH - 30)/2 - 10, 0);
        titleLab.numberOfLines = 2;
        titleLab.text = @"刁主席记载重的下姜村桥头以及樟树";
        [titleLab sizeToFit];
        [backView addSubview:titleLab];
        
        
        UILabel *priceLabel = [UILabel labelWithFrame:CGRectMake(5, headImage.yy + 48, 0, 16) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kRedColor];
        NSString *str= @"¥ 5000.00";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSFontAttributeName value:FONT(11) range:NSMakeRange(0, 1)];
        priceLabel.attributedText = attrStr;
        [priceLabel sizeToFit];
        priceLabel.frame = CGRectMake(5, headImage.yy + 48, priceLabel.width, 16);
//        priceLabel.backgroundColor = [UIColor yellowColor];
        [backView addSubview:priceLabel];
        
        
        UILabel *addressLabel = [UILabel labelWithFrame:CGRectMake(priceLabel.frame.size.width + 9, headImage.yy + 50, (SCREEN_WIDTH - 30)/2 - priceLabel.xx - 9, 14) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(11) textColor:RGB(153, 153, 153)];
        addressLabel.text = @"浙江省 杭州市";
        [backView addSubview:addressLabel];
        
    }
    return self;
}


//- (void)initSubviews{
//    self.contentImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 180)];
//    self.contentImage.contentMode = UIViewContentModeScaleToFill;
//    self.contentImage.image = kImage(@"baner1");
//    [self addSubview:self.contentImage];
//
//    self.statusButton = [UIButton buttonWithTitle:@"集体" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:14];
//    self.statusButton.frame = CGRectMake(0, 0, 40, 20);
//    self.statusButton.layer.cornerRadius = 3;
//    self.statusButton.clipsToBounds = YES;
//    [self.contentImage addSubview:self.statusButton];
//
//    self.owerButton = [UIButton buttonWithTitle:@"可认养" titleColor:kWhiteColor backgroundColor:[UIColor redColor] titleFont:14];
//    [self addSubview:self.owerButton];
//    self.owerButton.frame = CGRectMake(self.frame.size.width-60, self.contentImage.yy-30, 60, 20);
//    self.owerButton.layer.cornerRadius = 3;
//    self.owerButton.clipsToBounds = YES;


//    self.titleLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kBlackColor font:13.0];
//    [self addSubview:self.titleLab];
//    self.titleLab.frame = CGRectMake(0, self.contentImage.yy, self.bounds.size.width-20, 44);
//    self.titleLab.numberOfLines = 0;
//    self.titleLab.text = @"活了10000年的山间古树,100000年的古树";
//
//    self.contentLab = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(255, 69, 69) font:13.0];
//    [self addSubview:self.contentLab];
//
//    //    self.contentLab.frame = CGRectMake(0, self.titleLab.yy+10, self.bounds.size.width, 22);
//    self.contentLab.text = @"¥10000.00";
//    self.contentLab.textColor = [UIColor redColor];
//
//    self.nameLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:11.0];
//    [self addSubview:self.nameLab];
//
//    //    self.nameLab.frame = CGRectMake(self.contentLab.xx, self.titleLab.yy+10, self.frame.size.width/2, 22);
//    self.nameLab.font = [UIFont systemFontOfSize:13];
//    self.nameLab.text = @"浙江省 杭州市";
//    self.nameLab.textColor = RGB(153, 153, 153);
//    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left);
//        make.top.equalTo(self.titleLab.mas_bottom).offset(5);
//    }];
//    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.mas_right);
//        make.top.equalTo(self.contentLab.mas_top);
//    }];
//
//    self.nameprice = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:12.0];
//    [self addSubview:self.nameprice];
//
//
//
//}


@end
