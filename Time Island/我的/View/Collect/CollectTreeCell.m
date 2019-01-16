//
//  CollectTreeCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "CollectTreeCell.h"

@implementation CollectTreeCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
    
}
- (void)initSubviews
{
    
//    self.layer.masksToBounds = YES;
//    self.layer.cornerRadius = 3;
//    self.layer.borderWidth = 1;
//    self.layer.shadowOffset = CGSizeMake(0, 1);
//    self.layer.shadowColor = kLineColor.CGColor;
//    self.layer.shadowOpacity = 0.1;
//    self.layer.shadowRadius = 4;
//    self.layer.masksToBounds = NO;

    kViewBorderRadius(self, 4, 1, kLineColor);
    
    self.contentImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 115)];
    self.contentImage.contentMode = UIViewContentModeScaleToFill;
    self.contentImage.image = kImage(@"baner1");
    [self addSubview:self.contentImage];
    
    self.statusButton = [UIButton buttonWithTitle:@"集体" titleColor:kWhiteColor backgroundColor:kBlackColor titleFont:12];
    self.statusButton.alpha = 0.5;
    self.statusButton.frame = CGRectMake(self.frame.size.width - 40, 0, 40, 20);
    self.statusButton.layer.cornerRadius = 4;
    self.statusButton.clipsToBounds = YES;
    [self.contentImage addSubview:self.statusButton];
    
    self.titleLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kBlackColor font:15.0];
    [self addSubview:self.titleLab];
    self.titleLab.frame = CGRectMake(10, self.contentImage.yy+10, 0, 21);
    self.titleLab.text = @"樟子松";
    [self.titleLab sizeToFit];
    if (self.titleLab.width > self.width - 36.5 - 6 - 5 - 10) {
        self.titleLab.frame = CGRectMake(10, self.contentImage.yy+10, self.width - 36.5 - 6 - 5 - 10, 21);
    }else
    {
        self.titleLab.frame = CGRectMake(10, self.contentImage.yy+10, self.titleLab.width, 21);
    }
    
    
    
    self.owerButton = [UIButton buttonWithTitle:@"待认养" titleColor:kHexColor(@"#23AD8C") backgroundColor:kClearColor titleFont:10];
//    [self.owerButton.layer setBorderWidth:2.0];
    [self.owerButton.layer setBorderColor:[UIColor colorWithHexString:@"#23AD8C"].CGColor];
    [self addSubview:self.owerButton];
//    kViewRadius(self.owerButton, 2);
    kViewBorderRadius(self.owerButton, 2, 1, kTabbarColor);
    
    self.owerButton.frame = CGRectMake(self.titleLab.xx + 6, self.contentImage.yy + 12.5, 36.5, 16);
//    self.owerButton.layer.cornerRadius = 2;
//    self.owerButton.clipsToBounds = YES;
    
    
    self.nameLab = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(153, 153, 153) font:12];
    self.nameLab.frame = CGRectMake(10, self.titleLab.yy+9.5, self.width - 94/2 - 10 - 5, 16.5);
//    self.nameLab.font = [UIFont systemFontOfSize:12];
    self.nameLab.text = @"四川 成都";
    self.nameLab.textColor = RGB(153, 153, 153);
    [self addSubview:self.nameLab];
//    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left);
//        make.top.equalTo(self.titleLab.mas_bottom).offset(5);
//    }];
//    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.mas_right);
//        make.top.equalTo(self.contentLab.mas_top);
//    }];

    self.companyImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 94/2, self.contentImage.yy + 41, 94/2 - 8.5, 16)];
    self.companyImage.contentMode = UIViewContentModeScaleToFill;
    self.companyImage.image = kImage(@"baner1");
    [self addSubview:self.companyImage];
    
    
    self.contentLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTabbarColor font:0];
    self.contentLab.font = HGboldfont(15);
    [self addSubview:self.contentLab];
    self.contentLab.frame = CGRectMake(10, self.nameLab.yy+8.5, self.bounds.size.width - 20, 15);
    self.contentLab.text = @"¥2480.00";

    
    
    
}
@end
