//
//  BookListVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/18.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BookListVC.h"
#import "BookTableView.h"
#import "BoolVideoDetailVC.h"
#import "BookModel.h"
@interface BookListVC ()<RefreshDelegate>
@property (nonatomic , strong) BookTableView *tableView;
@property (nonatomic,strong) NSArray<BookModel * > * BookModel;
@end

@implementation BookListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    
    self.tableView = [[BookTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabBarHeight - GlobalRevenueListBottomHeight) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.refreshDelegate = self;
//    self.tableView.BookModel = self.BookModel;
//    self.tableView.scrollEnabled = NO;
//    CoinWeakSelf
//    [self.tableView addRefreshAction:^{
//        [weakSelf refresh];
//        [weakSelf.tableView reloadData];
//        [weakSelf.tableView endRefreshHeader];
//    }];
    [self.view addSubview:self.tableView];
    
    [self refresh];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BoolVideoDetailVC *detailavc = [[BoolVideoDetailVC alloc] init];
    detailavc.BookModel = self.BookModel[indexPath.row];
    detailavc.title =@"文章详情";
    [self.navigationController pushViewController:detailavc animated:YES];
}


-(void)refresh{
    CoinWeakSelf;
//    TLNetworking * http = [[TLNetworking alloc]init];
    TLPageDataHelper * http = [[TLPageDataHelper alloc]init];
    http.code = @"629345";
//    http.parameters[@"start"] = @(1);
//    http.parameters[@"limit"] = @(10);
    http.parameters[@"status"] = @(5);
    http.parameters[@"openLevel"] = @(1);
    http.parameters[@"orderDir"] = @"desc";
    switch (self.state) {
        case 0:
            http.parameters[@"orderColumn"] = @"publish_datetime";
            break;
        case 1:
            http.parameters[@"orderColumn"] = @"collect_count";
            break;
        case 2:
            http.parameters[@"orderColumn"] = @"publish_datetime";
            http.parameters[@"type"] = @(1);
            break;
        default:
            
            break;
    }
    if ([self.httpstate isEqualToString:@"tree"]) {
        http.parameters[@"treeNo"] = @"树木编号";
    }
    http.tableView = self.tableView;
    [http modelClass:[BookModel class]];
    http.isCurrency = YES;
    
    [self.tableView addRefreshAction:^{
        [http refresh:^(NSMutableArray *objs, BOOL stillHave) {
            if (objs.count > 0) {
                weakSelf.BookModel = objs;
                weakSelf.tableView.BookModel = objs;
            }
           
            [weakSelf.tableView reloadData];
            [weakSelf.tableView endRefreshHeader];
        } failure:^(NSError *error) {
            [weakSelf.tableView endRefreshHeader];
        }];
    }];
    [self.tableView addLoadMoreAction:^{
        [http loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            if (objs.count > 0) {
                weakSelf.BookModel = objs;
                weakSelf.tableView.BookModel = objs;
            }
            
            [weakSelf.tableView reloadData];
            [weakSelf.tableView endRefreshFooter];
        } failure:^(NSError *error) {
            [weakSelf.tableView endRefreshFooter];
        }];
    }];
    [self.tableView beginRefreshing];
//    [http postWithSuccess:^(id responseObject) {
//        self.BookModel = [BookModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
//        self.tableView.BookModel = self.BookModel;
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//    }];
}

@end
