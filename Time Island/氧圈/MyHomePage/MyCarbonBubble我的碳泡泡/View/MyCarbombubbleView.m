//
//  MyCarbombubbleView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MyCarbombubbleView.h"

@implementation MyCarbombubbleView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 111 - 64)];
        topView.backgroundColor = kTabbarColor;
        [self addSubview:topView];
        
        
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 160)];
        
        
        bgImage.image = kImage(@"余额-装饰");
//        bgImage.contentMode = UIViewContentModeScaleToFill;
//        bgImage.layer.cornerRadius=5;
//        bgImage.layer.shadowOpacity = 0.22;// 阴影透明度
//        bgImage.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
//        bgImage.layer.shadowRadius=3;// 阴影扩散的范围控制
//        bgImage.layer.shadowOffset=CGSizeMake(1, 1);// 阴影的范围
        [self addSubview:bgImage];
        
        
        UILabel *currentLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kHexColor(@"#656565") font:13.0];
        currentLbl.frame = CGRectMake(0, 45, SCREEN_WIDTH - 30, 18.5);
        currentLbl.textAlignment = NSTextAlignmentCenter;
        currentLbl.text = @"当前积分";
        [bgImage addSubview:currentLbl];

        UILabel *amountLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:22.0];
        amountLbl.font = HGboldfont(24);
        amountLbl.frame = CGRectMake(0, currentLbl.yy + 8, SCREEN_WIDTH - 30, 30);
        amountLbl.textAlignment = NSTextAlignmentCenter;
        amountLbl.text = @"2480";
        [bgImage addSubview:amountLbl];
        
    }
    return self;
}

@end
