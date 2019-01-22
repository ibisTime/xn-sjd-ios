//
//  MallListCollectionViewCell.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallListCollectionViewCell.h"

@implementation MallListCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIView *backView = [[UIView alloc]init];
        self.backView = backView;
        //        backView.backgroundColor = [UIColor redColor];
        [self addSubview:backView];
        
        
        UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 15, (SCREEN_WIDTH - 45)/2, kHeight(115))];
        headImage.image = kImage(@"我的背景");
        [backView addSubview:headImage];
        
        

        
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:statusLbl.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(6,6)];//圆角大小
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        maskLayer.frame = statusLbl.bounds;
//        maskLayer.path = maskPath.CGPath;
//        statusLbl.layer.mask = maskLayer;
//
//        [headImage addSubview:statusLbl];
//
//        UILabel *adoptLbl = [UILabel labelWithFrame:CGRectMake((SCREEN_WIDTH - 30)/2 - 55, (SCREEN_WIDTH - 30)/2 - 36, 55, 18) textAligment:(NSTextAlignmentCenter) backgroundColor:RGB(234, 85, 78) font:FONT(11) textColor:kWhiteColor];
//        adoptLbl.text = @"不可认养";
//
//        UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:adoptLbl.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(4,4)];//圆角大小
//        CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
//        maskLayer1.frame = adoptLbl.bounds;
//        maskLayer1.path = maskPath1.CGPath;
//        adoptLbl.layer.mask = maskLayer1;
//
//        [headImage addSubview:adoptLbl];
        
        
        UILabel *titleLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kBlackColor font:15.0];
        titleLab.frame = CGRectMake(5, headImage.yy + 8, (SCREEN_WIDTH - 30)/2 - 10, 0);
        titleLab.numberOfLines = 2;
        titleLab.text = @"商品古树商品古树商品古树古树商品古树古树商品古树";
        [titleLab sizeToFit];
        [backView addSubview:titleLab];
        
        UILabel *statusLbl = [UILabel labelWithFrame:CGRectMake(5, titleLab.yy+10, 200, 18) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(10) textColor:kRedColor];
        kViewRadius(statusLbl, 2);
        statusLbl.text = @"公益宝贝";
        statusLbl.layer.borderWidth = 1;
        statusLbl.layer.borderColor = kRedColor.CGColor;
        [statusLbl sizeToFit];
        [backView addSubview:statusLbl];
        UILabel *priceLabel = [UILabel labelWithFrame:CGRectMake(5, statusLbl.yy + 10, 0, 16) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kRedColor];
        NSString *str= @"¥5000.00";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSFontAttributeName value:FONT(11) range:NSMakeRange(0, 1)];
        priceLabel.attributedText = attrStr;
        [priceLabel sizeToFit];
        priceLabel.frame = CGRectMake(5, statusLbl.yy + 10, priceLabel.width, 16);
        //        priceLabel.backgroundColor = [UIColor yellowColor];
        [backView addSubview:priceLabel];
        UIButton *shopping = [UIButton buttonWithImageName:@"购物车"];
        shopping.frame = CGRectMake(self.size.width-50, headImage.yy + 50, 30, 30);
        shopping.centerY = priceLabel.centerY;
        [backView addSubview:shopping];

        
        UILabel *addressLabel = [UILabel labelWithFrame:CGRectMake(priceLabel.frame.size.width + 9, titleLab.yy + 10, (SCREEN_WIDTH - 30)/2 - priceLabel.xx - 9, 14) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(11) textColor:RGB(153, 153, 153)];
        addressLabel.text = @"杭州市";
        [backView addSubview:addressLabel];
        addressLabel.centerY = statusLbl.centerY;
    }
    return self;
}



@end
