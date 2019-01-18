//
//  CollectVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "CollectVC.h"
#import "SelectScrollView.h"
#import "TreeRenYangVC.h"
#import "TreeFieldVC.h"
#import "CollectBookVC.h"
#import "CollectTreeVC.h"
@interface CollectVC ()
@property (nonatomic , strong) SelectScrollView *selectSV;
@property (nonatomic , strong) NSArray *itemsTitles;
@end

@implementation CollectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    [self initBookTag];
}

- (void)initBookTag{
    self.itemsTitles = @[@"文章",@"古树"];
    self.selectSV = [[SelectScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSuperViewHeight - kTabBarHeight) itemTitles:self.itemsTitles];
    [self.view addSubview:self.selectSV];
    
    for (NSInteger index = 0; index < self.itemsTitles.count; index ++) {
        if (index == 0) {
            CollectBookVC * bookview = [[CollectBookVC alloc]init];
            [self addChildViewController:bookview];
            bookview.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight - 40);
            [self.selectSV.scrollView addSubview:bookview.view];
        }else if (index == 1)
        {
            CollectTreeVC * view = [[CollectTreeVC alloc]init];
            [self addChildViewController:view];
            view.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight - 40);
            [self.selectSV.scrollView addSubview:view.view];
     }
    }
}


@end
