//
//  ShopCartPayCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/8.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "ShopCartPayCell.h"
@interface ShopCartPayCell()
@property (nonatomic,strong) UIImageView * goodsimg;
@property (nonatomic,strong) UILabel * namelab;
@property (nonatomic,strong) UILabel * countlab;
@property (nonatomic,strong) UILabel * sizelab;
@property (nonatomic,strong) UILabel * pricelab;
@end
@implementation ShopCartPayCell

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
        [self addSubview:self.goodsimg];
        
        self.namelab = [UILabel labelWithFrame:CGRectMake(self.goodsimg.xx + 15, self.goodsimg.y, SCREEN_WIDTH - 200, 25) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(15) textColor:kBlackColor];
        [self addSubview:self.namelab];
        
        self.countlab = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 120, self.goodsimg.y, 100, 25) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(13) textColor:kTextColor2];
        [self addSubview:self.countlab];
        
        self.sizelab = [UILabel labelWithFrame:CGRectMake(self.goodsimg.xx + 15, self.goodsimg.yy - 25, SCREEN_WIDTH - 200, 25) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kTextColor2];
        [self addSubview:self.sizelab];
        
        self.pricelab = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 120, self.goodsimg.yy - 25, 100, 25) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(13) textColor:kTextColor2];
        [self addSubview:self.pricelab];
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15, 109, SCREEN_WIDTH - 30, 1)];
        v1.backgroundColor = kLineColor;
        [self addSubview:v1];
        
    }
    return self;
}
-(void)setModel:(commodityOrderDetailModel *)model{
    [self.goodsimg sd_setImageWithURL:[NSURL URLWithString:[model.listPic convertImageUrl]] placeholderImage:kImage(@"树 和背景")];
    self.namelab.text = model.specsName;
    self.sizelab.text = [NSString stringWithFormat:@"规格分类：%@",model.commodityName];
    self.countlab.text = [NSString stringWithFormat:@"x %@",model.quantity];
    self.pricelab.text = [NSString stringWithFormat:@"¥%.2f",[model.price floatValue]/1000];
}
@end
