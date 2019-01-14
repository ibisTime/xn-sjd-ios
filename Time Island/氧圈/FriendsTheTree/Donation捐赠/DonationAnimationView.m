//
//  DonationAnimationView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "DonationAnimationView.h"

@implementation DonationAnimationView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, 45, 40)];
        image.image = kImage(@"捐赠");
        [self addSubview:image];
        
        UILabel *numberLbl = [UILabel labelWithFrame:CGRectMake(0, image.y - 30, 45, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#F04F30")];
        numberLbl.text = @"+10g";
        [self addSubview:numberLbl];
        
    }
    return self;
}

@end
