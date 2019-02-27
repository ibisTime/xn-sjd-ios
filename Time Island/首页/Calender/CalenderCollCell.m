//
//  CalenderCollCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/2/27.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "CalenderCollCell.h"

@implementation CalenderCollCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _timeLbl = [UILabel labelWithFrame:CGRectMake((SCREEN_WIDTH - 30)/7/2 - 15, (SCREEN_WIDTH - 30)/7/2 - 15, 30, 30) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(13) textColor:TextColor];
//        kViewBorderRadius(_timeLbl, 15, <#Width#>, <#Color#>)
        kViewRadius(_timeLbl, 15);
        [self addSubview:_timeLbl];
    }
    return self;
}

@end
