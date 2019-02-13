//
//  MyCarbonBubbleVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MyCarbonBubbleVC.h"
#import "MyCarbonBubbleTableView.h"

#import "MyCarbombubbleView.h"
#import "CarbonModel.h"
@interface MyCarbonBubbleVC ()<RefreshDelegate>

@property (nonatomic , strong)MyCarbonBubbleTableView *tableView;

@property (nonatomic , strong)MyCarbombubbleView *headView;
@property (nonatomic,strong) NSMutableArray<CarbonModel *> * CarbonModels;

@end

@implementation MyCarbonBubbleVC

- (MyCarbonBubbleTableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[MyCarbonBubbleTableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH,SCREEN_HEIGHT -kNavigationBarHeight) style:UITableViewStyleGrouped];
        
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kWhiteColor;
        //        [self.view addSubview:_tableView];
        [self refresh];
    }
    return _tableView;
}

-(MyCarbombubbleView *)headView
{
    if (!_headView) {
        _headView = [[MyCarbombubbleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
        _headView.backgroundColor = kWhiteColor;
        if (self.state == 1) {
            self.title = @"积分";
            _headView.currentLbl.text = @"积分";
            _headView.state = 1;
        }
        else if(self.state == 2)
        {
            self.title = @"我的碳泡泡";
             _headView.currentLbl.text = @"我的碳泡泡";
            _headView.state = 2;
        }
    }
    return _headView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
    CoinWeakSelf
    [self.tableView addRefreshAction:^{
        [weakSelf.tableView beginRefreshing];
        [weakSelf refresh];
        [weakSelf.tableView endRefreshHeader];
    }];
//    self.title = @"我的碳泡泡";
}

-(void)refresh{
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"802322";
    http.parameters[@"accountNumber"] = self.accountNumber;
    http.parameters[@"start"] = @(1);
    http.parameters[@"limit"] = @(10);
    [http postWithSuccess:^(id responseObject) {
        self.CarbonModels = [CarbonModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        self.tableView.CarbonModels = self.CarbonModels;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
    }];
}


@end
