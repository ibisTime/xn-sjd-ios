//
//  MallStoreHeadView.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/5.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallStoreHeadView.h"

@implementation MallStoreHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        [self initTop];
    }
    return self;
}
- (UIView *)headerView {
    
    if (!_headerView) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/750*300  + SCREEN_WIDTH/4 + 149)];
        
    }
    return _headerView;
}
- (void)initTop
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/750*300)];
    view.backgroundColor = kLineColor;
    
    _topImage = [SLBannerView bannerView];
    _topImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/750*300);
    _topImage.durTimeInterval = 0.2;
    _topImage.imgStayTimeInterval = 2.5;
    //工程图片
    
    
    
    [view addSubview:_topImage];
    [self.headerView addSubview:view];
    
    
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-80)/2, _topImage.yy-40, 80, 80)];
    _headImage.layer.cornerRadius = 40;
    _headImage.clipsToBounds = YES;
    _headImage.image = kImage(@"分类三");
    [self.headerView addSubview:_headImage];
    
    _nameLable = [UILabel labelWithFrame:CGRectMake(0, _headImage.yy+11, SCREEN_WIDTH, 22.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(16) textColor:kBlackColor];
    _nameLable.text = self.treeModel.shopName;
    [_nameLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [self.headerView addSubview:_nameLable];
    
    
    
    
    _introduceLable = [UILabel labelWithFrame:CGRectMake(15, _nameLable.yy+7, (kScreenWidth-30), 16.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
    _introduceLable.text = @"";
    [self.headerView addSubview:_introduceLable];
    
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _introduceLable.yy + 20, SCREEN_WIDTH, 10)];
    lineView.backgroundColor = kBackgroundColor;
    [self.headerView addSubview:lineView];
    
    //    NSArray * ClassifyName = @[@"分类一",@"分类二",@"分类三",@"分类四"];
    
    NSMutableArray * namearr = [NSMutableArray array];
    NSMutableArray  *imagearr = [NSMutableArray array];
    for (int i = 0; i < self.QWCategorys.count; i++) {
        [namearr addObject:self.QWCategorys[i].name];
        [imagearr addObject:self.QWCategorys[i].pic];
    }
    
    for (int i = 0; i < self.QWCategorys.count; i ++) {
        UIButton *iconBtn = [UIButton buttonWithTitle:@"" titleColor:kHexColor(@"#666666") backgroundColor:kClearColor titleFont:12];
        iconBtn.frame = CGRectMake(i % 5 * SCREEN_WIDTH/5, lineView.yy, SCREEN_WIDTH/5, 55 + 16.5);
        iconBtn.tag = i;
        [self.headerView addSubview:iconBtn];
        [iconBtn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        
        UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5/2 - 20,  7.5, 40, 40)];
        [iconImg sd_setImageWithURL:[NSURL URLWithString:[imagearr[i] convertImageUrl]]];
        [iconBtn addSubview:iconImg];
        
        UILabel *iconlLbl = [UILabel labelWithFrame:CGRectMake(0,  55, SCREEN_WIDTH/5, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#666666")];
        iconlLbl.text = namearr[i];
        
        [iconBtn addSubview:iconlLbl];
        
        self.iconBtn = iconBtn;
        
    }
    UILabel *hotLable = [UILabel labelWithFrame:CGRectMake(15, lineView.yy + SCREEN_WIDTH/4, SCREEN_WIDTH - 30, 22) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:HGboldfont(16) textColor:kBlackColor];
    hotLable.text = @"热销商品";
    ;
    [self.headerView addSubview:hotLable];
    [self addSubview:self.headerView];
}
-(void)click:(UIButton *)sender{
    if (self.classifyclick) {
        self.classifyclick(sender);
    }
}
-(void)setImageArraay:(NSMutableArray *)imageArraay{
    _imageArraay = imageArraay;
    
}
-(void)setQWCategorys:(NSMutableArray<QWCategory *> *)QWCategorys{
    _QWCategorys = QWCategorys;
    
//    [self initTop];
}
- (void)setName:(NSString *)name{
    _name = name;
}
-(void)setTreeModel:(MallGoodsModel *)treeModel{
    _treeModel = treeModel;
    [self initTop];
    self.topImage.slImages = self.imageArraay;
    self.introduceLable.text = self.str;
    self.nameLable.text = self.name;
    
}
@end
