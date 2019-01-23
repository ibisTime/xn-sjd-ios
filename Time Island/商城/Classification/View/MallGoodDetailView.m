//
//  MallGoodDetailView.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallGoodDetailView.h"

@interface MallGoodDetailView()
@property (nonatomic, strong) UILabel *info;
@property (nonatomic, strong) UILabel *priceLable;
@property (nonatomic, strong) UILabel *addressLab;
@property (nonatomic, strong) UILabel *kuaiLab;
@property (nonatomic, strong) UILabel *sellLab;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) UILabel *chooseLab;


@end
@implementation MallGoodDetailView

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
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight(265))];
    self.bgView.backgroundColor = RGB(236, 236, 236);
    [self addSubview:self.bgView];
    self.bgImage = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-kWidth(289))/2, (kHeight(265)-kHeight(145))/2, kWidth(289), kHeight(145))];
    [self.bgView addSubview:self.bgImage];
    self.bgImage.image = kImage(@"baner1");
    self.bgImage.centerX = self.bgView.centerX;
    self.bgImage.centerY = self.bgView.centerY;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(15, 20, 25, 25)];
    [self.bgView addSubview:backView];
    backView.layer.cornerRadius = 12.5;
    backView.clipsToBounds = YES;
    backView.backgroundColor = RGB(100, 100, 100);
    UIButton *backButton = [UIButton buttonWithImageName:@"返回" cornerRadius:12.5];
    [self.bgView addSubview:backButton];
    backButton.frame = CGRectMake(15, 20, 25, 25);
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *backView1 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth-30-25, 20, 25, 25)];
    [self.bgView addSubview:backView1];
    backView1.layer.cornerRadius = 12.5;
    backView1.clipsToBounds = YES;
    backView1.backgroundColor = RGB(100, 100, 100);
    
    UIButton *editButton = [UIButton buttonWithImageName:@"编辑" cornerRadius:12.5];
    [self.bgView addSubview:editButton];
    [editButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    editButton.frame = CGRectMake(kScreenWidth-30-25, 20, 25, 25);

    self.priceLable = [UILabel labelWithFrame:CGRectMake(15, self.bgView.yy+15, kScreenWidth-30, 22) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#F68646")];
    [self addSubview:self.priceLable];
    self.priceLable.text = @"¥1000.00-¥2000.00";
    self.info = [UILabel labelWithFrame:CGRectMake(15, self.priceLable.yy+10, kScreenWidth-30, 44) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(15) textColor:kBlackColor];
    self.info.numberOfLines =0;
    self.info.text = @"新品发布新品发布新品发布新品发布新品发布新品发布新品发布新品发布新品发布";
    [self addSubview:self.info];
    self.kuaiLab = [UILabel labelWithFrame:CGRectMake(15, self.info.yy+15, kWidth(80), 22) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
    self.kuaiLab.text = @"快递: 包邮";
    [self addSubview:self.kuaiLab];
    self.sellLab = [UILabel labelWithFrame:CGRectMake(self.kuaiLab.xx, self.info.yy+15, kWidth(100), 22) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
    self.sellLab.text = @"月销15笔";
    self.sellLab.centerX = self.centerX;
    [self addSubview:self.sellLab];

    self.addressLab = [UILabel labelWithFrame:CGRectMake(kScreenWidth-kWidth(80), self.info.yy+15, kWidth(60), 22) textAligment:NSTextAlignmentRight backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
    self.addressLab.text = @"上海";
    [self addSubview:self.addressLab];
    self.addressLab.centerY = self.sellLab.centerY;

    UIView *lineView = [UIView new];
    lineView.backgroundColor = RGB(236, 236, 236);
    lineView.frame = CGRectMake(0, self.addressLab.yy+15, kScreenWidth, 10);
    [self addSubview:lineView];
    
    self.chooseLab = [UILabel labelWithFrame:CGRectMake(15, lineView.yy+15, kScreenWidth-30, 55) textAligment:NSTextAlignmentLeft backgroundColor:kWhiteColor font:FONT(13) textColor:kBlackColor];
    self.chooseLab.text = @"规格: 请选择规格分类";
    [self addSubview:self.chooseLab];
    self.chooseLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *ta = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseClick)];
    [self.chooseLab addGestureRecognizer:ta];
    
    
    UIView *lineView1 = [UIView new];
    lineView1.backgroundColor = RGB(236, 236, 236);
    lineView1.frame = CGRectMake(0, self.chooseLab.yy+10, kScreenWidth, 10);
    [self addSubview:lineView1];
}
- (void)chooseClick
{
    
    NSLog(@"点击选择规格");
    
}
- (void)backClick
{

}
@end
