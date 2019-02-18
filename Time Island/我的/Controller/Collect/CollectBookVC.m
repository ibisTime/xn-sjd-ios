//
//  CollectBookVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "CollectBookVC.h"
#import "BookView.h"
#import "CollectTreeView.h"
#import "BookModel.h"
#import "BoolVideoDetailVC.h"
@interface CollectBookVC ()<RefreshDelegate>
@property (nonatomic,strong) BookView * bookview;
@property (nonatomic,strong) NSMutableArray<BookModel *> * BookModels;

@end

@implementation CollectBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CoinWeakSelf
    [self refresh];
    self.title = @"我的收藏";
    self.view.backgroundColor = kWhiteColor;
    self.bookview = [[BookView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight) style:UITableViewStyleGrouped];
    self.bookview.backgroundColor = kWhiteColor;
    self.bookview.refreshDelegate = self;
    [self.bookview addRefreshAction:^{
        [weakSelf.bookview beginRefreshing];
        [weakSelf refresh];
        [weakSelf.bookview endRefreshHeader];
    }];
    [self.view addSubview:self.bookview];
//    self.bookview = [BookView alloc]
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BoolVideoDetailVC *detailavc = [[BoolVideoDetailVC alloc] init];
    detailavc.BookModel = self.BookModels[indexPath.row];
    detailavc.state = @"collect";
    detailavc.title =@"文章详情";
    [self.navigationController pushViewController:detailavc animated:YES];
}

-(void)refresh{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629349";
    http.showView = self.view;
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        self.BookModels = [BookModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.bookview.BookModels = self.BookModels;
        [self.bookview reloadData];
    } failure:^(NSError *error) {
    }];
}



@end
