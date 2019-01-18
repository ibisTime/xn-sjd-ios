//
//  MallBaseVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/18.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MallBaseVC.h"
#import "UIColor+theme.h"
#import "AppColorMacro.h"
@interface MallBaseVC ()

@end

@implementation MallBaseVC

{
    
    UILabel *_placeholderTitleLbl;
    UIButton *_opBtn;
    
}

-(UIButton *)RightButton
{
    if (!_RightButton) {
        _RightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        //        _RightButton.frame = CGRectMake(0, 0, 44, 44);
        _RightButton.height = 44;
        _RightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _RightButton.titleLabel.font = FONT(15);
        [_RightButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    }
    return _RightButton;
}

-(UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];

        _backBtn.height = 44;
        [_backBtn setImage:kImage(@"返回白色") forState:(UIControlStateNormal)];
        _backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    }
    return _backBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //
    //
    [self.navigationController.navigationItem setHidesBackButton:NO];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: kWhiteColor} forState:UIControlStateNormal];
    
    
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"返回白色"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"返回白色"];


//    if (@available(iOS 11.0, *)) {
//
//        //将title 文字的颜色改为透明
//
//    }else {
//
//        //隐藏返回按钮的文字
//
//        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsCompact];
//
//    }
    
    self.navigationController.navigationBar.barTintColor = kHexColor(@"#333333");
}

-(void)setBackStr:(NSString *)backStr
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:backStr style:UIBarButtonItemStylePlain target:nil action:nil];
    //    //设置backBarButtonItem即可
    self.navigationItem.backBarButtonItem = backItem;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

// 如果tableview在视图最底层 默认会偏移电池栏的高度
- (void)setViewEdgeInset {
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setTitle:(NSString *)title {
    
    self.navigationItem.titleView = [UILabel labelWithTitle:title frame:CGRectMake(0, 0, 200, 44)];
}
////隐藏底部横条
//- (BOOL)prefersHomeIndicatorAutoHidden {
//
//    return YES;
//}

- (void)removePlaceholderView {
    
    if (self.tl_placeholderView) {
        
        [self.tl_placeholderView removeFromSuperview];
        
    }
    
}

- (void)addPlaceholderView{
    
    if (self.tl_placeholderView) {
        
        [self.view addSubview:self.tl_placeholderView];
        
    }
    
}

- (void)setPlaceholderViewTitle:(NSString *)title  operationTitle:(NSString *)opTitle {
    
    if (self.tl_placeholderView) {
        
        _placeholderTitleLbl.text = title;
        [_opBtn setTitle:opTitle forState:UIControlStateNormal];
        
    } else {
        
        UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
        view.backgroundColor = self.view.backgroundColor;
        UILabel *lbl = [UILabel labelWithFrame:CGRectMake(0, 100, view.width, 50) textAligment:NSTextAlignmentCenter backgroundColor:[UIColor clearColor] font:[UIFont systemFontOfSize:15] textColor:[UIColor textColor]];
        [view addSubview:lbl];
        lbl.text = title;
        _placeholderTitleLbl = lbl;
        
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, lbl.yy + 10, 200, 40)];
        [self.view addSubview:btn];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor textColor] forState:UIControlStateNormal];
        btn.centerX = view.width/2.0;
        btn.layer.cornerRadius = 5;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor textColor].CGColor;
        [btn addTarget:self action:@selector(tl_placeholderOperation) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:opTitle forState:UIControlStateNormal];
        [view addSubview:btn];
        _opBtn = btn;
        _tl_placeholderView = view;
        
    }
    
}






#pragma mark- 站位操作
- (void)tl_placeholderOperation {
    
    if ([self isMemberOfClass:NSClassFromString(@"TLBaseVC")]) {
        
        NSLog(@"子类请重写该方法");
        
    }
    
}


//- (UIStatusBarStyle)preferredStatusBarStyle {
//
//    return UIStatusBarStyleLightContent;
//
//}

-(void)navigationwhiteColor
{
    self.navigationController.navigationBar.translucent = NO; self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]};
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"返回白色"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"返回白色"];
    self.navigationItem.backBarButtonItem = item;
    //    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
//
-(void)navigationTransparentClearColor
{
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"返回白色"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"返回白色"];
    //    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    //    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

}

-(void)navigationSetDefault
{
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"返回白色"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"返回白色"];

    self.navigationController.navigationBar.barTintColor = kHexColor(@"#333333");
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    //    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
