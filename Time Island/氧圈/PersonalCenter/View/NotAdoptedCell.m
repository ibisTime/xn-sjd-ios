//
//  NotAdoptedCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/2/15.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "NotAdoptedCell.h"

@implementation NotAdoptedCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIButton *button = [UIButton buttonWithTitle:@"还没有认养树" titleColor:kHexColor(@"#999999") backgroundColor:kClearColor titleFont:14];
        button.frame = CGRectMake(0, 0, SCREEN_WIDTH, 140);
        [button SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:5 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(@"暂无订单") forState:(UIControlStateNormal)];
        }];
        [self addSubview:button];
        
        UIView *lineView= [[UIView alloc]initWithFrame:CGRectMake(0, 140, SCREEN_WIDTH, 10)];
        lineView.backgroundColor = kBackgroundColor;
        [self addSubview:lineView];
        
    }
    return self;
}

@end
