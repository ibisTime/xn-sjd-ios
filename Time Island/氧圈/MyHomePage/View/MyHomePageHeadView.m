//
//  MyHomePageHeadView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/10.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MyHomePageHeadView.h"
#define WIDTH SCREEN_WIDTH * 0.75
@implementation MyHomePageHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.75/2 - 65/2, 55, 65, 65)];
        headImage.image = kImage(@"头像");
        [self addSubview:headImage];
        
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(0, headImage.yy + 17, WIDTH, 16) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(16) textColor:kTextBlack];
        nameLabel.text = @"KOALA";
        [self addSubview:nameLabel];
        
        
    }
    return self;
}

@end
