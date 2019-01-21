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
    self.itemsTitles = @[@"全部",@"待支付",@"已支付",@"已取消",@"已到期"];
    self.selectSV = [[SelectScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSuperViewHeight - kTabBarHeight) itemTitles:self.itemsTitles];
    [self.view addSubview:self.selectSV];
    
    for (NSInteger index = 0; index < self.itemsTitles.count; index ++) {
        if (index == 0) {
            MallOrderView * bookview = [[MallOrderView alloc]init];
            [self addChildViewController:bookview];
            bookview.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:bookview.view];
        }
    }
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
