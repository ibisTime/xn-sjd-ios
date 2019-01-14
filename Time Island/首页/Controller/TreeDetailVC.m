//
//  TreeDetailVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/9.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TreeDetailVC.h"
#import "SelectScrollView.h"
#import "TreeFieldVC.h"
#import "TreeRenYangVC.h"
#import "TreeInfoView.h"
#import "TreeBottomView.h"
#import "TeamView.h"
#import "RenYangFieldView.h"
#import "RenYangFieldDeyailView.h"
#import "RealNameView.h"
@interface TreeDetailVC ()<UIScrollViewDelegate>
@property (nonatomic ,strong) UIScrollView *contentScrollView;
@property (nonatomic ,strong) UIView *topView;
@property (nonatomic ,strong) UIView *placeHoldImage;
@property (nonatomic ,strong) UIView *moreImage;
@property (nonatomic ,strong) UILabel *titleLable;
@property (nonatomic , strong) SelectScrollView *selectSV;
@property (nonatomic , strong) UIImageView *imageView;
@property (nonatomic , strong) NSArray *itemsTitles;
@property (nonatomic , strong) TreeInfoView *infoView;
@property (nonatomic , strong) TeamView *teamView;
@property (nonatomic , strong) RenYangFieldView *renYangFieldView;
@property (nonatomic , strong) TreeBottomView *bottomView;
@property (nonatomic , strong) RenYangFieldDeyailView *renYangFieldDeyailView;

@property (nonatomic , strong) RealNameView *realNameView;

@end

@implementation TreeDetailVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initScrollView];
    [self initTopView];
    [self initCustomButton];
    [self initFlats];
    [self initBottomView];
    self.renYangFieldView = [[RenYangFieldView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 500)];
    self.renYangFieldView.backgroundColor = [UIColor blackColor];
    self.renYangFieldView.alpha = 0.7;
    [self initcustomRenYang];
}
- (void)initcustomRenYang
{
        CoinWeakSelf;
    self.renYangFieldDeyailView = [[RenYangFieldDeyailView alloc] initWithFrame:CGRectMake(0, 300, kScreenWidth, 500)];
    self.renYangFieldDeyailView.sureBlock = ^{
        [UIView animateWithDuration:0.01 animations:^{
            weakSelf.renYangFieldView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
            [weakSelf.view sendSubviewToBack:weakSelf.renYangFieldView];
            weakSelf.renYangFieldDeyailView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
            [weakSelf.view sendSubviewToBack:weakSelf.renYangFieldDeyailView];
            [weakSelf initRealNameView];

        }];

    };
}

- (void)initRealNameView
{

    self.realNameView = [[RealNameView alloc] initWithFrame:CGRectMake(20,150, kScreenWidth-40, 300)];
    [self.view addSubview:self.realNameView];
    
}
- (void)initBottomView
{
    self.bottomView = [[TreeBottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight-kTabBarHeight, kScreenWidth, kTabBarHeight)];
    [self.view addSubview:self.bottomView];
    CoinWeakSelf;
    self.bottomView.RenYangBlock = ^(NSInteger index) {
        NSLog(@"%ld",index);
        [weakSelf bottomClickWithIndex:index];
    };
}

- (void)bottomClickWithIndex:(NSInteger)index
{
    [self.view addSubview:self.renYangFieldView];
    [self.view addSubview:self.renYangFieldDeyailView];

//    [self.contentScrollView bringSubviewToFront:self.renYangFieldView];
//    [self.contentScrollView bringSubviewToFront:self.renYangFieldDeyailView];

    [UIView animateWithDuration:0.2 animations:^{
     self.renYangFieldView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.renYangFieldDeyailView.frame = CGRectMake(0, 300, kScreenWidth, kScreenHeight-300);

    }];
}

- (void)initFlats
{
    self.infoView = [[TreeInfoView alloc] initWithFrame:CGRectMake(0, self.imageView.yy+5, kScreenWidth, 44)];
    [self.contentScrollView addSubview:self.infoView];
    
    self.teamView = [[TeamView alloc] initWithFrame:CGRectMake(0, self.infoView.yy+5, kScreenWidth, 100)];
    [self.contentScrollView addSubview:self.teamView];
    
    self.itemsTitles = @[@"图文详情",@"数目参数",@"认养记录"];
    self.selectSV = [[SelectScrollView alloc] initWithFrame:CGRectMake(0, self.teamView.yy, kScreenWidth, kSuperViewHeight - kTabBarHeight) itemTitles:self.itemsTitles];
    [self.contentScrollView addSubview:self.selectSV];
    self.contentScrollView.contentSize = CGSizeMake(0,  self.selectSV.yy+100);

    for (NSInteger index = 0; index < self.itemsTitles.count; index ++) {
        if (index == 0) {
            TreeRenYangVC *activity = [[TreeRenYangVC alloc] init];
            [self addChildViewController:activity];
            activity.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:activity.view];
        }else if (index == 1)
        {
            TreeFieldVC *activity = [[TreeFieldVC alloc] init];
            [self addChildViewController:activity];
            activity.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:activity.view];
        }else{
            TreeRenYangVC *activity = [[TreeRenYangVC alloc] init];
            [self addChildViewController:activity];
            activity.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:activity.view];
        }
        
    }
    
}

- (void)initCustomButton
{
    UIView *placeHoldImage = [[UIView alloc] initWithFrame:CGRectMake(15, kStatusBarHeight, 30, 30)];
    placeHoldImage.backgroundColor = kBlackColor;
    self.placeHoldImage = placeHoldImage;
    [self.topView addSubview:self.placeHoldImage];
    placeHoldImage.layer.cornerRadius = 15;
    placeHoldImage.clipsToBounds = YES;
    placeHoldImage.centerY = self.titleLable.centerY;
    UIView *moreImage = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth-55, kStatusBarHeight, 30, 30)];
    moreImage.backgroundColor = kBlackColor;
    self.moreImage = moreImage;
//    [self.topView addSubview:self.moreImage];
    moreImage.layer.cornerRadius = 15;
    moreImage.clipsToBounds = YES;
    moreImage.centerY = self.titleLable.centerY;

    UIButton *backButton = [UIButton buttonWithImageName:@"返回"];
    UIButton *moreButton = [UIButton buttonWithImageName:@""];
    backButton.frame = CGRectMake(15, kStatusBarHeight, 30, 30);
    moreButton.frame = CGRectMake(kScreenWidth-55, kStatusBarHeight, 30, 30);
    [self.view addSubview:backButton];
//    [self.view addSubview:moreButton];
    backButton.centerY = self.titleLable.centerY;
    moreButton.centerY = self.titleLable.centerY;
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
  
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   
    
    CGPoint point = [[touches anyObject] locationInView:self.view];
    point = [self.renYangFieldView.layer convertPoint:point fromLayer:self.view.layer];
    if (point.y >300) {
        return;
    }
    [UIView animateWithDuration:0.01 animations:^{
        self.renYangFieldView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
        [self.view sendSubviewToBack:self.renYangFieldView];
        self.renYangFieldDeyailView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
        [self.view sendSubviewToBack:self.renYangFieldDeyailView];
    }];
    
    
}

- (void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)initTopView
{
    UIView *topView = [UIView new];
    self.topView = topView;
    topView.frame = CGRectMake(0, 0, kScreenWidth, kNavigationBarHeight);
    topView.backgroundColor = kAppCustomMainColor;
    [self.view addSubview:topView];
    topView.alpha = 0.01;

    UILabel *titleLable = [UILabel labelWithBackgroundColor:kClearColor textColor:kWhiteColor font:18];
    [topView addSubview:titleLable];
    titleLable.frame = CGRectMake((kScreenWidth-100)/2, 20, 100, 44);
    titleLable.text = @"古树详情";
    self.titleLable = titleLable;
    
}
- (void)initScrollView {
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -kStatusBarHeight, kScreenWidth, kScreenHeight+kStatusBarHeight)];
    self.contentScrollView.delegate = self;
    [self.view addSubview:self.contentScrollView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 355)];
    imageView.image = kImage(@"baner1");
    self.imageView = imageView;
    [self.contentScrollView addSubview:imageView];
    UIView *newView  = [UIView new];
    newView.frame = CGRectMake(0, imageView.yy, kScreenWidth, kScreenHeight);
    [self.contentScrollView addSubview:newView];
    self.contentScrollView.contentSize = CGSizeMake(0, newView.yy+100);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (self.realNameView.frame.size.height >10) {
        self.realNameView.hidden = YES;
    }
    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    if (scrollView.contentOffset.y >0) {
    CGFloat TempAlpha = scrollView.contentOffset.y/kNavigationBarHeight;
        self.topView.alpha = TempAlpha;
        if (scrollView.contentOffset.y > kNavigationBarHeight) {
            self.topView.alpha = 1;
        }
    }else{
        self.topView.alpha = 0.01;
    }
   
   
   
}
@end
