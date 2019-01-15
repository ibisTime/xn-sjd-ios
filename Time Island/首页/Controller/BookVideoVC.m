//
//  BookVideoVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/14.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BookVideoVC.h"
#import "SelectScrollView.h"
#import "TreeRenYangVC.h"
#import "TreeFieldVC.h"

@interface BookVideoVC ()
@property (nonatomic , strong) SelectScrollView *selectSV;
@property (nonatomic , strong) NSArray *itemsTitles;

@end

@implementation BookVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBookTag];
}

- (void)initBookTag{
    self.itemsTitles = @[@"按发布时间排序",@"按收藏树排序",@"只看官方推文"];
    self.selectSV = [[SelectScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSuperViewHeight - kTabBarHeight) itemTitles:self.itemsTitles];
    [self.view addSubview:self.selectSV];
    
    for (NSInteger index = 0; index < self.itemsTitles.count; index ++) {
        if (index == 0) {
            TreeRenYangVC *activity = [[TreeRenYangVC alloc] init];
            [self addChildViewController:activity];
            activity.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:activity.view];
        }else if (index == 1)
        {
            TreeRenYangVC *activity = [[TreeRenYangVC alloc] init];
            [self addChildViewController:activity];
            activity.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:activity.view];
        }else{
            TreeRenYangVC *activity = [[TreeRenYangVC alloc] init];
            [self addChildViewController:activity];
            activity.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:activity.view];
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
