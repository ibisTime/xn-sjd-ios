//
//  MallHomeHeadView.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/18.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallHomeHeadView.h"
#import "TLBannerView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SLBannerView.h"
@interface MallHomeHeadView()<SLBannerViewDelegate>
{
    NSInteger selectNum;
}

//轮播图
@property (nonatomic,strong) TLBannerView *bannerView;

@property (nonatomic, strong) UIView *statisticsView;

@property (nonatomic, strong) UILabel *dataLbl;

@property (nonatomic, strong) UIView *applicationView;

@property (nonatomic, strong) UIButton *tempBtn;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic,strong) UIImageView * image;

@property (nonatomic,strong) SLBannerView * banner;

@end
@implementation MallHomeHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
//        [self setupImage];
        [self addSubview:self.banner];

//        [self initSearchBar];
//        [self SetupClassify];
    }
    return self;
}
-(void)setupImage{
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 185)];
    image.image = kImage(@"邮政银行");
    [self addSubview:image];
    self.image = image;
}
-(void)SetupClassify{
//    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, self.scrollView.yy, SCREEN_WIDTH, 115)];
//    [self addSubview:view];
//    self.ClassifyView = view;
    NSArray * ClassifyName = @[@"分类一",@"分类二",@"分类三",@"分类四",@"分类五"];
    CGFloat marge = (SCREEN_WIDTH - 45 * 5) / 6;
    
    [ClassifyName enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton * btn = [UIButton buttonWithTitle:@"" titleColor:kTextColor backgroundColor:kClearColor titleFont:12];
        [btn setTitleColor:kTextColor forState:UIControlStateNormal];
        [btn setBackgroundImage:kImage(ClassifyName[idx]) forState:normal];
        [btn setTitleColor:kAppCustomMainColor forState:UIControlStateNormal];
        btn.frame = CGRectMake(idx*marge+marge+idx*45, self.image.yy + 22, 45, 45);
        [self addSubview:btn];
        
        UILabel * title = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(0, 0, 0) font:12];
        title.frame = CGRectMake(btn.xx, btn.yy + 10, 45, 16.5);
        title.centerX = btn.centerX;
        title.text = ClassifyName[idx];
        title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:title];
        
        btn.tag = idx + 100;
        [btn addTarget:self action:@selector(ClassifyClick : ) forControlEvents:UIControlEventTouchUpInside];

    }];
}
- (void)initSearchBar {
    UISearchBar * searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(14.5, 12, kScreenWidth-30, 31.0f)];
    searchbar.layer.cornerRadius = 15.5;
    searchbar.clipsToBounds = YES;
    searchbar.delegate = self;
    [searchbar setAccessibilityElementsHidden:YES];
    searchbar.alpha = 0.89;
    [searchbar setBackgroundColor:kWhiteColor];
    [searchbar setTintColor:[UIColor lightGrayColor]];
    [searchbar setPlaceholder:@"搜索商品"];
    [self.image addSubview:searchbar];
    self.searchBar = searchbar;
    
    UITextField *searchField = [searchbar valueForKey:@"searchField"];
    
    if (searchField) {
        [[[[searchbar.subviews objectAtIndex : 0 ] subviews ] objectAtIndex : 0 ] removeFromSuperview ];
        
        searchbar.backgroundColor = kWhiteColor;
        
        
        [searchField setBackgroundColor:[UIColor whiteColor]];
        [searchField setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
        
        searchField.layer.cornerRadius = 15.5;//设置圆角具体根据实际情况来设置
        searchField.font =FONT(11);
        
        searchField.clipsToBounds = YES;
    }
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
            
            [imgUrls addObject:[obj.pic convertImageUrl]];
        }
    }];
    _banner.slImages = imgUrls;
    
}


-(void)ClassifyClick : (UIButton * )btn{
//    NSLog(@"%d",(int)btn.tag);
}
@end
