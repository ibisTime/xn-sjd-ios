//
//  RankingVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "RankingVC.h"
#import "RankingTableView.h"
#import "FriendRequestsVC.h"
#import "RankingModel.h"
@interface RankingVC ()<RefreshDelegate>

@property (nonatomic , strong)RankingTableView *tableView;

@property (nonatomic , strong)NSMutableArray <RankingModel *>*models;

@end

@implementation RankingVC

- (RankingTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[RankingTableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH,SCREEN_HEIGHT -kNavigationBarHeight) style:UITableViewStyleGrouped];
        
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kBackgroundColor;
        //        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"排行榜";
    
    
    [self.view addSubview:self.tableView];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:@"好友审核" forState:(UIControlStateNormal)];
//    [self.RightButton setImage:kImage(@"好友审核") forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(myRecodeClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self loadData];
}

-(void)loadData
{
    CoinWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"805159";
    helper.parameters[@"userId"] = [TLUser user].userId;
    helper.parameters[@"orderDir"] = @"asc";
    helper.parameters[@"orderColumn"] = @"row_no";
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[RankingModel class]];
    
    [self.tableView addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            NSMutableArray <RankingModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                RankingModel *model = (RankingModel *)obj;
                [shouldDisplayCoins addObject:model];
            }];

            weakSelf.models = shouldDisplayCoins;
            [weakSelf.tableView.models removeAllObjects];
            [weakSelf.tableView reloadData];
            weakSelf.tableView.models = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];
        } failure:^(NSError *error) {
            
        }];
    }];
    [self.tableView addLoadMoreAction:^{

        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            NSMutableArray <RankingModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                RankingModel *model = (RankingModel *)obj;
                [shouldDisplayCoins addObject:model];
            }];
            weakSelf.models = shouldDisplayCoins;
            
            weakSelf.tableView.models = shouldDisplayCoins;
            //        weakSelf.tableView.bills = objs;
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
        }];
    }];
    [self.tableView beginRefreshing];
}

-(void)myRecodeClick
{
    FriendRequestsVC *vc = [FriendRequestsVC new];
    [self.navigationController pushViewController:vc animated:YES];
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
