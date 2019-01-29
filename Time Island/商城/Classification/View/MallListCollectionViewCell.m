//
//  MallListCollectionViewCell.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallListCollectionViewCell.h"
@interface MallListCollectionViewCell()
@property (nonatomic ,strong) UIImageView *headImage;

@property (nonatomic ,strong)  UILabel *titleLab;

@property (nonatomic ,strong)  UILabel *statusLbl;

@property (nonatomic ,strong)  UILabel *priceLabel;

@property (nonatomic ,strong)  UILabel *addressLabel;


@end
@implementation MallListCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = RGB(236, 236, 236).CGColor;
        UIView *backView = [[UIView alloc]init];
        backView.frame = self.bounds;
        self.backView = backView;
        //        backView.backgroundColor = [UIColor redColor];
        [self addSubview:backView];
        
        
        UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 45)/2, kHeight(115))];
        headImage.image = kImage(@"我的背景");
        [backView addSubview:headImage];
        self.headImage = headImage;
        

        
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
        self.titleLab = titleLab;
        UILabel *statusLbl = [UILabel labelWithFrame:CGRectMake(5, titleLab.yy+10, 60, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(9) textColor:kRedColor];
        kViewRadius(statusLbl, 2);
        statusLbl.text = @"公益宝贝";
        statusLbl.layer.borderWidth = 1;
        statusLbl.layer.borderColor = kRedColor.CGColor;
//        [statusLbl sizeToFit];
        [backView addSubview:statusLbl];
        self.statusLbl = statusLbl;
        UILabel *priceLabel = [UILabel labelWithFrame:CGRectMake(5, statusLbl.yy + 15, 0, 16) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kRedColor];
        NSString *str= @"¥5000.00";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSFontAttributeName value:FONT(14) range:NSMakeRange(0, 1)];
        priceLabel.attributedText = attrStr;
        [priceLabel sizeToFit];
        priceLabel.frame = CGRectMake(5, statusLbl.yy + 15, priceLabel.width, 16);
        //        priceLabel.backgroundColor = [UIColor yellowColor];
        [backView addSubview:priceLabel];
        self.priceLabel = priceLabel;
        [priceLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
        UIButton *shopping = [UIButton buttonWithImageName:@"购物车"];
        shopping.frame = CGRectMake(self.size.width-30, priceLabel.yy, 30, 30);
        shopping.centerY = priceLabel.centerY;
        [backView addSubview:shopping];
        self.shopping = shopping;
        
        UILabel *addressLabel = [UILabel labelWithFrame:CGRectMake(priceLabel.frame.size.width + 9, titleLab.yy + 10, (SCREEN_WIDTH - 30)/2 - priceLabel.xx - 9, 14) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(11) textColor:RGB(153, 153, 153)];
        addressLabel.text = @"杭州市";
        [backView addSubview:addressLabel];
        addressLabel.centerY = statusLbl.centerY;
        self.addressLabel = addressLabel;
    }
    return self;
}

-(void)setModel:(MallTreeModel *)model
{
    _model = model;
    self.titleLab.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.originalPrice];
//    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self.priceLabel.text];
//    [attrStr addAttribute:NSFontAttributeName value:FONT(13) range:NSMakeRange(0, 2)];
//    self.priceLabel.attributedText = attrStr;
    [self.priceLabel sizeToFit];
    self.addressLabel.text = model.originPlace;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[model.listPic convertImageUrl]]];
    self.shopping.centerY = self.priceLabel.centerY;

}

@end
