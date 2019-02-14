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
#import "RankModel.h"
#import "FriendsModel.h"
@interface RankingVC ()<RefreshDelegate>

@property (nonatomic , strong)RankingTableView *tableView;

@property (nonatomic,strong) NSMutableArray<RankModel * > * RankModels;
@property (nonatomic,strong) NSMutableArray<FriendsModel *> * FriendsModels;

@end

@implementation RankingVC

- (RankingTableView *)tableView {
    
    CoinWeakSelf
    if (!_tableView) {
        
        _tableView = [[RankingTableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH,SCREEN_HEIGHT -kNavigationBarHeight) style:UITableViewStyleGrouped];
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kBackgroundColor;
        [_tableView addRefreshAction:^{
            [weakSelf.tableView beginRefreshing];
            [weakSelf refresh];
            [weakSelf.tableView endRefreshHeader];
            
        }];
        //        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self refresh];
    
    [self.view addSubview:self.tableView];
    
    if ([self.state isEqualToString:@"rank"]) {
        self.title = @"排行榜";
    }
    else if ([self.state isEqualToString:@"friend"]){
        self.title = @"好友排行榜";
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
        [self.RightButton setTitle:@"好友审核" forState:(UIControlStateNormal)];
        //    [self.RightButton setImage:kImage(@"好友审核") forState:(UIControlStateNormal)];
        [self.RightButton addTarget:self action:@selector(myRecodeClick) forControlEvents:(UIControlEventTouchUpInside)];
    }

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

-(void)refresh{
    if ([self.state isEqualToString:@"rank"]) {
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"805159";
    http.parameters[@"start"] = @(1);
    http.parameters[@"limit"] = @(30);
    http.parameters[@"orderDir"] = @"asc";
    http.parameters[@"orderColumn"] = @"row_no";
    [http postWithSuccess:^(id responseObject) {
        self.RankModels = [RankModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        self.tableView.state = self.state;
         self.tableView.RankModels = self.RankModels;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
    }];
    }
    else if ([self.state isEqualToString:@"friend"]){
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"805157";
        http.parameters[@"start"] = @(1);
        http.parameters[@"limit"] = @(30);
        http.parameters[@"userId"] = [TLUser user].userId;
        http.parameters[@"orderDir"] = @"asc";
        http.parameters[@"orderColumn"] = @"row_no";
        [http postWithSuccess:^(id responseObject) {
            self.FriendsModels = [FriendsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            self.tableView.state = self.state;
            self.tableView.FriendsModels = self.FriendsModels;
            [self.tableView reloadData];
        } failure:^(NSError *error) {
        }];
    }
}

@end
