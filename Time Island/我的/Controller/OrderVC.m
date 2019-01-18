//
//  OrderVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "OrderVC.h"
#import "SelectScrollView.h"
#import "OrderView.h"

@interface OrderVC ()
@property (nonatomic , strong) SelectScrollView *selectSV;
@property (nonatomic,strong) NSArray * itemsTitles;
@end

@implementation OrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.itemsTitles = @[@"全部",@"待支付",@"已支付",@"已取消",@"已到期"];
    self.selectSV = [[SelectScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSuperViewHeight - kTabBarHeight) itemTitles:self.itemsTitles];
    [self.view addSubview:self.selectSV];
    
    for (NSInteger index = 0; index < self.itemsTitles.count; index ++) {
        if (index == 0) {
            OrderView * bookview = [[OrderView alloc]init];
            [self addChildViewController:bookview];
            bookview.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:bookview.view];
        }
    }
}



@end
