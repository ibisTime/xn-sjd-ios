//
//  MallHomeHeadVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/18.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallHomeHeadVC.h"
@interface MallHomeHeadVC()<HW3DBannerViewDelegate>
{
    NSInteger selectNum;
}
@property (nonatomic,strong) UIView * ClassifyView;
@end


@implementation MallHomeHeadVC

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
        [self SetClassify];
    }
    return self;
}
-(void)SetClassify{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, self.scrollView.yy, SCREEN_WIDTH, 115)];
    [self addSubview:view];
    self.ClassifyView = view;
    NSArray * ClassifyName = @[@"分类一",@"分类二",@"分类三",@"分类四",@"分类五"];
    CGFloat marge = (SCREEN_WIDTH - 45 * 5) / 
//    [self addSubview:renLingTree];
//    self.renLingTree = renLingTree;
//
//    NSArray *Names = @[@"古树认养",@"商场",@"排行榜"];
//
//    CGFloat marge = (kScreenWidth-3*33)/4;
//    [Names enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//        UIButton *btn = [UIButton buttonWithTitle:@"" titleColor:kTextColor backgroundColor:kClearColor titleFont:15];
//        [btn setTitleColor:kTextColor forState:UIControlStateNormal];
//        //        btn.layer.cornerRadius = 25;
//        //        btn.clipsToBounds = YES;
//        [btn setBackgroundImage:kImage(Names[idx]) forState:UIControlStateNormal];
//        [btn setTitleColor:kAppCustomMainColor forState:UIControlStateSelected];
//        btn.frame = CGRectMake(idx*marge+marge+idx*33, 10, 33, 33);
//        [renLingTree addSubview:btn];
//        UILabel *title = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(0, 0, 0) font:12];
//        title.frame = CGRectMake(btn.xx, 50, 80, 20);
//        title.centerX = btn.centerX;
//        title.text = Names[idx];
//        title.textAlignment = NSTextAlignmentCenter;
//        [renLingTree addSubview:title];
//        if (idx == 0) {
//            title.textColor = kAppCustomMainColor;
//        }
//
//        btn.tag = idx +100;
//        [btn addTarget:self action:@selector(renLingClick:) forControlEvents:UIControlEventTouchUpInside];
//        UIView *lineView = [UIView new];
//        lineView.backgroundColor = kLineColor;
//        lineView.frame = CGRectMake(0, title.yy +15, kScreenWidth, 5);
//        [self.renLingTree addSubview:lineView];
//    }];
    
}











-(HW3DBannerView *)scrollView
{
    if (!_scrollView) {
        //        CoinWeakSelf;
        _scrollView = [HW3DBannerView initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 150) imageSpacing:0 imageWidth:SCREEN_WIDTH ];
        _scrollView.initAlpha = 0; // 设置两边卡片的透明度
        _scrollView.imageRadius = 5; // 设置卡片圆角
        _scrollView.imageHeightPoor = 20;// 设置占位图片
        _scrollView.delegate = self;
        _scrollView.autoScrollTimeInterval = 4;
        _scrollView.data = @[@"baner1",@"baner2",@"baner1"];
        _scrollView.clickImageBlock = ^(NSInteger currentIndex) {
            
            self->selectNum = currentIndex;
        };
    }
    return _scrollView;
}

-(void)HW3DBannerViewClick
{
    CoinWeakSelf;
    if (weakSelf.headerBlock) {
        weakSelf.headerBlock(HomeEventsTypeBanner, selectNum,nil);
    }
}

#pragma mark - Setting
- (void)setBanners:(NSMutableArray<BannerModel *> *)banners {
    
    _banners = banners;
    
    NSMutableArray *imgUrls = [NSMutableArray array];
    
    [banners enumerateObjectsUsingBlock:^(BannerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.pic) {
            
            [imgUrls addObject:obj.pic];
        }
    }];
    _scrollView.data = imgUrls;
    //    self.bannerView.imgUrls = imgUrls;
    
}
@end
