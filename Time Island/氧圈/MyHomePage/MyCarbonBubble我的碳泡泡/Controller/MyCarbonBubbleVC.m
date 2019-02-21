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
#import "RulesVC.h"
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
//    [self.tableView addRefreshAction:^{
//        [weakSelf.tableView beginRefreshing];
        [weakSelf refresh];
//        [weakSelf.tableView endRefreshHeader];
//    }];
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
//    [self.RightButton setImage:kImage(@"氧圈分享") forState:(UIControlStateNormal)];
    if (self.state == 1) {
        [self.RightButton setTitle:@"积分规则" forState:(UIControlStateNormal)];
    }
    else if(self.state == 2)
    {
        [self.RightButton setTitle:@"碳泡泡规则" forState:(UIControlStateNormal)];
    }
    [self.RightButton addTarget:self action:@selector(myRecodeClick) forControlEvents:(UIControlEventTouchUpInside)];
    
}
-(void)myRecodeClick{
    NSLog(@"%s",__func__);
    RulesVC * vc = [RulesVC new];
    vc.state = self.state;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)refresh{
    

    CoinWeakSelf;

    
    
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"802322";
    helper.parameters[@"accountNumber"] = self.accountNumber;
    [helper modelClass:[CarbonModel class]];
    helper.tableView = self.tableView;
    helper.isCurrency = YES;

    
    [self.tableView addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
//            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//            }];
            if (objs.count > 0) {
                weakSelf.CarbonModels = objs;
                weakSelf.tableView.CarbonModels = weakSelf.CarbonModels;
                [weakSelf.tableView reloadData];
            }

//            [weakSelf.tableView reloadData];
            [weakSelf.tableView reloadData_tl];
        } failure:^(NSError *error) {
            
        }];
    }];
    [self.tableView addLoadMoreAction:^{
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            if (objs.count > 0) {
                weakSelf.CarbonModels = objs;
                weakSelf.tableView.CarbonModels = weakSelf.CarbonModels;
                [weakSelf.tableView reloadData];
            }
            [weakSelf.tableView reloadData_tl];
        } failure:^(NSError *error) {
            
        }];
    }];

    [self.tableView beginRefreshing];
}



@end
