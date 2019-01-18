//
//  CardVCCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/17.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "CardVCCell.h"

@implementation CardVCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //背景图片
        self.BackgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 13.5, SCREEN_WIDTH - 30, 160)];
        [self addSubview:self.BackgroundImage];
        
        //Logo
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(39, 37.5, 40, 40)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 20;
        view.layer.masksToBounds = YES;
        self.LogoImage = [[UIImageView alloc]initWithFrame:CGRectMake(8.5, 8.5, 23, 23)];
        [view addSubview:self.LogoImage];
        [self addSubview:view];
        
        //银行名称
        self.CardName= [[UILabel alloc]initWithFrame:CGRectMake(view.xx + 12, 24, SCREEN_WIDTH - 105, 32)];
        self.CardName.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        self.CardName.textColor = [UIColor whiteColor];
        self.CardName.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.CardName];
        
        //银行类型
        self.CardType = [[UILabel alloc]initWithFrame:CGRectMake(self.CardName.x, self.CardName.yy + 1, 36, 16.5)];
        self.CardType.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        self.CardType.textColor = [UIColor whiteColor];
        self.CardType.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.CardType];
        
        
        //银行卡号
        self.CardCount = [[UILabel alloc]initWithFrame:CGRectMake(66, self.CardType.yy + 40, SCREEN_WIDTH - 120, 33.5)];
        self.CardCount.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:24];
        self.CardCount.textColor = [UIColor whiteColor];
        self.CardCount.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.CardCount];
        
    }
    return self;
}

@end
