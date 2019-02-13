//
//  SubmitOrderGoodsCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SubmitOrderGoodsCell.h"

@implementation SubmitOrderGoodsCell

-(UIImageView *)goodsImage
{
    if(!_goodsImage)
    {
        _goodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 50, 75, 75)];
        kViewRadius(_goodsImage, 2);
    }
    return _goodsImage;
}

-(UILabel *)nameLabel
{
    if(!_nameLabel)
    {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(115, 50, SCREEN_WIDTH - 130, 0)  textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(15) textColor:[UIColor blackColor]];
//        _nameLabel.text = @"哈士大夫撒旦撒打飞机撒打发回家撒地方看哈士大夫撒旦撒打飞机撒打发回家撒地方看哈士大夫撒旦撒打飞机撒打发回家撒地方看";
        _nameLabel.numberOfLines = 2;


    }
    return _nameLabel;
}

-(UILabel *)introduceLabel
{
    if(!_introduceLabel)
    {
        _introduceLabel = [UILabel labelWithFrame:CGRectMake(117, 50 + 30, SCREEN_WIDTH - 152, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:kTextColor2];
        _introduceLabel.text = @"规格分类:";

    }
    return _introduceLabel;
}
-(UILabel *)shopLabel
{
    if(!_shopLabel)
    {
        _shopLabel = [UILabel labelWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 152, 17) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:kTextColor];
        //        _introduceLabel.text = @"沃尔沃 2014款 黑色";
        
    }
    return _shopLabel;
}

-(UILabel *)priceLabel
{
    if(!_priceLabel)
    {
        _priceLabel = [UILabel labelWithFrame:CGRectMake(117, 80+30, SCREEN_WIDTH - 117 - 65, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(15) textColor:kBlackColor];
         [_priceLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    }
    return _priceLabel;

}

-(UILabel *)numberLabel
{
    if(!_numberLabel)
    {
        _numberLabel = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 65, 50, 50, 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(12) textColor:kTextColor2];
//        _numberLabel.text = @"x1";
        _numberLabel.text = [NSString stringWithFormat:@"x%d",(int)self.count];
    }
    return _numberLabel;

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self addSubview:self.shopLabel];
        UIView *line = [UIView new];
        line.backgroundColor = kLineColor;
        line.frame = CGRectMake(0, self.shopLabel.yy+10, SCREEN_WIDTH, 0.5);
        [self addSubview:line];
        [self addSubview:self.goodsImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.introduceLabel];

        [self addSubview:self.priceLabel];
        [self addSubview:self.numberLabel];
//        self.nameLabel.text = [NSString stringWithFormat:@"x%d",(int)self.count];
    }
    return self;
}

-(void)setModel:(MallGoodsModel *)model
{
//    _goodsImage.image = kImage(@"我的背景");
    
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:[model.listPic convertImageUrl]] placeholderImage:kImage(@"我的背景")];
    _nameLabel.text = model.specsList[0][@"name"];
    _nameLabel.frame = CGRectMake(115, 50, SCREEN_WIDTH - 130, 0);
    _shopLabel.text = model.shopName;
    [_nameLabel sizeToFit];
 
    _nameLabel.text = model.specsList[0][@"name"];

    _priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[ model.specsList[self.selectnum][@"price"] floatValue]/1000];
    _nameLabel.frame = CGRectMake(115, 50, SCREEN_WIDTH - 130, 0);
    [_nameLabel sizeToFit];
    _introduceLabel.text = [NSString stringWithFormat:@"规格分类: %@",self.size];
    _introduceLabel.frame = CGRectMake(117, 50 +35, SCREEN_WIDTH - 152, 15);
    _numberLabel.text = [NSString stringWithFormat:@"x%d",(int)self.count];
    

}

-(void)setDic:(NSDictionary *)dic
{

    _priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[dic[@"price"] floatValue]/1000];
    _nameLabel.frame = CGRectMake(115, 50, SCREEN_WIDTH - 130, 0);
    [_nameLabel sizeToFit];
    _introduceLabel.frame = CGRectMake(117, 50 + _nameLabel.frame.size.height + 5, SCREEN_WIDTH - 152, 15);
    _introduceLabel.text = [NSString stringWithFormat:@"%@",dic[@"name"]];

}


@end
