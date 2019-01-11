//
//  DonateFriendCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "DonateFriendCell.h"
#define HEIGHT 865/2
@implementation DonateFriendCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat WIDTH = (SCREEN_WIDTH - 30);
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH - 30, HEIGHT)];
        kViewRadius(backView, 7.5);
        backView.backgroundColor = kWhiteColor;
        [self addSubview:backView];
        
        UIImageView *topImage = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2 - 372/2/2, 18, 372/2, 42)];
        topImage.image = kImage(@"给好友捐赠");
        [backView addSubview:topImage];
        
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(20, topImage.yy + 23, WIDTH - 40, 16) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kTextBlack];
        nameLabel.numberOfLines = 0;
        nameLabel.attributedText = [UserModel ReturnsTheDistanceBetween:@"通过浇水可以把自己的碳泡泡赠送给对方；每天可以给同一个好友捐赠3次"];
        [nameLabel sizeToFit];
        [backView addSubview:nameLabel];
        
        
        
        
        UIImageView *promptBackImg = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2 - 380/2/2, 343/2, 380/2, 376/2)];
        promptBackImg.image = kImage(@"小树");
        [backView addSubview:promptBackImg];
        
        
        
    }
    return self;
}
@end
