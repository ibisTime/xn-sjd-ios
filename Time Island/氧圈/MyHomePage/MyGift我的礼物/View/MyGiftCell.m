//
//  MyGiftCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/15.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MyGiftCell.h"

@implementation MyGiftCell{
    UIImageView *iconImg;
    UILabel *nameLbl;
    UILabel *stateLbl;
    UILabel *timeLbl;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 100, 85)];
        iconImg.image = kImage(@"树 跟背景");
        kViewRadius(iconImg, 5);
        [self addSubview:iconImg];
        
        nameLbl = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 10, 15, SCREEN_WIDTH - iconImg.xx - 15 - 100, 21) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kTextBlack];
        nameLbl.text = @"礼物名称";
        [self addSubview:nameLbl];
        
        
        stateLbl = [UILabel labelWithFrame:CGRectMake(nameLbl.xx + 5, 17, SCREEN_WIDTH - nameLbl.xx - 5 - 15, 16.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#23AD8C")];
        stateLbl.text = @"待领取";
        [self addSubview:stateLbl];
        
        timeLbl = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 10, 167/2, SCREEN_WIDTH - iconImg.xx - 15 , 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
        timeLbl.text = @"2018.01.11";
        [self addSubview:timeLbl];
        
        
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 114, SCREEN_WIDTH - 30, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
    }
    return self;
}
-(void)setModel:(GiftModel *)model{
    [iconImg sd_setImageWithURL:[NSURL URLWithString:[model.listPic convertImageUrl]]];
    nameLbl.text = model.name;
    stateLbl.text = @"已完成";
    timeLbl.text = [model.createDatetime convertToDetailDateWithoutHour];
}
@end
