//
//  RankingCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "RankingCell.h"

@implementation RankingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _numberImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 20, 20, 25)];
        [self addSubview:_numberImg];
        
        _numberLbl = [UILabel labelWithFrame:CGRectMake(5, 20, 40, 25) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(14) textColor:kTextBlack];
        [self addSubview:_numberLbl];
        
        
        UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(95/2, 12.5, 40, 40)];
        headImg.image = kImage(@"头像");
        [self addSubview:headImg];
        
        
        UIButton *nameBtn = [UIButton buttonWithTitle:@"庭院深深" titleColor:kTextBlack backgroundColor:kClearColor titleFont:14];
        
        nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        nameBtn.frame = CGRectMake(headImg.xx + 10, 14, SCREEN_WIDTH - headImg.xx - 10 - 70, 17);
        [nameBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:6 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(@"收  取") forState:(UIControlStateNormal)];
        }];
        
        [self addSubview:nameBtn];
        
        UILabel *cerNumberLbl = [UILabel labelWithFrame:CGRectMake(headImg.xx + 10, nameBtn.yy + 7 - 1.5, SCREEN_WIDTH - headImg.xx - 10 - 70, 13) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#999999")];
        cerNumberLbl.text = @"获得了7个环保证书";
        [self addSubview:cerNumberLbl];
        
        UILabel *kgLabel = [UILabel labelWithFrame:CGRectMake(nameBtn.xx + 5 , 0, SCREEN_WIDTH - nameBtn.xx - 5 - 15, 65) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(14) textColor:kTextBlack];
        kgLabel.text = @"14.6kg";
        [self addSubview:kgLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 64, SCREEN_WIDTH - 30, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
    }
    return self;
}

@end
