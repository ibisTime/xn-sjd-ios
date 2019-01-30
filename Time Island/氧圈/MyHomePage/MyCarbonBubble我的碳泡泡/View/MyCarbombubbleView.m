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
        [self refresh];
        
        UIImageView *topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 111 - 64)];
        topView.backgroundColor = kTabbarColor;
        [self addSubview:topView];
        
        
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 160)];
        
        
        bgImage.image = kImage(@"余额-装饰");
        [self addSubview:bgImage];
        
        
        UILabel *currentLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kHexColor(@"#656565") font:13.0];
        currentLbl.frame = CGRectMake(0, 45, SCREEN_WIDTH - 30, 18.5);
        currentLbl.textAlignment = NSTextAlignmentCenter;
        currentLbl.text = @"碳泡泡数量";
        [bgImage addSubview:currentLbl];

        UILabel *amountLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:22.0];
        amountLbl.font = HGboldfont(24);
        amountLbl.frame = CGRectMake(0, currentLbl.yy + 8, SCREEN_WIDTH - 30, 30);
        amountLbl.textAlignment = NSTextAlignmentCenter;
//        amountLbl.text = @"2480";
        [bgImage addSubview:amountLbl];
        self.amountLbl = amountLbl;
        
    }
    return self;
}
-(void)refresh{
    TLNetworking * http1 = [[TLNetworking alloc]init];
    http1.code = @"802300";
    http1.parameters[@"userId"] = [TLUser user].userId;
    http1.parameters[@"start"] = @(1);
    http1.parameters[@"limit"] = @(10);
    [http1 postWithSuccess:^(id responseObject) {
        self.array = responseObject[@"data"][@"list"];
        for (int i = 0; i < 3; i ++) {
            float amount3 = [self.array[2][@"totalAmount"] floatValue] / 1000.00;
            NSString * str3 = [NSString stringWithFormat:@"%.2f",amount3];
            self.amountLbl.text = str3;
        }
    } failure:^(NSError *error) {
        
        
    }];
}
@end
