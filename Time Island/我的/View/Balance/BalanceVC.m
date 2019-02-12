//
//  BalanceVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/11.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BalanceVC.h"
#import "BalanceView.h"
#import "CarbonModel.h"
#import "BalanceTableView.h"
#import "GetMoneyVC.h"
#import "PostMoneyVC.h"
@interface BalanceVC ()<RefreshDelegate,BalanceViewDelegate>
@property (nonatomic , strong)BalanceView *headView;
@property (nonatomic,strong) NSMutableArray<CarbonModel *> * CarbonModels;
@property (nonatomic , strong)BalanceTableView *tableView;
@end

@implementation BalanceVC
-(BalanceTableView *)tableView{
    if (!_tableView) {
        _tableView = [[BalanceTableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH,SCREEN_HEIGHT -kNavigationBarHeight) style:UITableViewStyleGrouped];
        
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kWhiteColor;
        //        [self.view addSubview:_tableView];
        [self refresh];
    }
    return _tableView;
}

-(BalanceView *)headView{
    if (!_headView) {
        _headView = [[BalanceView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
        _headView.backgroundColor = kWhiteColor;
        _headView.currentLbl.text = @"当前余额";
        _headView.delegate = self;
        
    }
    return _headView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    CoinWeakSelf
    self.headView.ClickBtn = ^(NSInteger t) {
        if (t == 1) {
            [weakSelf getmoney];
        }
        else{
            [weakSelf postmoney];
        }
    };
    self.tableView.tableHeaderView = self.headView;

    [self.tableView addRefreshAction:^{
        [weakSelf.tableView beginRefreshing];
        [weakSelf refresh];
        [weakSelf.tableView endRefreshHeader];
    }];
    // Do any additional setup after loading the view.
}
-(void)getmoney{
    NSLog(@"%s",__func__);
    GetMoneyVC * vc = [GetMoneyVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)postmoney{
    NSLog(@"%s",__func__);
    PostMoneyVC * vc = [PostMoneyVC new];
    [self.navigationController pushViewController:vc animated:YES];
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
-(void)BtnClick:(NSInteger)sender{
    NSLog(@"%s",__func__);
}

@end
