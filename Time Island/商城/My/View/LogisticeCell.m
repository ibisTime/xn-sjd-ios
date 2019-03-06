//
//  LogisticeCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/6.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "LogisticeCell.h"

@implementation LogisticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.circle = [[UIView alloc]initWithFrame:CGRectMake(15, 15, 10, 10)];
        kViewRadius(self.circle, 5);
        self.circle.backgroundColor = kLineColor;
        [self addSubview:self.circle];
        
        self.line = [[UIView alloc]initWithFrame:CGRectMake(20, self.circle.yy, 1, 80)];
        self.line.backgroundColor = kLineColor;
        [self addSubview:self.line];
        
        self.contentLab = [UILabel labelWithFrame:CGRectMake(35, 0, SCREEN_WIDTH - 45, 60) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kBlackColor];
        self.contentLab.numberOfLines = 3;
        
        [self addSubview:self.contentLab];
        
        self.timeLab = [UILabel labelWithFrame:CGRectMake(35, 60, SCREEN_WIDTH - 45, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:RGB(145, 145, 145)];
        [self addSubview:self.timeLab];
    }
    return self;
}
@end
