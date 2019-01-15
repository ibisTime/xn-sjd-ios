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
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(41, 17, 100, 25)];
        label.text = title;
        [self.contentView addSubview:label];
        
        UIImageView  *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 6, 55/2 - 6, 6, 12)];
        img2.image = [UIImage imageNamed:@"跳转"];
        [self.contentView addSubview:img2];
        
    }
    return self;
}
@end
