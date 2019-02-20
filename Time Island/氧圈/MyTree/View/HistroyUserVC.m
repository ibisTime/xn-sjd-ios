//
//  HistroyUserVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/18.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "HistroyUserVC.h"
#import "PersonalCenterModel.h"
#import "HistoryUserCell.h"
#define historycell @"HistoryUserCell"
@interface HistroyUserVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) TLTableView * tableview;
@property (nonatomic , strong)NSMutableArray <PersonalCenterModel *> *PersonalCenterModels;
@end

@implementation HistroyUserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史认养人";
    self.view.backgroundColor = [UIColor whiteColor];
    [self getdata];
    
    self.tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    [self.tableview registerClass:[HistoryUserCell class] forCellReuseIdentifier:historycell];
    
    [self.view addSubview:self.tableview];
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.PersonalCenterModels.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryUserCell * cell = [tableView dequeueReusableCellWithIdentifier:historycell forIndexPath:indexPath];
    cell.PersonalCenterModel = self.PersonalCenterModels[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
-(void)getdata{
    TLNetworking * http = [TLNetworking new];
    http.code = @"629209";
    http.parameters[@"productCode"] = self.productCode;
    http.parameters[@"statusList"] = @[@(1),@(2),@(3)];
    [http postWithSuccess:^(id responseObject) {
        self.PersonalCenterModels = [PersonalCenterModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableview reloadData_tl];
    } failure:^(NSError *error) {
        
    }];
}

@end
