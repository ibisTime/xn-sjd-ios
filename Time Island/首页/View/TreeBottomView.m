//
//  TreeBottomView.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/10.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TreeBottomView.h"
//Macro
#import "TLUIHeader.h"
#import "AppColorMacro.h"
#import "UIColor+theme.h"
//Category
#import "UIButton+EnLargeEdge.h"
#import "NSString+Extension.h"
#import "CoinUtil.h"
//V
#import <SDWebImage/UIImageView+WebCache.h>
@interface TreeBottomView()
@property (nonatomic, strong) UIButton *myButton;//推文
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *renYangButton;//价格
@end
@implementation TreeBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        
        [self initcustomView];
    }
    return self;
}

- (void)initcustomView
{
    
    
    self.myButton = [UIButton buttonWithTitle:@"我的" titleColor:kTextBlack backgroundColor:[UIColor whiteColor] titleFont:14];
    self.myButton.frame = CGRectMake(0, 0, kScreenWidth/4, 44);
    self.myButton.clipsToBounds = YES;
    self.myButton.tag = 100;
    [self addSubview:self.myButton];
    [self.myButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.shareButton = [UIButton buttonWithTitle:@"分享" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:14];
    self.shareButton.frame = CGRectMake(kScreenWidth/4, 0, kScreenWidth/4, 44);
    self.shareButton.clipsToBounds = YES;
    [self addSubview:self.shareButton];
    self.shareButton.tag = 101;
    [self.shareButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.renYangButton = [UIButton buttonWithTitle:@"申请认养" titleColor:kWhiteColor backgroundColor:[UIColor redColor] titleFont:14];
    self.renYangButton.frame = CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, 44);
    self.renYangButton.clipsToBounds = YES;
    [self addSubview:self.renYangButton];
    self.renYangButton.tag = 102;
    [self.renYangButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)buttonClick:(UIButton *)sender
{
    switch (sender.tag-100) {
        case 0:
            //点击我的
            break;
        case 1:
            //点击分享
            break;
        case 2:
            //点击认养
            break;
        default:
            break;
    }
    
    
}

@end
