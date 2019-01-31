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
    }
    return _headView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
    self.title = @"我的碳泡泡";
    
//    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//
//
//
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    negativeSpacer.width = -10;
//    [backBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
//    self.navigationItem.leftBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:backBtn]];
//    [backBtn setImage:kImage(@"返回白色") forState:(UIControlStateNormal)];
//    [backBtn addTarget:self action:@selector(backClick) forControlEvents:(UIControlEventTouchUpInside)];
}

//-(void)backClick
//{
//    [self cw_dismissViewController];
//}
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
