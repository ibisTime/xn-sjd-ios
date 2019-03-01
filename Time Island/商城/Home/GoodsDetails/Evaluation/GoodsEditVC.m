//
//  GoodsEditVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "GoodsEditVC.h"
#import "AllCommentTB.h"
#import "GoodsEditModel.h"
#import "GoodsEditTableView.h"
#import "EvaluationModel.h"

@interface GoodsEditVC ()<RefreshDelegate>
@property (nonatomic , strong)NSMutableArray <EvaluationModel *>*evaluationModel;
@property (nonatomic , strong)GoodsEditTableView *tableView;
@end

@implementation GoodsEditVC

- (GoodsEditTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[GoodsEditTableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, kSuperViewHeight - kTabBarHeight - 45) style:UITableViewStyleGrouped];
        
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kBackgroundColor;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self initDetailView];
    self.tableView.defaultNoDataImage = kImage(@"暂无订单");
    self.tableView.defaultNoDataText = @"抱歉，暂无评论";
    [self.view addSubview:self.tableView];
    [self loadData];
    
    // Do any additional setup after loading the view.
}

- (void)loadData{
    CoinWeakSelf;
    TLPageDataHelper * http = [TLPageDataHelper new];
    http.code = @"629755";
    http.parameters[@"statusList"] = @[@"D",@"B"];
    http.parameters[@"commodityCode"] = self.model.code;
    [http modelClass:[EvaluationModel class]];
    http.showView = self.view;
    http.tableView = self.tableView;
    http.isCurrency = YES;
    [self.tableView addRefreshAction:^{
        [http refresh:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.tableView.evaluationModel = objs;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView endRefreshHeader];
        } failure:^(NSError *error) {
            [weakSelf.tableView endRefreshHeader];
        }];
    }];
    [self.tableView addLoadMoreAction:^{
        [http loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.tableView.evaluationModel = objs;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView endRefreshFooter];
        } failure:^(NSError *error) {
            [weakSelf.tableView endRefreshFooter];
        }];
    }];
    [self.tableView beginRefreshing];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
