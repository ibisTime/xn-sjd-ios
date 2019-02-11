//
//  MallListCollectionViewCell.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallListCollectionViewCell.h"
#define WIDTH (SCREEN_WIDTH - 45)/2/330
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
        
//        self.layer.borderWidth = 1;
//        self.layer.borderColor = RGB(236, 236, 236).CGColor;
        
        
        UIView *backView = [[UIView alloc]init];
        backView.frame = self.bounds;
        kViewRadius(backView, 4);
        kViewBorderRadius(backView, 4, 1, kHexColor(@"#E6E6E6"));
        self.backView = backView;
        //        backView.backgroundColor = [UIColor redColor];
        [self addSubview:backView];
        
        
        UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 45)/2, WIDTH*230)];
        headImage.image = kImage(@"我的背景");
        [backView addSubview:headImage];
        kViewRadius(headImage, 4);
        headImage.backgroundColor = kBackgroundColor;
        self.headImage = headImage;
        

        
        
        UILabel *titleLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kBlackColor font:15.0];
        titleLab.frame = CGRectMake(10, headImage.yy + 10, (SCREEN_WIDTH - 45)/2 - 20, 0);

        [backView addSubview:titleLab];
        self.titleLab = titleLab;
        
        
        UILabel *statusLbl = [UILabel labelWithFrame:CGRectMake(10, headImage.yy + 57, 55, 18) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(11) textColor:kHexColor(@"#F05D41")];
        kViewRadius(statusLbl, 2);
        statusLbl.layer.borderWidth = 1;
        statusLbl.layer.borderColor = kHexColor(@"#F05D41").CGColor;
        [backView addSubview:statusLbl];
        self.statusLbl = statusLbl;
        
        
        UILabel *addressLabel = [UILabel labelWithFrame:CGRectMake(statusLbl.xx, headImage.yy + 57, (SCREEN_WIDTH - 45)/2 - statusLbl.xx - 10, 18) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(11) textColor:RGB(153, 153, 153)];
//        addressLabel.text = @"杭州市";
        [backView addSubview:addressLabel];
//        addressLabel.centerY = statusLbl.centerY;
        self.addressLabel = addressLabel;
        
        UILabel *priceLabel = [UILabel labelWithFrame:CGRectMake(10, headImage.yy + 85, 0, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kHexColor(@"#F68646")];

        [backView addSubview:priceLabel];
        self.priceLabel = priceLabel;
        
        UIButton *shopping = [UIButton buttonWithImageName:@"购物车"];
        shopping.frame = CGRectMake(self.size.width-25, headImage.yy + 85, 15, 15);
        [backView addSubview:shopping];
        self.shopping = shopping;
        
        
    }
    return self;
}

-(void)setModel:(MallTreeModel *)model
{
    _model = model;
    self.titleLab.text = model.name;
//    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.originalPrice];
    _titleLab.numberOfLines = 2;
    [_titleLab sizeToFit];
    
    self.statusLbl.text = [NSString stringWithFormat:@"月销 %@",model.monthSellCount];
    [self.statusLbl sizeToFit];
    self.statusLbl.frame = CGRectMake(10, _headImage.yy + 55, self.statusLbl.width + 10, 22);
    NSString *str= [NSString stringWithFormat:@"¥%@",model.originalPrice];
    
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSFontAttributeName value:FONT(11) range:NSMakeRange(0, 1)];
    _priceLabel.attributedText = attrStr;
    [_priceLabel sizeToFit];
    _priceLabel.frame = CGRectMake(10, _headImage.yy + 85, _priceLabel.width, 15);
    
    [self.priceLabel sizeToFit];
    
    self.addressLabel.text = model.originalPlace;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[model.listPic convertImageUrl]]];
    self.shopping.centerY = self.priceLabel.centerY;

}

@end
