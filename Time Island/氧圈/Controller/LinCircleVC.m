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
#import "PersonalCenterVC.h"

#import "SettingVC.h"
#import "MessageVC.h"

#import "BookVC.h"

@interface LinCircleVC ()<OxygenCircleDelegate>

@property (nonatomic , strong)OxygenCircleView *circleView;
@property (nonatomic , strong)NSArray *array;
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
    [self refresh];
}


- (void)InfoNotificationAction:(NSNotification *)notification
{
    NSInteger row= [notification.userInfo[@"row"] integerValue];
    
    
    if (row == 0) {
        MyCarbonBubbleVC * vc = [MyCarbonBubbleVC new];
        vc.accountNumber = self.array[2][@"accountNumber"];
        vc.state = 2;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (row == 1) {
        MyGiftVC *vc = [MyGiftVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (row == 2) {
        MessageVC * vc = [MessageVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (row == 3) {
        SettingVC * vc = [SettingVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)refresh{
    TLNetworking * http1 = [[TLNetworking alloc]init];
    http1.code = @"802300";
    http1.parameters[@"userId"] = [TLUser user].userId;
    http1.parameters[@"start"] = @(1);
    http1.parameters[@"limit"] = @(10);
    //    [http1 postWithSuccess:^(id responseObject) {
    //        self.array = responseObject[@"data"][@"list"];}
    //     [http]
    [http1 postWithSuccess:^(id responseObject) {
        self.array = responseObject[@"data"][@"list"];
    } failure:^(NSError *error) {
    }];
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
            vc.state = @"rank";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            //            我的树
//            PersonalCenterVC *vc = [PersonalCenterVC new];
            MyTreeVC *vc = [MyTreeVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            RankingVC *vc = [RankingVC new];
            vc.state = @"friend";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            //            我的文字
//            MyArticleViC *vc = [MyArticleViC new];
            BookVC * vc = [BookVC new];
            
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
//    [self cw_pushViewController:vc];
    [self cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeDefault configuration:nil];
}

-(void)myRecodeClick
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
