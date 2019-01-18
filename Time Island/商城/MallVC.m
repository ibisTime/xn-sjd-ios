//
//  MallVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/2.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallVC.h"
#import "TLTabBarController.h"
//#import "MallHomeHeaderView.h"
@interface MallVC ()
//@property (nonatomic ,strong) MallHomeHeaderView *headerView;
@end

@implementation MallVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barTintColor = kBlackColor;
}

-(void)viewDidAppear:(BOOL)animated
{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商场";
    [UIBarButtonItem addLeftItemWithImageName:@"返回白色" frame:CGRectMake(-10, 0, 44, 40) vc:self action:@selector(backButtonClick)];
    [self initHeaderView];
}

- (void)initHeaderView
{
//    self.headerView = [[MallHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(190))];
//    [self.view addSubview:self.headerView];
    
    
}
- (void)backButtonClick
{
    TLTabBarController *tab = [[TLTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tab;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
