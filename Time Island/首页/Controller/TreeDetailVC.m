//
//  TreeDetailVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/9.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TreeDetailVC.h"

@interface TreeDetailVC ()<UIScrollViewDelegate>
@property (nonatomic ,strong) UIScrollView *contentScrollView;
@property (nonatomic ,strong) UIView *topView;
@property (nonatomic ,strong) UIView *placeHoldImage;
@property (nonatomic ,strong) UIView *moreImage;

@end

@implementation TreeDetailVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initScrollView];
    [self initTopView];
    [self initCustomButton];

}

- (void)initCustomButton
{
    UIView *placeHoldImage = [[UIView alloc] initWithFrame:CGRectMake(15, 25, 30, 30)];
    placeHoldImage.backgroundColor = kBlackColor;
    self.placeHoldImage = placeHoldImage;
    [self.topView addSubview:self.placeHoldImage];
    placeHoldImage.layer.cornerRadius = 15;
    placeHoldImage.clipsToBounds = YES;
    UIView *moreImage = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth-55, 25, 30, 30)];
    moreImage.backgroundColor = kBlackColor;
    self.moreImage = moreImage;
    [self.topView addSubview:self.moreImage];
    moreImage.layer.cornerRadius = 15;
    moreImage.clipsToBounds = YES;
    UIButton *backButton = [UIButton buttonWithImageName:@"返回"];
    UIButton *moreButton = [UIButton buttonWithImageName:@"返回"];
    backButton.frame = CGRectMake(15, 25, 30, 30);
    moreButton.frame = CGRectMake(kScreenWidth-55, 25, 30, 30);
    [self.view addSubview:backButton];
    [self.view addSubview:moreButton];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
  
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
    
}
- (void)initScrollView {
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -kStatusBarHeight, kScreenWidth, kScreenHeight-kNavigationBarHeight)];
    self.contentScrollView.delegate = self;
    [self.view addSubview:self.contentScrollView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 400)];
    imageView.image = kImage(@"baner1");
    [self.contentScrollView addSubview:imageView];
    UIView *newView  = [UIView new];
    newView.frame = CGRectMake(0, imageView.yy, kScreenWidth, kScreenHeight);
    [self.contentScrollView addSubview:newView];
    self.contentScrollView.contentSize = CGSizeMake(0, newView.yy+100);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    if (scrollView.contentOffset.y >0) {
    CGFloat TempAlpha = scrollView.contentOffset.y/kNavigationBarHeight;
        self.topView.alpha = 1-TempAlpha;
        if (scrollView.contentOffset.y > kNavigationBarHeight) {
            self.topView.alpha = 1;
        }
    }else{
        self.topView.alpha = 0.01;
    }
   
   
   
}
@end
