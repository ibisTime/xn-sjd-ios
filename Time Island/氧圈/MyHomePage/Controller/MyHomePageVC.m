//
//  MyHomePageVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/10.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MyHomePageVC.h"
#import "MyHomePageTableView.h"
#import "MyHomePageHeadView.h"
#define WIDTH SCREEN_WIDTH * 0.75
#import "MyCarbonBubbleVC.h"
#import "UIViewController+CWLateralSlide.h"
#import "MyGiftVC.h"
#import "TLNavigationController.h"

@interface MyHomePageVC ()<RefreshDelegate>
@property (nonatomic , strong)MyHomePageTableView *tableView;
@property (nonatomic , strong)MyHomePageHeadView *headView;
@end

@implementation MyHomePageVC

- (MyHomePageTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[MyHomePageTableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH * 0.75,SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kWhiteColor;
        //        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(MyHomePageHeadView *)headView
{
    if (!_headView) {
        _headView = [[MyHomePageHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.75, 169)];
        _headView.backgroundColor = kWhiteColor;
    }
    return _headView;
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSDictionary *DIC = @{@"row":@(indexPath.row)};
    NSNotification *notification =[NSNotification notificationWithName:@"SELECTROW" object:nil userInfo:DIC];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
//    if (indexPath.row == 0) {
//
//        MyCarbonBubbleVC *vc = [MyCarbonBubbleVC new];
//        TLNavigationController *nav = [[TLNavigationController alloc] initWithRootViewController:vc];
//        [self cw_pushViewController:vc];
////        [self cw_presentViewController:nav];
////        [self.navigationController pushViewController:vc animated:YES];
//    }
//    if (indexPath.row == 1) {
////        [self dismissViewControllerAnimated:YES completion:nil]
//        MyGiftVC *vc = [MyGiftVC new];
//        TLNavigationController *nav = [[TLNavigationController alloc] initWithRootViewController:vc];
////        [self presentViewController:vc animated:YES completion:nil];
//        [self cw_pushViewController:vc];
////        [self cw_presentViewController:nav];
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
    
}


@end
