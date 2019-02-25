//
//  RulesCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/21.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "RulesCell.h"

@implementation RulesCell{
    UILabel * title;
    UILabel * count;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        title = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH * 2 / 3 - 15, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kTextBlack];
        title.text = @"产生项";
        [self addSubview:title];
        
        count = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH * 2 / 3, 0, SCREEN_WIDTH / 3 - 15, 50) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(15) textColor:kTextBlack];
        count.text = @"分值项";
        [self addSubview:count];
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(15, 50, SCREEN_WIDTH - 30, 1)];
        view.backgroundColor = kLineColor;
        [self addSubview:view];
        
    }
    return self;
}
-(void)setRulesModel:(RulesModel *)RulesModel{
    title.text = RulesModel.remark;
    count.text = RulesModel.cvalue;
}
@end
