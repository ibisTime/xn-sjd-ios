//
//  ToObtainABubbleCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "ToObtainABubbleCell.h"
#define HEIGHT 967/2
@implementation ToObtainABubbleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat WIDTH = (SCREEN_WIDTH - 30);
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH - 30, HEIGHT)];
        kViewRadius(backView, 7.5);
        backView.backgroundColor = kWhiteColor;
        [self addSubview:backView];
        
        UIImageView *topImage = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2 - 372/2/2, 18, 372/2, 42)];
        topImage.image = kImage(@"获取碳泡泡绝招");
        [backView addSubview:topImage];
        
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(20, topImage.yy + 27, WIDTH - 40, 16) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kTextBlack];
        nameLabel.text = @"你的以下行为，可以获得碳泡泡。";
        [backView addSubview:nameLabel];
        
        UILabel *detailsLabel = [UILabel labelWithFrame:CGRectMake(20, nameLabel.yy + 7, WIDTH - 40, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
        detailsLabel.numberOfLines = 0;
        detailsLabel.text = @"（北京环交所，大自然保护协会等提供碳减排，碳汇量科学算法）";
        [detailsLabel sizeToFit];
        [backView addSubview:detailsLabel];
        
        NSArray *iconArray = @[@"行走捐",@"共享单车",@"线下支付",@"绿色办公"];
        NSArray *detailsArray = @[@"行走捐赠",@"限ofo,哈罗单车",@"支持收款码",@"钉钉绿色办公"];
        for (int i = 0; i < 4; i ++) {
            UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(20 + i % 2 * (WIDTH-40)/2, detailsLabel.yy + 25 + i/2*146/2, 106/2, 106/2)];
            iconImg.image = kImage(iconArray[i]);
            [backView addSubview:iconImg];
            
            UILabel *iconNameLbl = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 10, iconImg.y + 3, (WIDTH-40)/2 - 10 - 106/2 - 5, 106/2/2 - 3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(14) textColor:kTextBlack];
            iconNameLbl.text = iconArray[i];
            [backView addSubview:iconNameLbl];
            
            UILabel *iconDetailsLbl = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 10, iconNameLbl.yy, (WIDTH-40)/2 - 10 - 106/2, 106/2/2 - 3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#999999")];
            iconDetailsLbl.text = detailsArray[i];
            [backView addSubview:iconDetailsLbl];
            
        }
        
        
        UIImageView *promptBackImg = [[UIImageView alloc]initWithFrame:CGRectMake(21, 618/2, WIDTH - 42, 135)];
        promptBackImg.image = kImage(@"提醒背景");
        [backView addSubview:promptBackImg];
        
        UIImageView *promptImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 17, 17)];
        promptImg.image = kImage(@"小提醒");
        [promptBackImg addSubview:promptImg];
        
        UILabel *promptLbl = [UILabel labelWithFrame:CGRectMake(promptImg.xx + 6, 15, WIDTH - 42 - promptImg.xx - 16, 17) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#666666")];
        promptLbl.text = @"小提醒";
        [promptBackImg addSubview:promptLbl];
        
        UILabel *promptDetailsLbl = [UILabel labelWithFrame:CGRectMake(15, promptLbl.yy + 15, WIDTH - 42 - 30, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#666666")];
        promptDetailsLbl.numberOfLines = 0;
        promptDetailsLbl.attributedText = [UserModel ReturnsTheDistanceBetween:@"碳泡泡积蓄需要时间，完成上述行为后，记得第二天来收集碳泡泡。告诉你个小秘密，睡觉前打开步行数据，步行能量会更准确哦～"];
        [promptDetailsLbl sizeToFit];
        [promptBackImg addSubview:promptDetailsLbl];
        
    }
    return self;
}

@end
