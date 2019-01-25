//
//  OrderAddressView.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "OrderAddressView.h"
#import <Masonry.h>
@interface OrderAddressView()

@end
@implementation OrderAddressView
{
    UIImageView *youImage;
}

-(UIImageView *)addressImg
{
    if(!_addressImg)
    {
        _addressImg = [[UIImageView alloc] init];
        _addressImg.image = HGImage(@"地址");
    }
    return _addressImg;
}

-(UILabel *)nameLbl
{
    if(!_nameLbl)
    {
        _nameLbl = [UILabel labelWithFrame:CGRectMake(50, 25, kWidth(80) , 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:kTextColor];
    }
    return _nameLbl;
}

-(UILabel *)phoneLbl{
    if(!_phoneLbl)
    {
        _phoneLbl = [UILabel labelWithFrame:CGRectMake(kWidth(100), 25, (SCREEN_WIDTH - 80)/2 , 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:kTextColor2];
    }
    return _phoneLbl;
}

-(UILabel *)addressLbl
{
    if(!_addressLbl)
    {
        _addressLbl = [UILabel labelWithFrame:CGRectMake(50,60, SCREEN_WIDTH - 80 , 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:kTextColor];
        _addressLbl.numberOfLines = 0;
        
    }
    return _addressLbl;
}

-(UILabel *)backLabel
{
    if (!_backLabel) {
        _backLabel = [UILabel labelWithFrame:CGRectMake(50,0, SCREEN_WIDTH - 80 , 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:TextColor];
        _backLabel.text = @"";
    }
    return _backLabel;
}

-(instancetype)initWithFrame:(CGRect)frame{
{
    if (self == [super initWithFrame:frame]) {
        [self addSubview:self.nameLbl];
        [self addSubview:self.phoneLbl];
        [self addSubview:self.addressLbl];
        [self addSubview:self.addressImg];
        [self addSubview:self.backLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        line.backgroundColor = kLineColor;
        [self addSubview:line];
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight(88), kScreenWidth, 10)];
        line1.backgroundColor = kLineColor;
        [self addSubview:line1];
        [self.addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.width.height.equalTo(@30);
            make.centerY.equalTo(self.mas_centerY);
        }];
        youImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 21, 98/2 - 5.5, 6, 11)];
        youImage.image = HGImage(@"积分更多");
        [self addSubview:youImage];
    }
    return self;
}


}

@end
