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
    if (indexPath.row == 0) {
        MyCarbonBubbleVC *vc = [MyCarbonBubbleVC new];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self cw_presentViewController:nav];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
    
}


@end
