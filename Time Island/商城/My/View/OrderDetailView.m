//
//  OrderDetailView.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "OrderDetailView.h"
#import <Masonry.h>

@implementation OrderDetailView
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
        _nameLbl = [UILabel labelWithFrame:CGRectMake(15, 25, kWidth(80) , 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:kTextColor];
        _nameLbl.text = @"订单信息";
    }
    return _nameLbl;
}
-(UILabel *)nameContentLbl
{
    if(!_nameContentLbl)
    {
        _nameContentLbl = [UILabel labelWithFrame:CGRectMake(kWidth(135), _nameLbl.yy+21,kScreenWidth-kWidth(180) , 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:kTextColor2];
    }
    return _nameContentLbl;
}

-(UILabel *)phoneLbl{
    if(!_phoneLbl)
    {
        _phoneLbl = [UILabel labelWithFrame:CGRectMake(15, _nameLbl.yy+21, 80 , 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:kTextColor];
        _phoneLbl.text = @"订单号";

    }
    return _phoneLbl;
}
-(UILabel *)phoneContentLbl{
    if(!_phoneContentLbl)
    {
        _phoneContentLbl = [UILabel labelWithFrame:CGRectMake(kWidth(105), _nameLbl.yy+21, (SCREEN_WIDTH - 80)/2 , 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:kTextColor2];
    }
    return _phoneContentLbl;
}
-(UILabel *)addressLbl
{
    if(!_addressLbl)
    {
        _addressLbl = [UILabel labelWithFrame:CGRectMake(15,_phoneLbl.yy+15, kWidth(80) , 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:kTextColor];
        _addressLbl.text = @"订单金额";

        _addressLbl.numberOfLines = 0;
        
    }
    return _addressLbl;
}
-(UILabel *)addressContentLbl
{
    if(!_addressContentLbl)
    {
        _addressContentLbl = [UILabel labelWithFrame:CGRectMake(kWidth(105),_phoneLbl.yy+15, (SCREEN_WIDTH - 80)/2 , 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:kTextColor2];
        _addressContentLbl.numberOfLines = 0;
        
    }
    return _addressContentLbl;
}
-(UILabel *)backLabel
{
    if (!_backLabel) {
        _backLabel = [UILabel labelWithFrame:CGRectMake(15,_addressLbl.yy+15, kWidth(80) , 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:TextColor];
        _backLabel.text = @"卖家";
    }
    return _backLabel;
}
-(UILabel *)backContentLabel
{
    if (!_backContentLabel) {
        _backContentLabel = [UILabel labelWithFrame:CGRectMake(kWidth(105),_addressLbl.yy+15, (SCREEN_WIDTH - 80)/2 , 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:kTextColor2];
        _backContentLabel.text = @"";
    }
    return _backContentLabel;
}
-(UILabel *)payCodeLbl
{
    if (!_payCodeLbl) {
        _payCodeLbl = [UILabel labelWithFrame:CGRectMake(15,_backLabel.yy+15, kWidth(80) , 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:TextColor];
        _payCodeLbl.text = @"支付流水号";
    }
    return _payCodeLbl;
}
-(UILabel *)payCodeContentLbl
{
    if (!_payCodeContentLbl) {
        _payCodeContentLbl = [UILabel labelWithFrame:CGRectMake(kWidth(105),_backLabel.yy+15, (SCREEN_WIDTH - 80)/2 , 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:kTextColor2];
    }
    return _payCodeContentLbl;
}
-(instancetype)initWithFrame:(CGRect)frame{
    {
        if (self == [super initWithFrame:frame]) {
            self.backgroundColor = kWhiteColor;
            [self addSubview:self.nameLbl];
            [self addSubview:self.phoneLbl];
            [self addSubview:self.addressLbl];
//            [self addSubview:self.addressImg];
            [self addSubview:self.backLabel];
            [self addSubview:self.nameContentLbl];
            [self addSubview:self.phoneContentLbl];
            [self addSubview:self.addressContentLbl];
            [self addSubview:self.backContentLabel];
            [self addSubview:self.payCodeLbl];
            [self addSubview:self.payCodeContentLbl];
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
            line.backgroundColor = kLineColor;
            [self addSubview:line];
            UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.payCodeLbl.yy+20, kScreenWidth, 0.5)];
            line1.backgroundColor = kLineColor;
            [self addSubview:line1];
            NSArray *titleArray = @[@"查看物流",@"申请售后",@"确认收货"];
            for (int i = 0; i < 3; i++) {
                UIButton *btn = [UIButton buttonWithTitle:titleArray[i] titleColor:kTextColor2 backgroundColor:kClearColor titleFont:12 cornerRadius:2];
              
                CGFloat btnW = (kScreenWidth-105-45)/3;
                btn.frame = CGRectMake(btnW*(i+1)+i*15, line1.yy+10, btnW, 28);
                [self addSubview:btn];
                btn.layer.borderWidth = 1;
                btn.layer.borderColor = kLineColor.CGColor;
                if (i == 2) {
                    btn.layer.borderWidth = 1;
                    btn.layer.borderColor = kSJDMainTextColor.CGColor;
                      [btn setTitleColor:kSJDMainTextColor forState:UIControlStateNormal];
                }
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = i+1000;
                
            }
    
        }
        return self;
    }
}

- (void)btnClick:(UIButton*)btn
{
    btn.selected = !btn.selected;
    if (self.clickBtnBlock) {
        self.clickBtnBlock(btn.tag-1000);
    }
//    NSInteger inter = btn.tag - 1000;
//    for (UIButton *bt in self.subviews) {
//        bt.layer.borderWidth = 1;
//        bt.layer.borderColor = kLineColor.CGColor;
//
//    }
//    btn.layer.borderWidth = 1;
//    btn.layer.borderColor = kSJDMainTextColor.CGColor;
}
@end
