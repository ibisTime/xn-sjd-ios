//
//  BuyCountCell.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/24.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BuyCountCell.h"

@implementation BuyCountCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.nameLbl = [UILabel labelWithFrame:CGRectMake(15, 20, kWidth(120), 22) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(13) textColor:kTextColor];
    [self addSubview:self.nameLbl];
    
    self.minButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.minButton.frame = CGRectMake(kScreenWidth-100+5, 20, 18, 18);
    [self.minButton setBackgroundImage:kImage(@"减") forState:UIControlStateNormal];
    [self addSubview:self.minButton];
    [self.minButton addTarget:self action:@selector(minButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.countLbl = [UILabel labelWithFrame:CGRectMake(kScreenWidth-100+25, 20, 22, 22) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(12) textColor:kTextColor];
    self.minButton.centerY = self.nameLbl.centerY;

    self.countLbl.text = @"1";
    self.countLbl.centerY = self.nameLbl.centerY;
    [self addSubview:self.countLbl];
    self.MaxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.MaxButton.frame = CGRectMake(kScreenWidth-100+40+15, 20, 18, 18);
    [self.MaxButton setBackgroundImage:kImage(@"加") forState:UIControlStateNormal];
    [self addSubview:self.MaxButton];
    self.MaxButton.centerY = self.nameLbl.centerY;

    [self.MaxButton addTarget:self action:@selector(maxButtonClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)minButtonClick
{
    NSInteger inter = [self.countLbl.text integerValue];
    if (inter == 0) {
        return;
    }
    inter--;
    self.countLbl.text = [NSString stringWithFormat:@"%ld",inter];
}
- (void)maxButtonClick
{
    NSInteger inter = [self.countLbl.text integerValue];
    inter++;
    self.countLbl.text = [NSString stringWithFormat:@"%ld",inter];
}
-(void)setCount:(NSString *)count
{
    _count = [count copy];
    
    self.countLbl.text = [NSString stringWithFormat:@"%@",count];

    self.nameLbl.text = @"购买数量";
}
@end
