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
#import "RankingVC.h"
#import "MyCarbonBubbleVC.h"
#import "MyGiftVC.h"
#import "MyNoticeVC.h"
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"SELECTROW" object:nil];
    
}


- (void)InfoNotificationAction:(NSNotification *)notification
{
    NSInteger row= [notification.userInfo[@"row"] integerValue];
    
    
    if (row == 0) {
        
        MyCarbonBubbleVC *vc = [MyCarbonBubbleVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (row == 1) {
        MyGiftVC *vc = [MyGiftVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (row == 2) {
        MyNoticeVC *vc = [MyNoticeVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SELECTROW" object:nil];
}


-(void)OxygenCircleButton:(NSInteger )tag
{
    switch (tag) {
        case 0:
        {
            //
            RankingVC *vc = [RankingVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            //            我的树
            MyTreeVC *vc = [MyTreeVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            RankingVC *vc = [RankingVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            //            我的文字
            MyArticleViC *vc = [MyArticleViC new];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            //            点击头像
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
    //    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    //    [self cw_showDefaultDrawerViewController:vc];
    
    [self cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeDefault configuration:nil];
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
