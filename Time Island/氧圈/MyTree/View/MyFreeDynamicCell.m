//
//  MyFreeDynamicCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/10.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MyFreeDynamicCell.h"

@implementation MyFreeDynamicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        for (int i = 0; i < 6; i ++) {
            UIButton *dynamicBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            dynamicBtn.frame = CGRectMake(SCREEN_WIDTH/6/2 - 20 + i%6*SCREEN_WIDTH/6, 15, 40, 40);
            [dynamicBtn setImage:kImage(@"头像") forState:(UIControlStateNormal)];
            [self addSubview:dynamicBtn];
            
            
            UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(26-2, 21 - 2, 22, 22)];
            bottomView.backgroundColor = kWhiteColor;
            kViewRadius(bottomView, 10);
            [dynamicBtn addSubview:bottomView];
            
            
            UILabel *numLbl = [UILabel labelWithFrame:CGRectMake(2, 2, 18, 18) textAligment:(NSTextAlignmentCenter) backgroundColor:kHexColor(@"#23AD8C") font:FONT(8) textColor:kWhiteColor];
            numLbl.text = @"5g";
            kViewRadius(numLbl, 9);
            [bottomView addSubview:numLbl];
            
        }
        
    }
    return self;
}

@end
