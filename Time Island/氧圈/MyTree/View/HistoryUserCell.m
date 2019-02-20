//
//  HistoryUserCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/20.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "HistoryUserCell.h"

@implementation HistoryUserCell{
    UIImageView * headimg;
    UILabel * namelab;
    UILabel * timelab;
    UILabel * pricelab;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        headimg = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 45, 45)];
        kViewRadius(headimg, 22.5);
        [self addSubview:headimg];
        
        namelab = [UILabel labelWithFrame:CGRectMake(headimg.xx + 10, headimg.y, SCREEN_WIDTH / 2, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kBlackColor];
        [self addSubview:namelab];
        
        timelab = [UILabel labelWithFrame:CGRectMake(headimg.xx + 10, namelab.yy + 10, SCREEN_WIDTH / 2, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kTextColor3];
        [self addSubview:timelab];
        
        pricelab = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - pricelab.width, 55 / 3 , pricelab.width, 55 / 3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kTabbarColor];
        [self addSubview:pricelab];
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(15, 54, SCREEN_WIDTH - 30, 1)];
        view.backgroundColor = kLineColor;
        [self addSubview:view];
    }
    return self;
}
-(void)setPersonalCenterModel:(PersonalCenterModel *)PersonalCenterModel{
    [headimg sd_setImageWithURL:[NSURL URLWithString:[PersonalCenterModel.user[@"photo"] convertImageUrl]] placeholderImage:kImage(@"头像")];
    
    if (PersonalCenterModel.user[@"nickname"]) {
        namelab.text = PersonalCenterModel.user[@"nickname"];
    }else{
        namelab.text = [PersonalCenterModel.user[@"loginName"] stringByReplacingOccurrencesOfString:[PersonalCenterModel.user[@"loginName"] substringWithRange:NSMakeRange(3,4)] withString:@" **** "];
    }
    [namelab sizeToFit];
    timelab.text = [PersonalCenterModel.startDatetime convertToDetailDateWithoutHour];
    
    
    pricelab.text = [NSString stringWithFormat:@"%.2f x%@",[PersonalCenterModel.amount floatValue] / 1000,PersonalCenterModel.userAdoptTreeCount];
    [pricelab sizeToFit];
    pricelab.frame = CGRectMake(SCREEN_WIDTH - pricelab.width - 15, 55 / 3 , pricelab.width, 55 / 3);
    
    
}

@end
