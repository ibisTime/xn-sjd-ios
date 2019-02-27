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
    self.itemsTitles = @[@"全部",@"待支付",@"已取消",@"待认养",@"认养中",@"已到期"];
    self.selectSV = [[SelectScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSuperViewHeight - kTabBarHeight) itemTitles:self.itemsTitles];
    [self.view addSubview:self.selectSV];
    
    for (NSInteger index = 0; index < self.itemsTitles.count; index ++) {
//        if (index == 0) {
            OrderView * bookview = [[OrderView alloc]init];
        switch (index) {
            case 0:
                bookview.status = @"";
                break;
            case 1:
                bookview.status = @"0";
                break;
            case 2:
                bookview.status = @"1";
                break;
            case 3:
                bookview.status = @"2";
                break;
            case 4:
                bookview.status = @"3";
                break;
            case 5:
                bookview.status = @"4";
                break;
            default:
                break;
        }
            [self addChildViewController:bookview];
            bookview.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:bookview.view];
//        }
    }
}



@end
