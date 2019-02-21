//
//  MyNoticeVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/15.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MyNoticeVC.h"
#import "MyNoticeTableView.h"
#import "MyNoticeDetailsVC.h"
#import "NoticeModel.h"
#import <MJRefreshNormalHeader.h>
#import <MJRefreshBackNormalFooter.h>
@interface MyNoticeVC ()<RefreshDelegate>

@property (nonatomic , strong)MyNoticeTableView *tableView;
@property (nonatomic,strong) NSMutableArray<NoticeModel *> * NoticeModels;
@property (nonatomic,assign) int start;

@end

@implementation MyNoticeVC

- (MyNoticeTableView *)tableView {
//    [self refresh];
    
    if (!_tableView) {
        
        _tableView = [[MyNoticeTableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH,SCREEN_HEIGHT -kNavigationBarHeight) style:UITableViewStyleGrouped];
        
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kWhiteColor;
       
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    self.title = @"公告";
    [self refresh];
//    self.start = 1;
//    [self headRefresh];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyNoticeDetailsVC *vc = [MyNoticeDetailsVC new];
    vc.model = self.NoticeModels[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)headRefresh
//{
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    header.automaticallyChangeAlpha = YES;
//    header.lastUpdatedTimeLabel.hidden = YES;
//    header.stateLabel.hidden = YES;
//    _tableView.mj_header = header;
//    [_tableView.mj_header beginRefreshing];
//
//    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataFooter)];
//    footer.arrowView.hidden = YES;
//    footer.stateLabel.hidden = YES;
//    _tableView.mj_footer = footer;
//}

//-(void)loadNewData
//{
//    self.start = 1;
//    [self refresh];
//    [_tableView endRefreshHeader];
//}
//-(void)loadNewDataFooter
//{
//    self.start ++;
//    [self refresh];
//    [_tableView endRefreshFooter];
//}
-(void)refresh{
    CoinWeakSelf
//    TLNetworking * http = [[TLNetworking alloc]init];
//    http.code = @"805305";
//    http.parameters[@"start"] = @(self.start);
//    http.parameters[@"limit"] = @(10);
//    http.parameters[@"status"] = @"1";
//    http.parameters[@"type"] = @"3";
//    http.parameters[@"object"] = @"C";
//    [http postWithSuccess:^(id responseObject) {
//        self.NoticeModels = [NoticeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
//         weakSelf.tableView.NoticeModels = self.NoticeModels;
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//    }];
    
    
    
    TLPageDataHelper * help = [[TLPageDataHelper alloc]init];
    help.code = @"805305";
    help.parameters[@"status"] = @"1";
    help.parameters[@"type"] = @"3";
    help.parameters[@"object"] = @"C";
    help.tableView = self.tableView;
    [help modelClass:[NoticeModel class]];
    help.isCurrency = YES;
    
    [self.tableView addRefreshAction:^{
        [help refresh:^(NSMutableArray *objs, BOOL stillHave) {
            if (objs.count > 0) {
                weakSelf.NoticeModels = objs;
                weakSelf.tableView.NoticeModels = weakSelf.NoticeModels;
                
                [weakSelf.tableView reloadData];
                [weakSelf.tableView endRefreshHeader];
            }
        } failure:^(NSError *error) {
            [weakSelf.tableView endRefreshHeader];
        }];
    }];
    [self.tableView addLoadMoreAction:^{
        [help loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            if (objs.count > 0) {
                weakSelf.NoticeModels = objs;
                weakSelf.tableView.NoticeModels = weakSelf.NoticeModels;
                [weakSelf.tableView reloadData];
                [weakSelf.tableView endRefreshHeader];
            }
        } failure:^(NSError *error) {
            [weakSelf.tableView endRefreshFooter];
        }];
    }];
    
    [self.tableView beginRefreshing];
}

@end
