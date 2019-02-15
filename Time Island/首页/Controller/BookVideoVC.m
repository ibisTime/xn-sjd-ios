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
#import "BookListVC.h"
#import "IssueBook.h"
@interface BookVideoVC ()
@property (nonatomic , strong) SelectScrollView *selectSV;
@property (nonatomic , strong) NSArray *itemsTitles;

@end

@implementation BookVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"情感频道";
    
    if ([self.state isEqualToString:@"tree"]) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
        [self.RightButton setImage:kImage(@"编辑") forState:(UIControlStateNormal)];
        [self.RightButton addTarget:self action:@selector(myRecodeClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    [self initBookTag];
}

- (void)initBookTag{
    self.itemsTitles = @[@"按发布时间排序",@"按收藏数排序",@"只看官方推文"];
    self.selectSV = [[SelectScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSuperViewHeight - kTabBarHeight) itemTitles:self.itemsTitles];
    [self.view addSubview:self.selectSV];
    
    for (NSInteger index = 0; index < self.itemsTitles.count; index ++) {
        if (index == 0) {
            BookListVC *activity = [[BookListVC alloc] init];
            activity.state = 0;
            activity.httpstate = self.state;
            [self addChildViewController:activity];
            activity.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:activity.view];
        }else if (index == 1)
        {
            BookListVC *activity = [[BookListVC alloc] init];
            activity.state = 1;
            activity.httpstate = self.state;
            [self addChildViewController:activity];
            activity.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:activity.view];
        }else{
            BookListVC *activity = [[BookListVC alloc] init];
            activity.state = 2;
            activity.httpstate = self.state;
            [self addChildViewController:activity];
            activity.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:activity.view];
        }
        
    }
}

-(void)myRecodeClick{
    NSLog(@"%s",__func__);
    IssueBook * issue = [IssueBook new];
    issue.model = self.model;
    issue.state = self.state;
    [self.navigationController pushViewController:issue animated:YES];
}

@end
