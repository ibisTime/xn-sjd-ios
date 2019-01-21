//
//  RenYangFieldView.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/11.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "RenYangFieldView.h"
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

@interface RenYangFieldView()
@property (nonatomic, strong) UIView *content;

@property (nonatomic, strong) UIButton *statusButton;//推文
@property (nonatomic, strong) UILabel *infoTitle;
@property (nonatomic, strong) UILabel *priceLable;//价格
@property (nonatomic, strong) UILabel *addressLab;//地址
@end
@implementation RenYangFieldView
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.content = [[UIView alloc] init];
        self.content.frame = CGRectMake(0, 300, kScreenWidth, kScreenHeight-300);
        [self addSubview:self.content];
        self.content.backgroundColor = kWhiteColor;
//        [self initcustomView];
    }
    return self;
}

- (void)initcustomView
{
    self.content = [UIView new];
    self.content.frame = CGRectMake(0, 300, kScreenWidth, kScreenHeight-300);
    [self addSubview:self.content];
    self.content.backgroundColor = kBlackColor;

    self.statusButton = [UIButton buttonWithTitle:@"集体" titleColor:kWhiteColor backgroundColor:[UIColor redColor] titleFont:14];
    self.statusButton.frame = CGRectMake(15, 15, 32, 13);
    self.statusButton.layer.cornerRadius = 5;
    self.statusButton.clipsToBounds = YES;
    [self.content addSubview:self.statusButton];
    
    self.infoTitle = [UILabel labelWithBackgroundColor:kWhiteColor textColor:RGB(0, 0, 0) font:15.0];
    [self.infoTitle setFont:[UIFont boldSystemFontOfSize:15]];
    [self.content addSubview:self.infoTitle];
    self.infoTitle.frame = CGRectMake(60, 5, self.bounds.size.width-80, 44);
    self.infoTitle.numberOfLines = 0;
    self.infoTitle.text = @"活了10000年的山间古树,100000年的古树,古树撒可敬的考拉胜利大街拉伸基多拉";
    self.priceLable = [UILabel labelWithBackgroundColor:kWhiteColor textColor:RGB(255, 69, 69) font:18.0];
    [self.content addSubview:self.priceLable];
    self.priceLable.frame = CGRectMake(10, self.infoTitle.yy+15, kScreenWidth-120, 30);
    
    self.priceLable.text = @"¥10000.00";
    self.priceLable.textColor = [UIColor redColor];
    
    self.addressLab = [UILabel labelWithBackgroundColor:kWhiteColor textColor:RGB(153, 153, 153) font:11.0];
    [self.content addSubview:self.addressLab];
    self.addressLab.frame = CGRectMake(kScreenWidth-120, self.infoTitle.yy+15, 120, 30);
    self.addressLab.font = [UIFont systemFontOfSize:13];
    self.addressLab.text = @"浙江省 杭州市";
    self.addressLab.textColor = kTextColor2;
    
    
}
@end
