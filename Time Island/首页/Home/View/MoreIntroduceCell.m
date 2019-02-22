//
//  MoreIntroduceCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MoreIntroduceCell.h"

@implementation MoreIntroduceCell
{
    UILabel * title;
    UILabel * time;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        title = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH / 2 - 15, 55) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(18) textColor:kTextBlack];
        title.text = @"测试";
        [self addSubview:title];
        
        time = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2 - 15, 55) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(15) textColor:kTextColor2];
        [self  addSubview:time];
        
        UIView * v = [[UIView alloc]initWithFrame:CGRectMake(15, 54, SCREEN_WIDTH - 30, 1)];
        v.backgroundColor = kLineColor;
        [self addSubview:v];
    }
    return self;
}
-(void)setModel:(IntroduceModel *)model{
    _model = model;
    NSLog(@"model.title %@",model.title);
    title.text = model.title;
    time.text = [model.createDatetime convertToDetailDate];
}


@end
