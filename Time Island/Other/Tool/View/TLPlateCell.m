//
//  TLPlateCell.m
//  ljs
//
//  Created by shaojianfei on 2018/6/18.
//  Copyright © 2018年 caizhuoyue. All rights reserved.
//

#import "TLPlateCell.h"
#import "UILabel+Extension.h"
#import "UILable+convience.h"
#import "AppColorMacro.h"
#import <Masonry.h>
#import "UIButton+Custom.h"
#import "UIView+Frame.h"
@interface TLPlateCell()

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *contentLab;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UILabel *nameprice;

@property (nonatomic, strong) UIImageView *contentImage;

@property (nonatomic, strong) UIButton *owerButton;

@property (nonatomic, strong) UIButton *statusButton;


@end
@implementation TLPlateCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
        [self initLayout];
    }
    return self;

}
- (void)initSubviews
{
    self.contentImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 180)];
    self.contentImage.contentMode = UIViewContentModeScaleToFill;
    self.contentImage.image = kImage(@"baner1");
    [self addSubview:self.contentImage];

    self.statusButton = [UIButton buttonWithTitle:@"集体" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:14];
    self.statusButton.frame = CGRectMake(0, 0, 40, 20);
    self.statusButton.layer.cornerRadius = 3;
    self.statusButton.clipsToBounds = YES;
    [self.contentImage addSubview:self.statusButton];
    
    self.owerButton = [UIButton buttonWithTitle:@"可认养" titleColor:kWhiteColor backgroundColor:[UIColor redColor] titleFont:14];
    [self addSubview:self.owerButton];
    self.owerButton.frame = CGRectMake(self.frame.size.width-60, self.contentImage.yy-30, 60, 20);
    self.owerButton.layer.cornerRadius = 3;
    self.owerButton.clipsToBounds = YES;
    self.titleLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:14.0];
    [self addSubview:self.titleLab];
    self.titleLab.frame = CGRectMake(0, self.contentImage.yy, self.bounds.size.width, 44);
    self.titleLab.numberOfLines = 0;
    self.titleLab.text = @"活了10000年的山间古树,100000年的古树";
    
    self.contentLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:14.0];
    [self addSubview:self.contentLab];
    
//    self.contentLab.frame = CGRectMake(0, self.titleLab.yy+10, self.bounds.size.width, 22);
    self.contentLab.text = @"¥10000.00";
    self.contentLab.textColor = [UIColor redColor];
    
    self.nameLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:12.0];
    [self addSubview:self.nameLab];
    
//    self.nameLab.frame = CGRectMake(self.contentLab.xx, self.titleLab.yy+10, self.frame.size.width/2, 22);
    self.nameLab.font = [UIFont systemFontOfSize:13];
    self.nameLab.text = @"浙江省 杭州市";
    self.nameLab.textColor = kTextColor2;
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.titleLab.mas_bottom).offset(5);
    }];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.contentLab.mas_top);
    }];

    self.nameprice = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:12.0];
    [self addSubview:self.nameprice];
    
    
    
}
- (void)initLayout
{
    
    
//    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.mas_centerX);
//        make.top.equalTo(@5);
//    }];
//    [self.nameprice mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.nameLab.mas_right).offset(5);
//        make.top.equalTo(self.contentLab.mas_bottom).offset(5);
//    }];
}

-(void)setModel:(PlateMineModel *)model
{
 
    _model = model;
//    self.titleLab.text = model.name;
//    CGFloat f =  [model.avgChange floatValue]*100;
//    if (f > 0) {
//        self.contentLab.text = [NSString stringWithFormat:@"+%.2f%%",[model.avgChange doubleValue]*100];
//
//        self.contentLab.textColor = kRiseColor;
//    }else
//    {
//        self.contentLab.text = [NSString stringWithFormat:@"%.2f%%",[model.avgChange doubleValue]*100];
//        self.contentLab.textColor = kTextColor;
//
//    }
//    self.nameLab.text = model.bestSymbol;
//    CGFloat pricef = [model.bestChange floatValue]*100;
//    if (pricef > 0) {
//        self.nameprice.text = [NSString stringWithFormat:@"+%.2f%%",[model.bestChange floatValue]*100];
//
//        self.nameprice.textColor = kRiseColor;
//
//    }else
//    {
//        self.nameprice.text = [NSString stringWithFormat:@"%.2f%%",[model.bestChange floatValue]*100];
//        self.nameprice.textColor = kTextColor;
//
//        }
//
}
@end
