//
//  MineVCCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MineVCCell.h"

@implementation MineVCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithfirstimage:(NSString *)firstimage title:(NSString *)title{
    
    if (self == [super init]) {
        UIImageView  *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 19, 17, 17)];
        img1.image = [UIImage imageNamed:firstimage];
        [self.contentView addSubview:img1];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(img1.xx + 7, 19, 200, 17)];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = title;
        label.font = FONT(15);
        [self.contentView addSubview:label];
        
        UIImageView  *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 6, 55/2 - 6, 6, 12)];
        img2.image = [UIImage imageNamed:@"跳转"];
        [self.contentView addSubview:img2];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 54, SCREEN_WIDTH - 30, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
    }
    return self;
}
@end
