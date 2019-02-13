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
    [self.view addSubview:self.tableView];
    [self loadData];
    
    // Do any additional setup after loading the view.
}

- (void)loadData{
    TLNetworking *http = [TLNetworking new];
    http.code = @"629755";
    http.parameters[@"start"] = @"1";
    http.parameters[@"limit"] = @"10";
    http.parameters[@"statusList"] = @[@"D",@"B"];
    http.parameters[@"commodityCode"] = self.treeModel.code;
    //    http.parameters[@"code"] = self.code;
    [http postWithSuccess:^(id responseObject) {
        self.evaluationModel = [EvaluationModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        NSLog(@"%@",responseObject);
        self.tableView.evaluationModel = self.evaluationModel;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
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
