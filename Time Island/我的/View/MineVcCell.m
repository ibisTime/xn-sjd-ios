//
//  MineVcCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/9.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MineVcCell.h"
#define ScreenWidth self.contentView.bounds.size.width
#define ScreenHeight self.contentView.bounds.size.height
@implementation MineVcCell
-(instancetype)initWithfirstimage:(NSString *)firstimage title:(NSString *)title lastimage:(NSString *)lastimage{
    if (self == [super init]) {
        UIImageView  *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 34, 34)];
        img1.image = [UIImage imageNamed:firstimage];
        [self.contentView addSubview:img1];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(50, 25, 100, 25)];
        label.text = title;
        [self.contentView addSubview:label];
        
        UIImageView  *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-34, 0, 34, 34)];
        img2.image = [UIImage imageNamed:lastimage];
        [self.contentView addSubview:img2];
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
