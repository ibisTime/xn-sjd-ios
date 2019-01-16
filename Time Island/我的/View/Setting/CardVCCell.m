//
//  CardVCCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "CardVCCell.h"

@implementation CardVCCell
-(instancetype)init{
    if (self == [super init]) {
        self.backgroundColor = [UIColor grayColor];
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
                 imagestring:(NSString *)imagestring
                  logostring:(NSString *)logostring
                    cardname:(NSString *)cardname
                     cardnum:(NSString *)cardnum{
    if (self == [super init]) {
        UIImageView * image = [[UIImageView alloc]initWithFrame:self.bounds];
        image.image = kImage(imagestring);
        [self addSubview:image];
        
        UIImageView * image1 = [[UIImageView alloc]initWithFrame:CGRectMake(24, 24, 40, 40)];
        image1.backgroundColor = [UIColor whiteColor];
        image1.layer.cornerRadius = 20;
        image1.layer.masksToBounds = YES;
        image1.image = kImage(logostring);
        [self addSubview:image1];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(image1.right+12, 24, 150, 32)];
        label.text = cardname;
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:label];
        
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(label.x, label.yy + 1, 36, 16.5)];
        NSString * str1;
        NSString * str2;
        if (cardnum.length == 16) {
            label1.text = @"储蓄卡";
            str1 = @"****  ****  ****  ";
            str2 = [cardnum substringFromIndex:11];
        }
        else if (cardnum.length == 19){
            label1.text = @"借记卡";
            str1 = @"****  ****  ****  ";
            str2 = [cardnum substringFromIndex:15];
        }
        
        label1.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        label1.textColor = [UIColor whiteColor];
        label1.textAlignment = NSTextAlignmentLeft;
        
        UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, label1.yy + 40, SCREEN_WIDTH, 34)];
//        NSString * str1 = @"****  ****  ****  ";
        NSString * str3 = [str1 stringByAppendingString:str2];
        label2.text = str3;
        label2.font = [UIFont fontWithName:@"PingFangSC-Regular" size:24];
        label2.textColor = [UIColor whiteColor];
        label2.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label1];
        [self addSubview:label2];
    }
    return self;
}
@end
