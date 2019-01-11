//
//  LineCircleVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/2.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "LinCircleVC.h"
#import "OxygenCircleView.h"
#import "MyTreeVC.h"
#import "MyHomePageVC.h"
//#import "CWScrollView.h"
//#import "CWTableViewInfo.h"
#import "UIViewController+CWLateralSlide.h"
#import "MyArticleViC.h"
@interface LinCircleVC ()<OxygenCircleDelegate>

@property (nonatomic , strong)OxygenCircleView *circleView;

@end

@implementation LinCircleVC

-(OxygenCircleView *)circleView
{
    if (!_circleView) {
        _circleView = [[OxygenCircleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - kTabBarHeight)];
        _circleView.delegate = self;
    }
    return _circleView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"氧圈";
    [self.view addSubview:self.circleView];
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setImage:kImage(@"氧圈分享") forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(myRecodeClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    __weak typeof(self)weakSelf = self;
    [self cw_registerShowIntractiveWithEdgeGesture:YES transitionDirectionAutoBlock:^(CWDrawerTransitionDirection direction) {
        if (direction == CWDrawerTransitionFromLeft) { // 左侧滑出
            [weakSelf defaultAnimationFromLeft];
        }
    }];
    
}

-(void)OxygenCircleButton:(NSInteger )tag
{
    switch (tag) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            MyTreeVC *vc = [MyTreeVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            MyArticleViC *vc = [MyArticleViC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            [self defaultAnimationFromLeft];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)defaultAnimationFromLeft
{
    MyHomePageVC *vc = [MyHomePageVC new];
    [self cw_showDefaultDrawerViewController:vc];
}

-(void)myRecodeClick
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
