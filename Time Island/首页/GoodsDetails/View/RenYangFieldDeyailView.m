//
//  RenYangFieldDeyailView.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/11.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "RenYangFieldDeyailView.h"
//Macro
#import "TLUIHeader.h"
#import "AppColorMacro.h"
#import "UIColor+theme.h"
//Category
#import "UIButton+EnLargeEdge.h"
#import "NSString+Extension.h"
#import "CoinUtil.h"
#import "TLTextField.h"
//V
#import <SDWebImage/UIImageView+WebCache.h>
@interface RenYangFieldDeyailView()
@property (nonatomic, strong) UIView *content;
@property (nonatomic, strong) UIImageView *treeImage;

@property (nonatomic, strong) UIButton *statusButton;//推文
@property (nonatomic, strong) UILabel *infoTitle;
@property (nonatomic, strong) UILabel *priceLable;//价格
@property (nonatomic, strong) UILabel *addressLab;
@property (nonatomic, strong) UILabel *timeLable;//年份
@property (nonatomic, strong) UILabel *time2Lab;//年份
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UIButton *select2Button;

@property (nonatomic, strong) UIButton *sumButton;
@property (nonatomic, strong) UIButton *minButton;

@property (nonatomic, strong) UILabel *countLable;//个数

@property (nonatomic, strong) TLTextField *inputField;

@property (nonatomic, strong) UILabel *descLab;//描述

@property (nonatomic, strong) UIButton *sureButton;


@end
@implementation RenYangFieldDeyailView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initcustomView];
    }
    return self;
}

- (void)initcustomView
{
    self.content = [UIView new];
    self.content.frame = self.bounds;
    [self addSubview:self.content];
    self.content.backgroundColor = kWhiteColor;

    self.treeImage = [[UIImageView alloc] init];
    self.treeImage.contentMode = UIViewContentModeScaleToFill;
    self.treeImage.image = kImage(@"水源林");
    self.treeImage.frame = CGRectMake(20, -10, 80, 90);
    [self.content addSubview:self.treeImage];
    self.statusButton = [UIButton buttonWithTitle:@"集体" titleColor:kWhiteColor backgroundColor:[UIColor redColor] titleFont:14];
    self.statusButton.frame = CGRectMake(15, 15, 32, 13);
    self.statusButton.layer.cornerRadius = 5;
    self.statusButton.clipsToBounds = YES;
//    [self.content addSubview:self.statusButton];
    
    self.infoTitle = [UILabel labelWithBackgroundColor:kWhiteColor textColor:RGB(0, 0, 0) font:13.0];
//    [self.infoTitle setFont:[UIFont boldSystemFontOfSize:15]];
    [self.content addSubview:self.infoTitle];
    self.infoTitle.frame = CGRectMake(110, 5, self.bounds.size.width-140, 44);
    self.infoTitle.numberOfLines = 0;
    self.infoTitle.text = @"山间古树";
  
    self.priceLable.textColor = kTextColor2;
    UIImageView *locationImage = [[UIImageView alloc] init];
    locationImage.contentMode = UIViewContentModeScaleToFill;
    locationImage.image = kImage(@"位置");
    locationImage.frame = CGRectMake(self.infoTitle.x, self.infoTitle.yy+10, 12, 12);
    [self.content addSubview:locationImage];
    self.priceLable = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kTextColor2 font:12.0];
    [self.content addSubview:self.priceLable];
    self.priceLable.frame = CGRectMake(locationImage.xx+5, self.infoTitle.yy+10, kScreenWidth-120, 30);
    self.priceLable.centerY = locationImage.centerY;
    
    self.priceLable.text = @"¥浙江省";
    UIView *lineView = [UIView new];
    lineView.backgroundColor = kLineColor;
    [self.content addSubview:lineView];
    lineView.frame = CGRectMake(20, self.treeImage.yy+10, kScreenWidth-40, 1);
    self.addressLab = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kBlackColor font:15.0];
    [self.content addSubview:self.addressLab];
    self.addressLab.frame = CGRectMake(20, lineView.yy+10, kScreenWidth-120, 30);
    
    self.addressLab.text = @"认养年限(年)";
    self.timeLable = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kTextColor font:14.0];
    [self.content addSubview:self.timeLable];
    self.timeLable.frame = CGRectMake(20,  self.addressLab.yy+10,kScreenWidth-120, 30);
    self.timeLable.text = @"一年: 2018-01-01-至2018-12-31";
    self.time2Lab = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kTextColor font:15.0];
    [self.content addSubview:self.time2Lab];
    self.time2Lab.frame = CGRectMake(20,  self.timeLable.yy+10, kScreenWidth-120, 30);
    self.time2Lab.text = @"三年: 2018-01-01-至2021-12-31";
    UIView *lineView1 = [UIView new];
    lineView1.backgroundColor = kLineColor;
    [self.content addSubview:lineView1];
    lineView1.frame = CGRectMake(20, self.time2Lab.yy+10, kScreenWidth-40, 1);
    
    self.selectButton = [UIButton buttonWithImageName:@"未选中" selectedImageName:@"选中"];
    self.selectButton.frame = CGRectMake(kScreenWidth-60, self.addressLab.yy+10, 20, 20);
    [self.content addSubview:self.selectButton];
    self.selectButton.centerY = self.timeLable.centerY;
    [self.selectButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.select2Button = [UIButton buttonWithImageName:@"未选中" selectedImageName:@"选中"];
    self.select2Button.frame = CGRectMake(kScreenWidth-60, self.timeLable.yy+10, 20, 20);
    [self.content addSubview:self.select2Button];
    self.select2Button.centerY = self.time2Lab.centerY;
    [self.select2Button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
   UILabel *countLab = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kBlackColor font:15.0];
    [self.content addSubview:countLab];
    countLab.frame = CGRectMake(20, lineView1.yy+10, 120, 30);
    countLab.text = @"认养份数";
    self.sumButton = [UIButton buttonWithTitle:@"一" titleColor:kAppCustomMainColor backgroundColor:kWhiteColor titleFont:13];
    self.sumButton.layer.cornerRadius = 15;
    self.sumButton.clipsToBounds = YES;
    self.sumButton.layer.borderWidth = 1;
    self.sumButton.layer.borderColor = kAppCustomMainColor.CGColor;

    self.sumButton.frame = CGRectMake(kScreenWidth-130, self.addressLab.yy+10, 30, 30);
    [self.content addSubview:self.sumButton];
    self.sumButton.centerY = countLab.centerY;
   
    self.minButton =  [UIButton buttonWithTitle:@"+" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:13];
    self.minButton.layer.cornerRadius = 15;
    self.minButton.clipsToBounds = YES;
    self.minButton.layer.borderWidth = 1;
    self.minButton.layer.borderColor = kAppCustomMainColor.CGColor;
    self.minButton.frame = CGRectMake(kScreenWidth-60, self.timeLable.yy+10, 30, 30);
    [self.content addSubview:self.minButton];
    self.minButton.centerY = countLab.centerY;
    [self.minButton addTarget:self action:@selector(sum) forControlEvents:UIControlEventTouchUpInside];
     [self.sumButton addTarget:self action:@selector(min) forControlEvents:UIControlEventTouchUpInside];
    UILabel *countLab1 = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kBlackColor font:13.0];
    [self.content addSubview:countLab1];
    self.countLable = countLab1;
    countLab1.frame = CGRectMake(kScreenWidth-95, lineView1.yy+10, 30, 30);
    countLab1.text = @"1";
    countLab1.centerY = countLab.centerY;
    countLab1.textAlignment = NSTextAlignmentCenter;
    
    UIView *lineView2 = [UIView new];
    lineView2.backgroundColor = kLineColor;
    [self.content addSubview:lineView2];
    lineView2.frame = CGRectMake(20, countLab1.yy+10, kScreenWidth-40, 1);
    
    UILabel *codeLab = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kBlackColor font:15.0];
    [self.content addSubview:codeLab];
    codeLab.frame = CGRectMake(20, lineView2.yy+20, 80, 30);
    codeLab.text = @"下单识别码";
    self.inputField = [[TLTextField alloc] initWithFrame:CGRectMake(100, lineView2.yy+10, kScreenWidth -120, 40) leftTitle:@"" titleWidth:10 placeholder:@""];
    self.inputField.layer.borderWidth = 1;
    self.inputField.layer.borderColor = kLineColor.CGColor;
    [self.content addSubview:self.inputField];
    self.inputField.centerY = codeLab.centerY;
    
    UILabel *descLab = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kTextColor2 font:12.0];
    [self.content addSubview:descLab];
    descLab.frame = CGRectMake(20, self.inputField.yy+20, kScreenWidth-40, 30);
    descLab.numberOfLines = 0;
    descLab.text = @"此树已开启集体认养! 发起人: xxx,获得识别码即可一同参与";
    self.descLab = descLab;
    UIView *lineView3 = [UIView new];
    lineView3.backgroundColor = kLineColor;
    [self.content addSubview:lineView2];
    lineView2.frame = CGRectMake(20, countLab1.yy+10, kScreenWidth-40, 1);
    
    self.sureButton = [UIButton buttonWithTitle:@"确定 (总额: ¥2999)" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:14];
    self.sureButton.frame = CGRectMake(20, descLab.yy+2, kScreenWidth-40, 44);
    self.sureButton.layer.cornerRadius = 5;
    self.sureButton.clipsToBounds = YES;
    [self.content addSubview:self.sureButton];
    [self.sureButton addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)sureClick
{
    if (self.sureBlock) {
        self.sureBlock();
    }
    
}
- (void)min
{
    if ([self.countLable.text intValue] ==1) {
        return;
    }
    int value = [self.countLable.text intValue];
    value--;
    self.countLable.text = [NSString stringWithFormat:@"%d",value];
}

- (void)sum
{
    int value = [self.countLable.text intValue];
    value++;
    self.countLable.text = [NSString stringWithFormat:@"%d",value];
    
}
- (void)btnClick:(UIButton*)sender
{
    sender.selected = !sender.selected;
    
}
@end
