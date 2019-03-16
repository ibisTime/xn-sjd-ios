//
//  YiceSlidelipPriceCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/11.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "YiceSlidelipPriceCell.h"

@implementation YiceSlidelipPriceCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UITextField * mintext = [[UITextField alloc]initWithFrame:CGRectMake(self.x + 15, 10, self.width / 2 - 30, 30)];
        mintext.layer.borderColor = kLineColor.CGColor;
        mintext.layer.borderWidth = 1;
        kViewRadius(mintext, 3);
        mintext.keyboardType = UIKeyboardTypeNumberPad;
        mintext.delegate = self;
        mintext.tag = 1;
        [self addSubview:mintext];
        
        UILabel * label = [UILabel labelWithFrame:CGRectMake(self.width / 2 - 10, 25, 10, 2.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(20) textColor:kBlackColor];
        label.text = @"——";
        [self addSubview:label];
        
        UITextField * maxtext = [[UITextField alloc]initWithFrame:CGRectMake(self.width / 2 + 10, 10, self.width / 2 - 30, 30)];
        maxtext.layer.borderColor = kLineColor.CGColor;
        maxtext.layer.borderWidth = 1;
        kViewRadius(maxtext, 3);
        maxtext.keyboardType = UIKeyboardTypeNumberPad;
        maxtext.delegate = self;
        maxtext.tag = 2;
        [self addSubview:maxtext];
    }
    return self;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    TLTextField * t1 = [self viewWithTag:1];
    TLTextField * t2 = [self viewWithTag:2];
    
    NSLog(@"t1=%@ t2=%@",t1.text,t2.text);
    
    if (t1.text.length || t2.text.length) {
        if (self.delegate) {
            [self.delegate returnMinPrice:t1.text MaxPrice:t2.text];
        }
    }
}

@end
