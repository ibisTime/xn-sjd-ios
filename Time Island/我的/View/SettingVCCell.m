//
//  SettingVCCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "SettingVCCell.h"

@implementation SettingVCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithtitle:(NSString *)title{
    if (self == [super init]) {
        
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 17, 100, 22.5)];
        label.font = FONT(16);
        label.text = title;
        [self.contentView addSubview:label];
        
        UIImageView  *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 6, 55/2 - 6, 6, 12)];
        img2.image = [UIImage imageNamed:@"跳转"];
        [self.contentView addSubview:img2];
        
    }
    return self;
}

@end
