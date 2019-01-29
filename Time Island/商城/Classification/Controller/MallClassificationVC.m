//
//  MallClassificationVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/18.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MallClassificationVC.h"
#import "QWCategoryCommon.h"
#import "QWCategoryMenuController.h"
#import "QWCategoryDetailController.h"
@interface MallClassificationVC ()
// 分类主菜单（必须设为全局的）
@property (nonatomic, strong) QWCategoryMenuController *categoryMenuVC;
// 详细分类列表
@property (nonatomic, strong) QWCategoryDetailController *categoryDetailVC;
@end

@implementation MallClassificationVC

#pragma mark - 懒加载
- (QWCategoryMenuController *)categoryMenuVC {
    
    if (_categoryMenuVC == nil) {
        _categoryMenuVC = [[QWCategoryMenuController alloc] init];
    }
    
    return _categoryMenuVC;
}

- (QWCategoryDetailController *)categoryDetailVC {
    
    if (_categoryDetailVC == nil) {
        _categoryDetailVC = [[QWCategoryDetailController alloc] init];
    }
    
    return _categoryDetailVC;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品分类";
    self.view.backgroundColor = [UIColor whiteColor];

    // 2. 添加分类主菜单
    [self addCategoryMenuView];
    
    // 3. 添加详细分类列表
    [self addCategoryDetailCollectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 恢复tabBar
    self.hidesBottomBarWhenPushed = NO;
}



#pragma mark - 扫一扫
- (void)scanQRCode:(UIButton *)button {
    
    
}

#pragma mark - 添加一级分类菜单
- (void)addCategoryMenuView {
    
    
    // 计算分类主菜单视图尺寸
    CGFloat x = 0;
    CGFloat y = 0;//self.navigationController.navigationBar.frameHeight + SCStatusBarHeight;
    CGFloat width = kWidth(95);
    CGFloat height = self.view.height - y;
    
    self.categoryMenuVC.tableView.frame = CGRectMake(x, y, width, height);
    [self.view addSubview:_categoryMenuVC.tableView];
     [_categoryMenuVC.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - 添加详细分类列表
- (void)addCategoryDetailCollectionView {
    
    // 计算详细分类列表视图尺寸
    CGFloat x = CGRectGetMaxX(self.categoryMenuVC.tableView.frame)+5;
    CGFloat y = self.categoryMenuVC.tableView.y;
    CGFloat width = self.view.width - kWidth(95)-10;
    CGFloat height = self.view.height - y;
    
    self.categoryDetailVC.view.frame = CGRectMake(x, y, width, height);
    
    [self.view addSubview:_categoryDetailVC.view];
    self.categoryMenuVC.detailVC = self.categoryDetailVC;
}
@end
