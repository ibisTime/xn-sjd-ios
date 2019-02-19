//
//  EnergyCompeteCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "EnergyCompeteCell.h"

@implementation EnergyCompeteCell
{
    UIImageView *friendHeadImg;
    UILabel *friendNumberLabel;
    UIImageView *myHeadImg;
    UILabel *myNumberLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat y = kHeight(7.5);
        CGFloat height = kHeight(96.5) - kHeight(7.5);
        
        
        UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth(15), kHeight(140)/2 - kHeight(96.5)/2, SCREEN_WIDTH - kWidth(30), kHeight(96.5))];
        backImg.image = kImage(@"比拼");
        [self addSubview:backImg];
        
        
        UILabel *VSLabel = [UILabel labelWithFrame:CGRectMake(kWidth(295)/2, y, kWidth(50), height) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(38) textColor:kHexColor(@"#23AD8C")];
        VSLabel.text = @"VS";
        [backImg addSubview:VSLabel];
        
        
        friendHeadImg = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth(20), height/2 + y - kHeight(20), kHeight(40), kHeight(40))];
        friendHeadImg.image = kImage(@"保护罩小图");
        kViewRadius(friendHeadImg, kHeight(20));
        [backImg addSubview:friendHeadImg];
        
        
        UILabel *friendNameLabel = [UILabel labelWithFrame:CGRectMake(friendHeadImg.xx + 10, friendHeadImg.y + 3, kWidth(295)/2 - friendHeadImg.xx - 15, 12) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#333333")];
        friendNameLabel.text = @"TA收取你";
        [backImg addSubview:friendNameLabel];
        
        
        friendNumberLabel = [UILabel labelWithFrame:CGRectMake(friendHeadImg.xx + 10, friendHeadImg.yy - 22 - 3, kWidth(295)/2 - friendHeadImg.xx - 15, 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(19) textColor:kHexColor(@"#333333")];
        friendNumberLabel.text = @"22g";
        [backImg addSubview:friendNumberLabel];
        
        
        
        
        myHeadImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - kWidth(30) -kWidth(60), height/2 + y - kHeight(20), kHeight(40), kHeight(40))];
        myHeadImg.image = kImage(@"保护罩小图");
        kViewRadius(myHeadImg, kHeight(20));
        [backImg addSubview:myHeadImg];
        
        
        UILabel *myNameLabel = [UILabel labelWithFrame:CGRectMake(VSLabel.xx + 5, friendHeadImg.y + 3, kWidth(295)/2 - friendHeadImg.xx - 15, 12) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#CCCCCC")];
        myNameLabel.text = @"你收取TA";
        [backImg addSubview:myNameLabel];
        
        
        myNumberLabel = [UILabel labelWithFrame:CGRectMake(VSLabel.xx + 5, friendHeadImg.yy - 22 - 3, kWidth(295)/2 - friendHeadImg.xx - 15, 22) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(19) textColor:kHexColor(@"#CCCCCC")];
        myNumberLabel.text = @"1122g";
        [backImg addSubview:myNumberLabel];
        
        
    }
    return self;
}
-(void)setCompeteModel:(CompeteModel *)CompeteModel{
    
    [friendHeadImg sd_setImageWithURL:[NSURL URLWithString:[CompeteModel.toUserInfo[@"photo"] convertImageUrl]] placeholderImage:kImage(@"头像")];
    NSString * str =[NSString stringWithFormat:@"%.2f",[CompeteModel.toUserWeekQuantity floatValue] / 1000];
    friendNumberLabel.text = str;
    
    
    
    [myHeadImg sd_setImageWithURL: [NSURL URLWithString:[CompeteModel.userInfo[@"photo"] convertImageUrl]] placeholderImage:kImage(@"头像")];
    
    NSString * str1 =[NSString stringWithFormat:@"%.2f",[CompeteModel.userWeekQuantity floatValue] / 1000];
    myNumberLabel.text = str1;
}
@end
