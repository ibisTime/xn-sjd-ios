//
//  ExpressView.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "ExpressView.h"
#import <Masonry.h>
@interface ExpressView()


@end
@implementation ExpressView

{
    UIImageView *youImage;
}

-(UIImageView *)addressImg
{
    if(!_addressImg)
    {
        _addressImg = [[UIImageView alloc] init];
        _addressImg.image = HGImage(@"我的背景");
    }
    return _addressImg;
}

-(UILabel *)nameLbl
{
    if(!_nameLbl)
    {
        _nameLbl = [UILabel labelWithFrame:CGRectMake(kWidth(100), 25, kWidth(80) , 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:kTextColor];
        _nameLbl.text = @"订单信息";
    }
    return _nameLbl;
}
-(UILabel *)nameContentLbl
{
    if(!_nameContentLbl)
    {
        _nameContentLbl = [UILabel labelWithFrame:CGRectMake(kWidth(135), _nameLbl.yy+21,kScreenWidth-kWidth(180) , 55/3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:kTextColor2];
    }
    return _nameContentLbl;
}

-(UILabel *)phoneLbl{
    if(!_phoneLbl)
    {
        _phoneLbl = [UILabel labelWithFrame:CGRectMake(kWidth(100), 15, 80 , 55/3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:kTextColor];
        _phoneLbl.text = @"物流状态:";
        
    }
    return _phoneLbl;
}
-(UILabel *)phoneContentLbl{
    if(!_phoneContentLbl)
    {
        _phoneContentLbl = [UILabel labelWithFrame:CGRectMake(kWidth(60)+kWidth(100), 15, (SCREEN_WIDTH - 80)/2 , 55/3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:RGB(68, 126, 233)];
    }
    return _phoneContentLbl;
}
-(UILabel *)addressLbl
{
    if(!_addressLbl)
    {
        _addressLbl = [UILabel labelWithFrame:CGRectMake(kWidth(100),_phoneLbl.yy+10, kWidth(80) , 55/3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:kTextColor];
        _addressLbl.text = @"承运方式:";
        
        _addressLbl.numberOfLines = 0;
        
    }
    return _addressLbl;
}
-(UILabel *)addressContentLbl
{
    if(!_addressContentLbl)
    {
        _addressContentLbl = [UILabel labelWithFrame:CGRectMake(kWidth(60)+kWidth(100),_phoneLbl.yy+12, (SCREEN_WIDTH - 80)/2 , 55/3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:kTextColor2];
        _addressContentLbl.numberOfLines = 0;
        
    }
    return _addressContentLbl;
}
-(UILabel *)backLabel
{
    if (!_backLabel) {
        _backLabel = [UILabel labelWithFrame:CGRectMake(kWidth(100),_addressLbl.yy+10, kWidth(80) , 55/3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:TextColor];
        _backLabel.text = @"订单编号:";
    }
    return _backLabel;
}
-(UILabel *)backContentLabel
{
    if (!_backContentLabel) {
        _backContentLabel = [UILabel labelWithFrame:CGRectMake(kWidth(60)+kWidth(100),_addressLbl.yy+12, (SCREEN_WIDTH - 80)/2 , 55/3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:kTextColor2];
        _backContentLabel.text = @"";
    }
    return _backContentLabel;
}
-(UILabel *)payCodeLbl
{
    if (!_payCodeLbl) {
        _payCodeLbl = [UILabel labelWithFrame:CGRectMake(kWidth(100),_backLabel.yy+15, kWidth(80) , 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:TextColor];
        _payCodeLbl.text = @"支付流水号";
    }
    return _payCodeLbl;
}
-(UILabel *)payCodeContentLbl
{
    if (!_payCodeContentLbl) {
        _payCodeContentLbl = [UILabel labelWithFrame:CGRectMake(kWidth(105)+kWidth(100),_backLabel.yy+15, (SCREEN_WIDTH - 80)/2 , 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:kTextColor2];
    }
    return _payCodeContentLbl;
}

-(instancetype)initWithFrame:(CGRect)frame{
    {
        if (self == [super initWithFrame:frame]) {
//            [self addSubview:self.nameLbl];
            self.backgroundColor = kWhiteColor;
            [self addSubview:self.phoneLbl];
            [self addSubview:self.addressLbl];
            [self addSubview:self.backLabel];
            [self addSubview:self.phoneContentLbl];
            [self addSubview:self.addressContentLbl];
            [self addSubview:self.backContentLabel];
            [self addSubview:self.addressImg];
            [self.addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@15);
                make.width.height.equalTo(@75);
                make.centerY.equalTo(self.mas_centerY);
            }];
            
            UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.backLabel.yy+20, kScreenWidth, 10)];
            line1.backgroundColor = kPaleGreyColor;
            [self addSubview:line1];
        }
        return self;
    }
    
    
}



@end
