//
//  RulesVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/21.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "RulesVC.h"
#import "RulesTableView.h"
#import "RulesModel.h"
@interface RulesVC ()<RefreshDelegate>
@property (nonatomic,strong) RulesTableView * tableview;
//@property (nonatomic,strong) NSMutableArray * RulesArray;
@property (nonatomic,strong) NSMutableArray<RulesModel *> * RulesModels;
@end

@implementation RulesVC
-(RulesTableView *)tableview{
    if (!_tableview) {
        _tableview = [[RulesTableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH,SCREEN_HEIGHT -kNavigationBarHeight) style:UITableViewStyleGrouped];
        
        _tableview.refreshDelegate = self;
        _tableview.backgroundColor = kWhiteColor;
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.state == 1) {
        self.title = @"积分规则";
    }
    else if(self.state == 2)
    {
         self.title = @"碳泡泡规则";
    }
    [self getRules];
    [self.view addSubview:self.tableview];
}

-(void)getRules{
//    TLPageDataHelper * help = [[TLPageDataHelper alloc]init];
//    help.code = @"630045";
//    if (self.state == 1) {
//        help.parameters[@"type"] = @"JF_RULE";
//    }
//    else if(self.state == 2)
//    {
//        help.parameters[@"type"] = @"TPP_RULE";
//    }
//    help.tableView = self.tableview;

    TLNetworking * http = [[TLNetworking alloc]init];
    http.showView = self.view;
    http.code = @"630045";
    if (self.state == 1) {
        http.parameters[@"type"] = @"JF_RULE";
    }
    else if(self.state == 2)
    {
        http.parameters[@"type"] = @"TPP_RULE";
    }
    http.parameters[@"start"] = @(1);
    http.parameters[@"limit"] = @(10);
    [http postWithSuccess:^(id responseObject) {
//        self.RulesArray = responseObject[@"data"][@"list"];
//        self.tableview.RulesArray = self.RulesArray;
        self.RulesModels = [RulesModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        self.tableview.RulesModels = self.RulesModels;
        [self.tableview reloadData];
    } failure:^(NSError *error) {
        
    }];

}

@end
