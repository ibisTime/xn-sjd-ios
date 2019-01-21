//
//  GoodsDetailsInfomationCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/21.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "GoodsDetailsInfomationCell.h"

@implementation GoodsDetailsInfomationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 14) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kTextBlack];
        nameLbl.text = @"          碳泡泡积蓄需要时间，完成上述行为后，记得第二天来收集碳泡泡。";
        nameLbl.numberOfLines = 2;
        [nameLbl sizeToFit];
        [self addSubview:nameLbl];
        
        UILabel *TheLabel = [UILabel labelWithFrame:CGRectMake(15, 10, 32, 14) textAligment:(NSTextAlignmentCenter) backgroundColor:kRedColor font:FONT(11) textColor:kWhiteColor];
        TheLabel.text = @"个人";
        [self addSubview:TheLabel];
        kViewRadius(TheLabel, 7);
        
        UILabel *priceLabel = [UILabel labelWithFrame:CGRectMake(15, 55, 0, 16) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kRedColor];
        NSString *str= @"¥ 5000.00";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSFontAttributeName value:FONT(11) range:NSMakeRange(0, 1)];
        priceLabel.attributedText = attrStr;
        [priceLabel sizeToFit];
        priceLabel.frame = CGRectMake(15, 55, priceLabel.width, 18);
        //        priceLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:priceLabel];
        
        
        UILabel *addressLabel = [UILabel labelWithFrame:CGRectMake(priceLabel.frame.size.width + 9, 57, SCREEN_WIDTH - priceLabel.xx - 15, 14) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(11) textColor:RGB(153, 153, 153)];
        addressLabel.text = @"浙江省 杭州市";
        [self addSubview:addressLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 8)];
        lineView.backgroundColor = RGB(244, 244, 244);
        [self addSubview:lineView];
        
        UIView *progressBottomView = [[UIView alloc]initWithFrame:CGRectMake(15, 110, SCREEN_WIDTH - 15 - 60, 5)];
        progressBottomView.backgroundColor = RGB(244, 244, 244);
        kViewRadius(progressBottomView, 2.5);
        [self addSubview:progressBottomView];
        
        UIView *progressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2 , 5)];
        progressView.backgroundColor = kRedColor;
        kViewRadius(progressView, 2.5);
        [progressBottomView addSubview:progressView];
        
        
        
        UILabel *numberLbl = [UILabel labelWithFrame:CGRectMake(progressBottomView.xx + 10, progressBottomView.y - 5, 40, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kTextBlack];
        numberLbl.text = @"50%";
        [self addSubview:numberLbl];
        
        
        NSArray *targetName = @[@"目标份数/份",@"已募集份数/份"];
        NSArray *targetNumber = @[@"200",@"124"];
        for (int i = 0; i < 2; i ++) {
            UILabel *targetNameLbl = [UILabel labelWithFrame:CGRectMake(50 + i % 2 * (SCREEN_WIDTH - 100)/2, numberLbl.yy + 10, (SCREEN_WIDTH - 100)/2, 11) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(11) textColor:RGB(153, 153, 153)];
            targetNameLbl.text = targetName[i];
            [self addSubview:targetNameLbl];
            
            
            UILabel *targetNumberLbl = [UILabel labelWithFrame:CGRectMake(50 + i % 2 * (SCREEN_WIDTH - 100)/2, targetNameLbl.yy + 5, (SCREEN_WIDTH - 100)/2, 13) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(13) textColor:kTextBlack];
            targetNumberLbl.text = targetNumber[i];
            [self addSubview:targetNumberLbl];
            
        }
        
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 172, SCREEN_WIDTH, 8)];
        lineView1.backgroundColor = RGB(244, 244, 244);
        [self addSubview:lineView1];
        
    }
    return self;
}



@end
