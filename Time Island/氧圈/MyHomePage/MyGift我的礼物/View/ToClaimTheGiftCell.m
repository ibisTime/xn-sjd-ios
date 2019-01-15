//
//  ToClaimTheGiftCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/15.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "ToClaimTheGiftCell.h"

@implementation ToClaimTheGiftCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [ super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *topImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeight(200))];
        topImg.image = kImage(@"树 跟背景");
        [self addSubview:topImg];
        
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, kHeight(200), SCREEN_WIDTH - 15 - 100, 55) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(17) textColor:kTextBlack];
        nameLabel.text = @"樟子松";
        [self addSubview:nameLabel];
        
        UILabel *priceLabel = [UILabel labelWithFrame:CGRectMake(nameLabel.xx + 5, kHeight(200), SCREEN_WIDTH - 15 - nameLabel.xx, 55) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#23AD8C")];
        priceLabel.text = @"¥1245.00";
        [self addSubview:priceLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, kHeight(200) + 54, SCREEN_WIDTH - 30, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
    }
    return self;
}

@end
