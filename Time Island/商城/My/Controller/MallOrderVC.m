//
//  MallOrderVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/21.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallOrderVC.h"
#import "SelectScrollView.h"
#import "MallOrderView.h"
@interface MallOrderVC ()
@property (nonatomic , strong) SelectScrollView *selectSV;
@property (nonatomic,strong) NSArray * itemsTitles;
@end

@implementation MallOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单";
    self.itemsTitles = @[@"全部",@"待付款",@"代发货",@"代收货",@"待评价",@"已完成",@"已取消",@"退款/售后"];
    self.selectSV = [[SelectScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSuperViewHeight - kTabBarHeight) itemTitles:self.itemsTitles];
    [self.view addSubview:self.selectSV];
    
    for (NSInteger index = 0; index < self.itemsTitles.count; index ++) {
        if (index == 0) {
            MallOrderView * bookview = [[MallOrderView alloc]init];
            [self addChildViewController:bookview];
            bookview.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:bookview.view];
        }
        else if (index == 1) {
            MallOrderView * bookview = [[MallOrderView alloc]init];
            bookview.status = @"0";
            [self addChildViewController:bookview];
            bookview.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:bookview.view];
        }
        else if (index == 2) {
            MallOrderView * bookview = [[MallOrderView alloc]init];
            bookview.status = @"1";
            [self addChildViewController:bookview];
            bookview.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:bookview.view];
        }
        else if (index == 3) {
            MallOrderView * bookview = [[MallOrderView alloc]init];
            bookview.status = @"2";
            [self addChildViewController:bookview];
            bookview.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:bookview.view];
        }
        else if (index == 4){
            MallOrderView * bookview = [[MallOrderView alloc]init];
            bookview.status = @"3";
            [self addChildViewController:bookview];
            bookview.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:bookview.view];
        }
        else if (index == 5) {
            MallOrderView * bookview = [[MallOrderView alloc]init];
            bookview.status = @"4";
            [self addChildViewController:bookview];
            bookview.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:bookview.view];
        }
        else if (index == 6){
            MallOrderView * bookview = [[MallOrderView alloc]init];
            bookview.status = @"5";
            [self addChildViewController:bookview];
            bookview.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:bookview.view];
        }
        else if (index == 7){
            MallOrderView * bookview = [[MallOrderView alloc]init];
            bookview.statusList = @[@"2",@"3"];
            [self addChildViewController:bookview];
            bookview.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:bookview.view];
        }
    }
}



@end
