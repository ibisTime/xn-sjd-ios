//
//  ShopCartSubmitOrderGoodsCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/8.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "ShopCartSubmitOrderGoodsCell.h"

@interface ShopCartSubmitOrderGoodsCell()
@property (nonatomic,strong) UIImageView * goodsimg;
@property (nonatomic,strong) UILabel * namelab;
@property (nonatomic,strong) UILabel * sizelab;
@property (nonatomic,strong) UILabel * pricelab;
@property (nonatomic,strong) UILabel * countlab;


@end


@implementation ShopCartSubmitOrderGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.goodsimg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 75, 75)];
        kViewRadius(self.goodsimg, 4);
        [self addSubview:self.goodsimg];
        
        self.namelab = [UILabel labelWithFrame:CGRectMake(self.goodsimg.xx + 15, self.goodsimg.y, SCREEN_WIDTH - self.goodsimg.xx, self.goodsimg.height / 3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(14) textColor:kBlackColor];
        [self addSubview:self.namelab];
        
        self.sizelab = [UILabel labelWithFrame:CGRectMake(self.goodsimg.xx + 15, self.namelab.yy, SCREEN_WIDTH - self.goodsimg.xx, self.goodsimg.height / 3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kTextColor3];
        [self addSubview:self.sizelab];
        
        self.pricelab = [UILabel labelWithFrame:CGRectMake(self.goodsimg.xx + 15, self.sizelab.yy, SCREEN_WIDTH - self.goodsimg.xx, self.goodsimg.height / 3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(14) textColor:kBlackColor];
        [self addSubview:self.pricelab];
        
    }
    return self;
}
-(void)setProductModel:(JVShopcartProductModel *)ProductModel{
    _ProductModel = ProductModel;
    [self.goodsimg sd_setImageWithURL:[NSURL URLWithString:[ProductModel.commodityPhoto convertImageUrl]] placeholderImage:kImage(@"树 跟背景")];
    self.namelab.text = ProductModel.commodityName;
    [self.namelab sizeToFit];
    self.sizelab.text = [NSString stringWithFormat:@"规格分类：%@",ProductModel.specsName];
    self.pricelab.text = [NSString stringWithFormat:@"¥%.2f",[ProductModel.amount floatValue]/1000];
}
@end
