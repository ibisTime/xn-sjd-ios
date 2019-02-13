//
//  SubmitOrderAddressCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SubmitOrderAddressCell.h"
#import <Masonry.h>
@implementation SubmitOrderAddressCell
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
        _nameLbl = [UILabel labelWithFrame:CGRectMake(53, 15, kWidth(60) , 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:kBlackColor];
    }
    return _nameLbl;
}

-(UILabel *)phoneLbl{
    if(!_phoneLbl)
    {
        _phoneLbl = [UILabel labelWithFrame:CGRectMake(kWidth(85), 15, (SCREEN_WIDTH - 80)/2 , 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:kHexColor(@"#999999")];
    }
    return _phoneLbl;
}

-(UILabel *)addressLbl
{
    if(!_addressLbl)
    {
        _addressLbl = [UILabel labelWithFrame:CGRectMake(53,42, SCREEN_WIDTH - 80 , 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:kBlackColor];
        _addressLbl.numberOfLines = 0;

    }
    return _addressLbl;
}

-(UILabel *)backLabel
{
    if (!_backLabel) {
        _backLabel = [UILabel labelWithFrame:CGRectMake(53,0, SCREEN_WIDTH - 80 , 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:TextColor];
        _backLabel.text = @"请选择收货地址";
    }
    return _backLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self addSubview:self.nameLbl];
        [self addSubview:self.phoneLbl];
        [self addSubview:self.addressLbl];
        [self addSubview:self.addressImg];
        [self addSubview:self.backLabel];
      
        [self.addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.width.height.equalTo(@30);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        youImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 21, 50/2 - 5.5, 6, 11)];
        youImage.image = HGImage(@"积分更多");
        [self addSubview:youImage];

    }
    return self;
}

-(void)setModel:(AddressModel *)model
{
    _nameLbl.text = [NSString stringWithFormat:@"%@",model.addressee];
    [_nameLbl sizeToFit];
    _nameLbl.frame = CGRectMake(53, 15, _nameLbl.width , 15);
    _phoneLbl.text = model.mobile;
_phoneLbl.frame = CGRectMake(_nameLbl.xx + 10, 15, SCREEN_WIDTH - _nameLbl.xx - 36 , 15);
    _addressLbl.text = [NSString stringWithFormat:@"%@ %@ %@ %@",model.province,model.city,model.district,model.detailAddress];
    _addressLbl.frame = CGRectMake(53,_nameLbl.yy+10, SCREEN_WIDTH - 80 , 15);
//    [_addressLbl sizeToFit];
    youImage.frame = CGRectMake(SCREEN_WIDTH - 21, 70/2 - 5.5, 6, 11);
//    _addressImg.frame = CGRectMake(15,(self.height-30)/2, 30, 30);
     [self layoutIfNeeded];

}

@end
