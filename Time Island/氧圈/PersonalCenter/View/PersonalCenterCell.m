//
//  PersonalCenterCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/2/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "PersonalCenterCell.h"

@implementation PersonalCenterCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _nameLable = [UILabel labelWithFrame:CGRectMake(15, 15, 100, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kTextBlack];
        [self addSubview:_nameLable];
        
        _timeLbl = [UILabel labelWithFrame:CGRectMake(115, 15, SCREEN_WIDTH - 115 - 40, 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#999999")];
        [self addSubview:_timeLbl];
        
        
        _addressLable = [UILabel labelWithFrame:CGRectMake(15, 35, (SCREEN_WIDTH - 55)/2, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
        [self addSubview:_addressLable];
        
        _promptLbl = [UILabel labelWithFrame:CGRectMake(_addressLable.xx, 35, (SCREEN_WIDTH - 55)/2, 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
        [self addSubview:_promptLbl];
        
        
        UIImageView *youImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 22, 70/2 - 6, 7, 12)];
        youImage.image = kImage(@"跳转");
        [self addSubview:youImage];
        
        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(15, 69, SCREEN_WIDTH - 30, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
    }
    return self;
}

-(void)setModels:(PersonalCenterModel *)models
{
    _nameLable.text = models.tree[@"productName"];
    _timeLbl.text = [NSString stringWithFormat:@"%@-%@",[models.startDatetime convertDate],[models.endDatetime convertDate]];
    _addressLable.text = [NSString stringWithFormat:@"%@ %@",models.tree[@"city"],models.tree[@"area"]];
    
    NSString *prompt1 = @"还剩余";
    NSString *time = @"14";
    NSString *prompt2 = @"天认养到期";
    NSString *promptAll = [NSString stringWithFormat:@"%@%@%@",prompt1,time,prompt2];
   
    NSMutableAttributedString *poundageAttrStr = [[NSMutableAttributedString alloc] initWithString:promptAll];
    [poundageAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(prompt1.length,time.length)];
    _promptLbl.attributedText = poundageAttrStr;
}

@end
