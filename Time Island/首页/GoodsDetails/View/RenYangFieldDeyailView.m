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
#define HEIGHT SCREEN_HEIGHT/922*560
@interface RenYangFieldDeyailView()


@property (nonatomic , strong)NSArray *bannaArray;
//@property (nonatomic, strong) UIView *content;
@property (nonatomic, strong) UIImageView *treeImage;

@property (nonatomic , strong)UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *statusButton;//推文
@property (nonatomic, strong) UILabel *infoTitle;
@property (nonatomic, strong) UILabel *priceLable;//价格
@property (nonatomic, strong) UILabel *addressLab;
//@property (nonatomic, strong) UILabel *timeLable;//年份
//@property (nonatomic, strong) UILabel *time2Lab;//年份
//@property (nonatomic, strong) UIButton *selectButton;
//@property (nonatomic, strong) UIButton *select2Button;

@property (nonatomic, strong) UIButton *sumButton;
@property (nonatomic, strong) UIButton *minButton;

@property (nonatomic, strong) UILabel *countLable;//个数

@property (nonatomic, strong) TLTextField *inputField;

@property (nonatomic, strong) UILabel *descLab;//描述

@property (nonatomic, strong) UIButton *sureButton;

@property (nonatomic , strong)UIView *backView;
@property (nonatomic , strong)UILabel *codeLab;
@property (nonatomic , strong)UILabel *countLab;
//规格下划线
@property (nonatomic , strong)UIView *specLineView;
@property (nonatomic , strong)UIView *numberLineView;

@end
@implementation RenYangFieldDeyailView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initcustomView];
    }
    return self;
}

-(void)deleteBtnClick
{
    [[UserModel user].cusPopView dismiss];
}

- (void)initcustomView
{
    
    
    
    
    UIView *content = [UIView new];
    content.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self addSubview:content];
//    self.content.backgroundColor = kWhiteColor;

    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT- HEIGHT, SCREEN_WIDTH, HEIGHT + 100)];
    self.backView.backgroundColor = kWhiteColor;
    [self addSubview:self.backView];
    
    self.treeImage = [[UIImageView alloc] init];
    self.treeImage.contentMode = UIViewContentModeScaleToFill;
//    self.treeImage.image = kImage(@"树 跟背景");
    self.treeImage.frame = CGRectMake(20, -20, 80, 80);
    kViewRadius(self.treeImage, 5);
    [self.backView addSubview:self.treeImage];
    
    UIButton *deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [deleteBtn setImage:kImage(@"删除 灰色") forState:(UIControlStateNormal)];
    deleteBtn.frame = CGRectMake(SCREEN_WIDTH - 50, 0, 50, 50);
    [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backView addSubview:deleteBtn];
    
    
    
    self.infoTitle = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(0, 0, 0) font:0];
    [self.backView addSubview:self.infoTitle];
    self.infoTitle.font = HGboldfont(15);
    self.infoTitle.frame = CGRectMake(110, 0, SCREEN_WIDTH-160, 40);
    self.infoTitle.numberOfLines = 0;
    
    self.infoTitle.text = @"山间古树";
  
    
    
    self.priceLable.textColor = kTextColor2;
    UIImageView *locationImage = [[UIImageView alloc] init];
    locationImage.contentMode = UIViewContentModeScaleToFill;
    locationImage.image = kImage(@"位置");
    locationImage.frame = CGRectMake(self.infoTitle.x, self.infoTitle.yy+5, 9, 12);
    [self.backView addSubview:locationImage];
    
    
    self.priceLable = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kTextColor2 font:12.0];
    [self.backView addSubview:self.priceLable];
    self.priceLable.frame = CGRectMake(locationImage.xx+5, self.infoTitle.yy + 1, kScreenWidth-120, 20);
    self.priceLable.text = @"浙江省";
    
    
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = kLineColor;
    [self.backView addSubview:lineView];
    lineView.frame = CGRectMake(20, self.treeImage.yy+10, kScreenWidth-40, 1);
    
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, lineView.yy, SCREEN_WIDTH, HEIGHT - lineView.yy - 65)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.directionalLockEnabled = YES;
    [self.backView addSubview:self.scrollView];
    
    self.addressLab = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kBlackColor font:15.0];
    [self.scrollView addSubview:self.addressLab];
    self.addressLab.frame = CGRectMake(20, 10, kScreenWidth-120, 30);
    self.addressLab.text = @"认养年限(年)";
    
//    self.timeLable = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kTextColor font:14.0];
//    [self.scrollView addSubview:self.timeLable];
    
    
    
    self.specLineView = [UIView new];
    self.specLineView.backgroundColor = kLineColor;
    [self.scrollView addSubview:self.specLineView];
    
    
    self.countLab = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kBlackColor font:15.0];
    [self.scrollView addSubview:self.countLab];

    self.countLab.text = @"认养份数";
    
    self.numberLineView = [UIView new];
    self.numberLineView.backgroundColor = kLineColor;
    [self.scrollView addSubview:self.numberLineView];
    
    

    self.sumButton = [UIButton buttonWithTitle:@"一" titleColor:kAppCustomMainColor backgroundColor:kWhiteColor titleFont:13];
    self.sumButton.layer.cornerRadius = 15;
    self.sumButton.clipsToBounds = YES;
    self.sumButton.layer.borderWidth = 1;
    self.sumButton.layer.borderColor = kAppCustomMainColor.CGColor;


    [self.scrollView addSubview:self.sumButton];

    self.minButton =  [UIButton buttonWithTitle:@"+" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:26];
    self.minButton.layer.cornerRadius = 15;
    self.minButton.clipsToBounds = YES;
    self.minButton.layer.borderWidth = 1;
    self.minButton.layer.borderColor = kAppCustomMainColor.CGColor;

    [self.scrollView addSubview:self.minButton];

    [self.minButton addTarget:self action:@selector(sum) forControlEvents:UIControlEventTouchUpInside];
     [self.sumButton addTarget:self action:@selector(min) forControlEvents:UIControlEventTouchUpInside];

    UILabel *countLab1 = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kBlackColor font:13.0];
    [self.scrollView addSubview:countLab1];
    self.countLable = countLab1;

    countLab1.text = @"1";
    countLab1.textAlignment = NSTextAlignmentCenter;

    self.codeLab = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kBlackColor font:15.0];
    [self.scrollView addSubview:self.codeLab];

    self.codeLab.text = @"下单识别码";

    self.inputField = [[TLTextField alloc] initWithFrame:CGRectMake(100, 0, kScreenWidth -120, 40) leftTitle:@"" titleWidth:10 placeholder:@""];
    self.inputField.layer.borderWidth = 1;
    self.inputField.layer.borderColor = kLineColor.CGColor;
    [self.scrollView addSubview:self.inputField];
    
    
    
    UILabel *descLab = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kTextColor2 font:12.0];
    [self.scrollView addSubview:descLab];
    descLab.frame = CGRectMake(20, SCREEN_HEIGHT - 100, kScreenWidth-40, 20);
    descLab.numberOfLines = 0;
    descLab.text = @"此树已开启集体认养! 发起人: xxx,获得识别码即可一同参与";
    self.descLab = descLab;
    
    
    
    
    UIView *lineView3 = [UIView new];
    lineView3.backgroundColor = kLineColor;
    [self.backView addSubview:lineView3];
    lineView3.frame = CGRectMake(20, HEIGHT - 65 , kScreenWidth-40, 1);
    
    self.sureButton = [UIButton buttonWithTitle:@"确定 (总额: ¥2999)" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:14];
    self.sureButton.frame = CGRectMake(20, HEIGHT - 60 , kScreenWidth-40, 44);
    self.sureButton.layer.cornerRadius = 5;
    self.sureButton.clipsToBounds = YES;
    [self.backView addSubview:self.sureButton];
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

-(void)setSlImages:(NSArray *)slImages
{
//    self.slImages = slImages;
    self.bannaArray = slImages;
}

-(void)setTreeModel:(TreeModel *)TreeModel
{
    if (self.bannaArray.count > 0) {
        [self.treeImage sd_setImageWithURL:[NSURL URLWithString:self.bannaArray[0]]];
    }
    if (TreeModel.treeList.count > 0) {
        self.infoTitle.text = TreeModel.treeList[0][@"scientificName"];
        self.priceLable.text = TreeModel.treeList[0][@"originPlace"];
    }
    
    UILabel *bottomSpec;
    for (int i = 0; i < TreeModel.productSpecsList.count; i ++) {
        UILabel *specTimeLbl = [UILabel labelWithFrame:CGRectMake(20, self.addressLab.yy + 10 + i % TreeModel.productSpecsList.count * 40, SCREEN_WIDTH - 40 - 30, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kTextColor];
        specTimeLbl.text = [NSString stringWithFormat:@"%@:%@至%@",TreeModel.productSpecsList[i][@"name"],[TreeModel.productSpecsList[i][@"startDatetime"] convertDate],[TreeModel.productSpecsList[i][@"endDatetime"] convertDate]];
        if (i == TreeModel.productSpecsList.count - 1) {
            bottomSpec = specTimeLbl;
        }
        [self.scrollView addSubview:specTimeLbl];
        
        
    }
    
    
    self.specLineView.frame = CGRectMake(20, bottomSpec.yy+10, kScreenWidth-40, 1);

//    认养份数
    self.countLab.frame = CGRectMake(20, _specLineView.yy+10, 120, 30);
    self.sumButton.frame = CGRectMake(kScreenWidth-130, _specLineView.yy+10, 30, 30);
    self.minButton.frame = CGRectMake(kScreenWidth-60, _specLineView.yy+10, 30, 30);
    self.countLable.frame = CGRectMake(kScreenWidth-95, _specLineView.yy+10, 30, 30);

    self.numberLineView.frame = CGRectMake(20, self.countLab.yy+10, kScreenWidth-40, 1);
    
    
    self.codeLab.frame = CGRectMake(20, self.countLable.yy+20, 80, 40);
    self.inputField.frame = CGRectMake(self.codeLab.xx + 10, self.countLable.yy+20, SCREEN_WIDTH - self.codeLab.xx - 30, 40);
    self.descLab.frame = CGRectMake(20, self.inputField.yy + 20, kScreenWidth-40, 20);
    
    
    self.scrollView.contentSize = CGSizeMake(0, self.descLab.yy + 30);
    
}



@end
