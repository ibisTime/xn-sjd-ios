//
//  CollectTreeVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "CollectTreeVC.h"
#import "CollectTreeView.h"
#import "CollectTreeModel.h"
@interface CollectTreeVC ()<RefreshCollectionViewDelegate>
@property (nonatomic,strong) CollectTreeView *topView;
@property (nonatomic, strong) NSMutableArray <CollectTreeModel *>*models;//树models
@property (nonatomic, strong) UIScrollView *contentScrollew;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) NSArray *mutableArray;
@end

@implementation CollectTreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCollection];
    // Do any additional setup after loading the view.
}

- (void)initCollection
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.itemSize = CGSizeMake((kScreenWidth-45)/2, 250);
    layout.itemSize = CGSizeMake((kScreenWidth-45)/2, 210);
    
    layout.minimumLineSpacing = 15.0; // 竖
    layout.minimumInteritemSpacing = 15.0; // 横
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    
    
    
    CollectTreeView *topView = [[CollectTreeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabBarHeight - 40) collectionViewLayout:layout withImage:@[@""]];
    self.topView = topView;
    topView.refreshDelegate = self;
    self.topView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    self.topView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    [self.view addSubview:topView];
    //    topView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMoreNews)];
    
    UIView *lineView = [[UIView alloc] init];
    self.bottomLine = lineView;
    CGFloat f = CGRectGetMaxY(topView.frame);
    lineView.frame = CGRectMake(0, f, kScreenWidth, 10);
    [self.contentScrollew addSubview:lineView];
    lineView.backgroundColor = kHexColor(@"#F5F5F5");
    
    CollectTreeModel *mineModel = [CollectTreeModel new];
    mineModel.Description = @"描述描述";
    mineModel.avgChange = @"1000";
    mineModel.bestChange = @"2000";
    mineModel.worstChange = @"500";
    mineModel.name = @"产品1";
    CollectTreeModel *mineModel1 = [CollectTreeModel new];
    mineModel1.Description = @"描述描述2";
    mineModel1.avgChange = @"10000";
    mineModel1.bestChange = @"20000";
    mineModel1.worstChange = @"5000";
    mineModel1.name = @"产品2";
    CollectTreeModel *mineModel2 = [CollectTreeModel new];
    mineModel2.Description = @"描述描述";
    mineModel2.avgChange = @"100000";
    mineModel2.bestChange = @"200000";
    mineModel2.worstChange = @"50000";
    mineModel2.name = @"产品3";
    mineModel2.Description = @"描述描述3";
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:mineModel];
    [arr addObject:mineModel1];
    [arr addObject:mineModel2];
    [arr addObject:mineModel];
    [arr addObject:mineModel2];
    [arr addObject:mineModel1];
    [arr addObject:mineModel2];
    [arr addObject:mineModel];
    [arr addObject:mineModel1];
    
    self.topView.models = arr;
    [self.topView reloadData];
}

@end
