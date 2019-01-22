//
//  MallGoodDetailVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallGoodDetailVC.h"
#import "PushSelectScrollView.h"
#import "MallGoodIntroduceVC.h"
#import "MallGoodDetailView.h"
#import "MallCommentTB.h"
#import "GoodsDetailWebView.h"
#import "GoodsEditVC.h"
#import "GoodsBottomView.h"
@interface MallGoodDetailVC ()<RefreshDelegate>
@property (nonatomic , strong) PushSelectScrollView *selectSV;

@property (nonatomic,strong) NSArray * itemsTitles;

@property (nonatomic,strong) MallGoodDetailView * detailView;

@property (nonatomic,strong) MallCommentTB * commentTB;

@property (nonatomic,strong) UIScrollView * contentView;

@property (nonatomic,strong) GoodsBottomView * bottomView;

@end

@implementation MallGoodDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    self.itemsTitles = @[@"商品",@"图文详情",@"评价"];
    self.selectSV = [[PushSelectScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSuperViewHeight - kTabBarHeight) itemTitles:self.itemsTitles];
    [self.view addSubview:self.selectSV];
    [self initBottomView];
    for (NSInteger index = 0; index < self.itemsTitles.count; index ++) {
        if (index == 0) {
            MallGoodIntroduceVC * bookview = [[MallGoodIntroduceVC alloc] init];
            bookview.title = self.itemsTitles[index];
            [self addChildViewController:bookview];
            bookview.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:bookview.view];
        }else if (index ==1)
        {
            GoodsDetailWebView * bookview = [[GoodsDetailWebView alloc] init];
            bookview.title = self.itemsTitles[index];
            [self addChildViewController:bookview];
            bookview.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:bookview.view];
        }else{
            GoodsEditVC * bookview = [[GoodsEditVC alloc] init];
            bookview.title = self.itemsTitles[index];
            [self addChildViewController:bookview];
            bookview.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:bookview.view];
        }
    }
    [self initBottomView];

}

- (void)initDetailView
{
    self.detailView = [[MallGoodDetailView alloc] initWithFrame:CGRectMake(0, 45, kScreenWidth, kSuperViewHeight - kTabBarHeight-(kHeight(40+30+10)))];
    [self.view addSubview:self.detailView];
    self.commentTB = [[MallCommentTB alloc] initWithFrame:CGRectMake(0, self.detailView.yy, kScreenWidth, kScreenHeight)];
    [self.view addSubview:self.commentTB];
    self.commentTB.refreshDelegate = self;
    CoinWeakSelf;
    self.commentTB.clickMoreBlock = ^{
        [weakSelf loadMoreComment];
    };
    
}

- (void)initBottomView
{
    self.bottomView = [[GoodsBottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight-kTabBarHeight-kNavigationBarHeight, kScreenWidth, kTabBarHeight)];
    [self.view addSubview:self.bottomView];
    CoinWeakSelf;
    self.bottomView.clickMoreBlock = ^(NSInteger inter) {
        [weakSelf clickWithTag:inter];
    };
    
}
- (void)clickWithTag:(NSInteger)inter
{
    switch (inter) {
        case 1:
            //点击店铺
            break;
        case 2:
            //点击客服

            break;
        case 3:
            //点击加入购物车

            break;
        case 4:
            //点击加入购买

            break;
        default:
            break;
    }
    
}
- (void)loadMoreComment
{
    
    
}
@end
