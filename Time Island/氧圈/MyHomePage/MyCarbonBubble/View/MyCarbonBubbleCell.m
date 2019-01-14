//
//  MyCarbonBubbleCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MyCarbonBubbleCell.h"

@implementation MyCarbonBubbleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 21, 33, 33)];
        iconImg.image = kImage(@"收益");
        [self addSubview:iconImg];
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 15, 17, SCREEN_WIDTH - iconImg.xx - 15 - 100, 18.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kTextBlack];
        nameLbl.text = @"某种方式的支出";
        [self addSubview:nameLbl];
        
        UILabel *timeLbl = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 15, nameLbl.yy + 7.5, SCREEN_WIDTH - iconImg.xx - 15 - 100, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(11) textColor:kHexColor(@"#999999")];
        timeLbl.text = @"今天  12:00";
        [self addSubview:timeLbl];
        
        
        UILabel *numberLbl = [UILabel labelWithFrame:CGRectMake(nameLbl.xx + 5, 17, SCREEN_WIDTH - nameLbl.xx - 5 - 15, 18.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(15) textColor:kTextBlack];
        numberLbl.text = @"+100";
        [self addSubview:numberLbl];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 74, SCREEN_WIDTH - 30, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
    }
    return self;
}

@end
