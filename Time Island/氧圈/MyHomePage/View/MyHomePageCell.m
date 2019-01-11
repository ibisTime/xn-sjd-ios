//
//  MyHomePageCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/10.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MyHomePageCell.h"

@implementation MyHomePageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 18.5, 17, 17)];
        self.iconImage = iconImage;
        [self addSubview:iconImage];
        
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(iconImage.xx + 8, 18.5, SCREEN_WIDTH * 0.75 - iconImage.xx - 10, 17) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kTextBlack];
        self.nameLabel = nameLabel;
        [self addSubview:nameLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 54, SCREEN_WIDTH*0.75 - 20, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
        
    }
    return self;
}

@end
