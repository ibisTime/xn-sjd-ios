//
//  BalanceCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/11.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BalanceCell.h"

@implementation BalanceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 21, 33, 33)];
        iconImg.image = kImage(@"支出");
        [self addSubview:iconImg];
        self.iconImg = iconImg;
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 15, 17, SCREEN_WIDTH - iconImg.xx - 15 - 100, 18.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kTextBlack];
        nameLbl.text = @"某种方式的支出";
        [self addSubview:nameLbl];
        self.nameLbl = nameLbl;
        
        UILabel *timeLbl = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 15, nameLbl.yy + 7.5, SCREEN_WIDTH - iconImg.xx - 15 - 100, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(11) textColor:kHexColor(@"#999999")];
        timeLbl.text = @"今天  12:00";
        [self addSubview:timeLbl];
        self.timeLbl = timeLbl;
        
        UILabel *numberLbl = [UILabel labelWithFrame:CGRectMake(nameLbl.xx + 5, 17, SCREEN_WIDTH - nameLbl.xx - 5 - 15, 18.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(15) textColor:kTextBlack];
        numberLbl.text = @"+100";
        [self addSubview:numberLbl];
        self.numberLbl = numberLbl;
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 74, SCREEN_WIDTH - 30, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
    }
    return self;
}
-(void)setCarbonModel:(CarbonModel *)CarbonModel{
    self.nameLbl.text = CarbonModel.bizNote;
    float amount3 = [CarbonModel.transAmountString floatValue] / 1000.00;
    NSString * str3 = [NSString stringWithFormat:@"%.2f",amount3];
    self.numberLbl.text = str3;
    self.timeLbl.text = [CarbonModel.createDatetime convertToDetailDate];
}

@end
