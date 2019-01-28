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
#import "SLBannerView.h"
@interface HomeHeaderView()<HW3DBannerViewDelegate,SLBannerViewDelegate>
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

//@property (nonatomic, strong) UIView *noticeView;//公告
//@property (nonatomic, strong) UILabel *introduceLab;
@property (nonatomic, strong) UIView *renLingTree;//认领

@property (nonatomic, strong) UIView *tuiArticle;//推文
@property (nonatomic, strong) UILabel *tuiLab;
@property (nonatomic, strong)  UILabel *englishLab;//推文英文
@property (nonatomic, strong) UIView *fastNews;//快报
@property (nonatomic,strong) SLBannerView * banner;
@property (nonatomic,strong)  UIImageView *imageView;

@end

@implementation HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        //轮播图
//        [self initBannerView];
        [self addSubview:self.banner];
//        [self addSubview:self.scrollView];
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
    noticeView.frame = CGRectMake(0, self.banner.yy, kScreenWidth, 30);
    [self addSubview:noticeView];

    self.noticeView = noticeView;
    noticeView.backgroundColor = RGB(233, 247, 243);
    
    
    UIView *line = [UIView new];
    line.backgroundColor = kLineColor;
    line.frame = CGRectMake(10, 9, 3, 12);
    line.backgroundColor = kTabbarColor;
    [noticeView addSubview:line];
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = kImage(@"公告");
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.frame = CGRectMake(line.xx + 7, 9, 28, 12);
    [noticeView addSubview:imageView];
    self.imageView = imageView;
    
    
    UILabel *introduceLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kHexColor(@"#666666") font:12];
    introduceLab.textAlignment = NSTextAlignmentLeft;
    introduceLab.frame = CGRectMake(imageView.xx + 15, 7, kScreenWidth - 120, 16);
    introduceLab.text = @"氧林平台测试公告氧林平台测试公告氧林平台测试公告氧林平台测试公告";
    introduceLab.centerY = imageView.centerY;
    
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc]init];
    introduceLab.userInteractionEnabled = YES;
    [ges addTarget:self action:@selector(tap)];
    [introduceLab addGestureRecognizer:ges];
    [noticeView addSubview:introduceLab];
    self.introduceLab = introduceLab;
    
    UILabel *moreLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTabbarColor font:12];
    moreLab.frame = CGRectMake(kScreenWidth-36, 9, 26, 12);
    moreLab.textAlignment = NSTextAlignmentLeft;
    moreLab.text = @"更多";
    [noticeView addSubview:moreLab];
    moreLab.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *ta = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreNotice)];
    [moreLab addGestureRecognizer:ta];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = kLineColor;
    line1.frame = CGRectMake(kScreenWidth-45, 9, 1, 12);
    line1.backgroundColor = kTabbarColor;
    [noticeView addSubview:line1];
}

-(void)initRenLingTree
{
    UIView *renLingTree = [UIView new];
    renLingTree.frame = CGRectMake(0, self.noticeView.yy, kScreenWidth, 70);
    [self addSubview:renLingTree];
    self.renLingTree = renLingTree;
   
    NSArray *Names = @[@"古树认养",@"商场",@"排行榜"];

    for (int i = 0; i < 3; i ++) {
        UIButton *btn = [UIButton buttonWithTitle:@"" titleColor:kTextColor backgroundColor:kClearColor titleFont:12];
        [btn setTitleColor:kTextColor forState:UIControlStateNormal];

        btn.frame = CGRectMake(25 + i % 3 * (SCREEN_WIDTH - 50)/3, 10, (SCREEN_WIDTH - 50)/3, 60);
        [btn setTitle:Names[i] forState:(UIControlStateNormal)];
        
        [btn SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:6 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(Names[i]) forState:UIControlStateNormal];
        }];
        [renLingTree addSubview:btn];
        btn.tag = i +100;
        [btn addTarget:self action:@selector(renLingClick:) forControlEvents:UIControlEventTouchUpInside];
    }
  
}
-(void)tap{
    NSLog(@"%s",__func__);
    NSLog(@"点击更多");
    if (self.tapintroduce) {
        self.tapintroduce();
    }
}



-(void)initTuiArticle
{
    UIView *tuiArticle = [UIView new];
    tuiArticle.frame = CGRectMake(0, self.renLingTree.yy, (kScreenWidth-30), (SCREEN_WIDTH - 30)/690*200 + 34 + 20);
    [self addSubview:tuiArticle];
    self.tuiArticle = tuiArticle;
    
    UILabel *tuiLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kBlackColor font:15];
    tuiLab.frame = CGRectMake(15, 15, kScreenWidth-100, 15);
    tuiLab.text = @"情感推文";
    [tuiLab  setFont:HGboldfont(15)];
    [self.tuiArticle addSubview:tuiLab];
    self.tuiLab = tuiLab;
    
    
    UIButton *button = [UIButton buttonWithTitle:@"查看更多" titleColor:kHexColor(@"#666666") backgroundColor:kClearColor titleFont:12];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    button.frame  = CGRectMake(kScreenWidth - 100, 15, 85, 15);
    [button SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:10 imagePositionBlock:^(UIButton *button) {
        [button setImage:kImage(@"积分更多") forState:UIControlStateNormal];
    }];
    [button addTarget:self action:@selector(tuiwenClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tuiArticle addSubview:button];
 
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = kImage(@"baner1");
    imageView.frame = CGRectMake(15, tuiLab.yy+8, (kScreenWidth-30), (SCREEN_WIDTH - 30)/690*200);
    kViewRadius(imageView, 4);
    [self.tuiArticle addSubview:imageView];
    
    UITapGestureRecognizer *ta = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tuiwenClick)];
    [imageView addGestureRecognizer:ta];
}




-(void)initFastNews
{
    
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, self.tuiArticle.yy, SCREEN_WIDTH , 64)];
    self.backView = backView;
    [self addSubview:backView];
    
    UIView *fastNews = [UIView new];
    fastNews.frame = CGRectMake(0, 0, kScreenWidth, 30);
    [backView addSubview:fastNews];
    fastNews.backgroundColor = RGB(252, 240, 240);
    self.fastNews = fastNews;
    
//    CGRectMake(line.xx + 7, 9, 28, 12)

    
    UIView *line = [UIView new];
    line.backgroundColor = kLineColor;
    line.frame = CGRectMake(10, 9, 3, 12);
    line.backgroundColor = [UIColor redColor];
    [fastNews addSubview:line];
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = kImage(@"快报");
    imageView.frame = CGRectMake(line.xx + 7, 9, 28, 12);
    [fastNews addSubview:imageView];
    
    CoinWeakSelf;
//    XBTextLoopView *loopView = [XBTextLoopView textLoopViewWith:@[@"氧林快报测试数据氧林快报测试数据氧林快报测试数据氧林快报测试数据",@"氧林快报测试数据",@"氧林快报测试数据"] loopInterval:3.0 initWithFrame:CGRectMake(imageView.xx, 0, kScreenWidth-105, 30) selectBlock:^(NSString *selectString, NSInteger index) {
    NSLog(@"self.TextLoopArray = %@",self.TextLoopArray);
    
    
    
    UILabel *moreLab = [UILabel labelWithBackgroundColor:kClearColor textColor:[UIColor redColor] font:12];
    moreLab.frame = CGRectMake(kScreenWidth-36, 9, 26, 12);
    moreLab.textAlignment = NSTextAlignmentLeft;
    moreLab.text = @"更多";
    [fastNews addSubview:moreLab];
    moreLab.userInteractionEnabled = YES;

    
    UIView *line1 = [UIView new];
    line1.frame = CGRectMake(kScreenWidth-45, 9, 1, 12);
    line1.backgroundColor = [UIColor redColor];
    [fastNews addSubview:line1];
    
    
    UILabel *tuiLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kBlackColor font:15];
    tuiLab.frame = CGRectMake(15, fastNews.yy + 9, kScreenWidth-100, 15);
    tuiLab.text = @"古树认养";
    [tuiLab  setFont:HGboldfont(15)];
    [backView addSubview:tuiLab];
    
    
    UIButton *button = [UIButton buttonWithTitle:@"查看更多" titleColor:kHexColor(@"#666666") backgroundColor:kClearColor titleFont:12];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    button.frame  = CGRectMake(kScreenWidth - 100, fastNews.yy + 9, 85, 15);
    [button SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:10 imagePositionBlock:^(UIButton *button) {
        [button setImage:kImage(@"积分更多") forState:UIControlStateNormal];
    }];
    [button addTarget:self action:@selector(tuiwenClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:button];


}

-(SLBannerView *)banner
{
    if (!_banner) {
        _banner = [SLBannerView bannerView];
        _banner.frame = CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_WIDTH/750 * 300);
        //工程图片
        _banner.slImages = @[@"树 跟背景", @"树 跟背景", @"树 跟背景", @"树 跟背景", @"树 跟背景"];
        _banner.durTimeInterval = 0.2;
        _banner.imgStayTimeInterval = 2.5;
        _banner.delegate = self;
    }
    return _banner;
}



//-(HW3DBannerView *)scrollView{
//    if (!_scrollView) {
////        CoinWeakSelf;
//        _scrollView = [HW3DBannerView initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_WIDTH/750 * 300) imageSpacing:0 imageWidth:SCREEN_WIDTH ];
//        _scrollView.initAlpha = 0; // 设置两边卡片的透明度
////        _scrollView.imageRadius = 5; // 设置卡片圆角
//        _scrollView.imageHeightPoor = 20;// 设置占位图片
//        _scrollView.delegate = self;
//        _scrollView.autoScrollTimeInterval = 4;
//        _scrollView.data = @[@"baner1",@"baner2",@"baner1"];
//        _scrollView.clickImageBlock = ^(NSInteger currentIndex) {
//
//            self->selectNum = currentIndex;
//        };
//    }
//    return _scrollView;
//}

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
    _banner.slImages = imgUrls;
//    self.bannerView.imgUrls = imgUrls;

}




#pragma mark - Events
//- (void)lookFlowList:(UITapGestureRecognizer *)tapGR {
//
//    if (_headerBlock) {
//
//        _headerBlock(HomeEventsTypeStatistics, 0,nil);
//    }
//}


- (void)moreNotice
{
    NSLog(@"点击更多");
    if (self.clickNoticeBlock) {
        self.clickNoticeBlock();
    }
}


-(void)renLingClick:(UIButton *)btn
{
    NSLog(@"点击认养");
    if (self.clickTagBlock) {
        self.clickTagBlock(btn.tag-100);
    }
}

-(void)tuiwenClick
{
    NSLog(@"点击推文");
    if (self.clickBookBlock) {
        self.clickBookBlock();
    }
    
}
- (void)jumpArtcile
{
    //跳转推文
    NSLog(@"跳转推文");
    if (self.clickBookBlock) {
        self.clickBookBlock();
    }
}

-(void)fastNewClickWithIndex:(NSInteger)index
{
    if (self.clicknewsBlock) {
        self.clicknewsBlock();
    }
    NSLog(@"点击快报");
    
}
-(void)setTextLoopArray:(NSMutableArray *)TextLoopArray{
//    _TextLoopArray = TextLoopArray;
    CoinWeakSelf;
    XBTextLoopView *loopView = [XBTextLoopView textLoopViewWith:TextLoopArray loopInterval:3.0 initWithFrame:CGRectMake(self.imageView.xx, 0, kScreenWidth-105, 30) selectBlock:^(NSString *selectString, NSInteger index) {
        
        [weakSelf fastNewClickWithIndex:index];
    }];
    loopView.backgroundColor = RGB(252, 240, 240);;
    loopView.clipsToBounds = YES;
    [self.fastNews addSubview:loopView];
    loopView.centerY = self.imageView.centerY;
}
@end
