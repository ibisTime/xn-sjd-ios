//
//  HomeHeaderView.m
//  OGC
//
//  Created by 蔡卓越 on 2018/3/13.
//  Copyright © 2018年  tianlei. All rights reserved.
//

#import "HomeHeaderView.h"

//Macro
#import "TLUIHeader.h"
#import "AppColorMacro.h"
#import "UIColor+theme.h"
//Category
#import "UIButton+EnLargeEdge.h"
#import "NSString+Extension.h"
#import "CoinUtil.h"
#import "XBTextLoopView.h"
//V
#import "TLBannerView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HomeHeaderView()<HW3DBannerViewDelegate>
{
    NSInteger selectNum;
}

//轮播图
@property (nonatomic,strong) TLBannerView *bannerView;
//统计
@property (nonatomic, strong) UIView *statisticsView;
//数据
@property (nonatomic, strong) UILabel *dataLbl;
//应用
@property (nonatomic, strong) UIView *applicationView;

@property (nonatomic, strong) UIButton *tempBtn;

@property (nonatomic, strong) UIView *noticeView;//公告
@property (nonatomic, strong) UILabel *introduceLab;
@property (nonatomic, strong) UIView *renLingTree;//认领

@property (nonatomic, strong) UIView *tuiArticle;//推文
@property (nonatomic, strong) UILabel *tuiLab;
@property (nonatomic, strong)  UILabel *englishLab;//推文英文
@property (nonatomic, strong) UIView *fastNews;//快报


@end

@implementation HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        //轮播图
//        [self initBannerView];
        [self addSubview:self.scrollView];
        [self initNoticeView];
        [self initRenLingTree];
        [self initTuiArticle];
        [self initFastNews];
    }
    return self;
}

-(void)initNoticeView
{
    UIView *noticeView = [UIView new];
    noticeView.frame = CGRectMake(0, self.scrollView.yy, kScreenWidth, 40);
    [self addSubview:noticeView];
    self.noticeView = noticeView;
    noticeView.backgroundColor = RGB(227, 246, 239);
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = kImage(@"公告");
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.frame = CGRectMake(25, 10, 40, 20);
    [self.noticeView addSubview:imageView];
    UIView *line = [UIView new];
    line.backgroundColor = kLineColor;
    line.frame = CGRectMake(10, 12.5, 4, 15);
    line.backgroundColor = kAppCustomMainColor;
    [self.noticeView addSubview:line];
    UILabel *introduceLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:14];
    introduceLab.frame = CGRectMake(90, 5, kScreenWidth-140-50, 30);
    introduceLab.text = @"测试";
    [self.noticeView addSubview:introduceLab];
    self.introduceLab = introduceLab;
    
    UILabel *moreLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:14];
    moreLab.frame = CGRectMake(kScreenWidth-40, 5, 40, 30);
    moreLab.textAlignment = NSTextAlignmentLeft;
    moreLab.text = @"更多";
    [self.noticeView addSubview:moreLab];
    moreLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *ta = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreNotice)];
    [moreLab addGestureRecognizer:ta];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = kLineColor;
    line1.frame = CGRectMake(kScreenWidth-50, 12.5, 2, 15);
    line1.backgroundColor = kAppCustomMainColor;
    [self.noticeView addSubview:line1];
}

-(void)initRenLingTree
{
    UIView *renLingTree = [UIView new];
    renLingTree.frame = CGRectMake(0, self.noticeView.yy, kScreenWidth, 80);
    [self addSubview:renLingTree];
    self.renLingTree = renLingTree;
   
    NSArray *Names = @[@"古树认养",@"果树预售",@"排行榜"];

    [Names enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *btn = [UIButton buttonWithTitle:@"" titleColor:kTextColor backgroundColor:kClearColor titleFont:15];
        [btn setTitleColor:kTextColor forState:UIControlStateNormal];
        btn.layer.cornerRadius = 25;
        btn.clipsToBounds = YES;
        [btn setBackgroundImage:kImage(Names[idx]) forState:UIControlStateNormal];
        [btn setTitleColor:kAppCustomMainColor forState:UIControlStateSelected];
        btn.frame = CGRectMake(50+idx*50+idx*(70), 10, 40, 40);
        [renLingTree addSubview:btn];
        UILabel *title = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:15];
        title.frame = CGRectMake(btn.xx, 50, 80, 20);
        title.centerX = btn.centerX;
        title.text = Names[idx];
        title.textAlignment = NSTextAlignmentCenter;
        [renLingTree addSubview:title];
        if (idx == 0) {
            title.textColor = kAppCustomMainColor;
        }
       
        btn.tag = idx +100;
        [btn addTarget:self action:@selector(renLingClick:) forControlEvents:UIControlEventTouchUpInside];
        UIView *lineView = [UIView new];
        lineView.backgroundColor = kLineColor;
        lineView.frame = CGRectMake(0, title.yy +15, kScreenWidth, 5);
        [self.renLingTree addSubview:lineView];
    }];
  
}

-(void)initTuiArticle
{
    UIView *tuiArticle = [UIView new];
    tuiArticle.frame = CGRectMake(0, self.renLingTree.yy, kScreenWidth, 140);
    [self addSubview:tuiArticle];
    self.tuiArticle = tuiArticle;
    
    UILabel *tuiLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextBlack font:16];
    tuiLab.frame = CGRectMake(15, 15, kScreenWidth-120-50, 22);
    tuiLab.text = @"情感推文";
    tuiLab.font = [UIFont boldSystemFontOfSize:16];

    [self.tuiArticle addSubview:tuiLab];
    self.tuiLab = tuiLab;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = kImage(@"baner1");
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.frame = CGRectMake(15, tuiLab.yy+5, (kScreenWidth-40)/2, 100);
    imageView.contentMode = UIViewContentModeScaleToFill;
    [self.tuiArticle addSubview:imageView];
    
    UIImageView *imageView2 = [[UIImageView alloc] init];
    imageView2.image = kImage(@"baner2");
    imageView2.contentMode = UIViewContentModeScaleToFill;
    imageView2.frame = CGRectMake((kScreenWidth-40)/2+10+15, tuiLab.yy+5, (kScreenWidth-40)/2, 100);
    imageView2.contentMode = UIViewContentModeScaleToFill;
    [self.tuiArticle addSubview:imageView2];
    
    UILabel *englishLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:12];
    englishLab.frame = CGRectMake((kScreenWidth-120), 10, 90, 30);
    englishLab.textAlignment = NSTextAlignmentRight;
    englishLab.text = @"查看更多";
    [self.tuiArticle addSubview:englishLab];
    
    UIButton *button = [UIButton buttonWithImageName:@"" selectedImageName:@""];
    [button setImage:kImage(@"积分更多") forState:UIControlStateNormal];
    button.frame  = CGRectMake(kScreenWidth -30, 10, 14, 30);
    [button addTarget:self action:@selector(jumpArtcile) forControlEvents:UIControlEventTouchUpInside];
    [self.tuiArticle addSubview:button];
    
}

-(void)initFastNews
{
    UIView *fastNews = [UIView new];
    fastNews.frame = CGRectMake(0, self.tuiArticle.yy+10, kScreenWidth, 40);
    [self addSubview:fastNews];
    fastNews.backgroundColor = RGB(252, 240, 240);
    self.fastNews = fastNews;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = kImage(@"快报");
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.frame = CGRectMake(10, 10, 60, 20);
    imageView.clipsToBounds = YES;
    [self.fastNews addSubview:imageView];
    CoinWeakSelf;
    XBTextLoopView *loopView = [XBTextLoopView textLoopViewWith:@[@"1234567890",@"234我轮播测试挎包快报打了卡时间岛",@"56790e8902890ce侧搜客来得及案件"] loopInterval:3.0 initWithFrame:CGRectMake(80, 5, kScreenWidth-100, 30) selectBlock:^(NSString *selectString, NSInteger index) {
        
        [weakSelf fastNewClickWithIndex:index];
    }];
    loopView.backgroundColor = RGB(252, 240, 240);;
    [self.fastNews addSubview:loopView];
    UILabel *englishLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:12];
    englishLab.frame = CGRectMake((kScreenWidth-120), 10, 90, 30);
    englishLab.textAlignment = NSTextAlignmentRight;
    englishLab.text = @"更多";
    [self.fastNews addSubview:englishLab];
    
    UIButton *button = [UIButton buttonWithImageName:@"" selectedImageName:@""];
    [button setImage:kImage(@"积分更多") forState:UIControlStateNormal];
    button.frame  = CGRectMake(kScreenWidth -30, 10, 14, 30);
    [button addTarget:self action:@selector(jumpArtcile) forControlEvents:UIControlEventTouchUpInside];
    [self.fastNews addSubview:button];
    
}


-(HW3DBannerView *)scrollView
{
    if (!_scrollView) {
//        CoinWeakSelf;
        _scrollView = [HW3DBannerView initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_WIDTH/2 - 15) imageSpacing:0 imageWidth:SCREEN_WIDTH ];
        _scrollView.initAlpha = 0; // 设置两边卡片的透明度
        _scrollView.imageRadius = 5; // 设置卡片圆角
        _scrollView.imageHeightPoor = 20;// 设置占位图片
        _scrollView.delegate = self;
        _scrollView.autoScrollTimeInterval = 4;
        _scrollView.data = @[@"baner1",@"baner2",@"baner1"];
        _scrollView.clickImageBlock = ^(NSInteger currentIndex) {
            
            selectNum = currentIndex;
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

//-(void)click1:(UITapGestureRecognizer *)sender{
//
//}


#pragma mark - Init
//- (void)initBannerView {
//
//    CoinWeakSelf;
//
//    //顶部轮播
//    TLBannerView *bannerView = [[TLBannerView alloc] initWithFrame:CGRectMake(15, 5, kScreenWidth-30, kHeight(138))];
//    bannerView.layer.cornerRadius = 5;
//    bannerView.clipsToBounds = YES;
//
//    bannerView.selected = ^(NSInteger index) {
//
//        if (weakSelf.headerBlock) {
//
//            weakSelf.headerBlock(HomeEventsTypeBanner, index,nil);
//        }
//    };
//
//    [self addSubview:bannerView];
//
//    self.bannerView = bannerView;
//}

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



#pragma mark - Events
- (void)lookFlowList:(UITapGestureRecognizer *)tapGR {
    
    if (_headerBlock) {
        
        _headerBlock(HomeEventsTypeStatistics, 0,nil);
    }
}


- (void)moreNotice
{
    NSLog(@"点击更多");
    
}


-(void)renLingClick:(UIButton *)btn
{
    
    NSLog(@"点击认养");
}

- (void)jumpArtcile
{
    //跳转推文
    NSLog(@"跳转推文");
}

-(void)fastNewClickWithIndex:(NSInteger)index
{
    
    NSLog(@"点击快报");
    
}
@end
