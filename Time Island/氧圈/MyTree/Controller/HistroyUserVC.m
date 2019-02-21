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
#import "PersonalCenterVC.h"
#import "FriendsTheTreeVC.h"
#import "MyTreeVC.h"
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalCenterModel * model = self.PersonalCenterModels[indexPath.row];
    if ([model.user[@"userId"] isEqualToString:[TLUser user].userId]) {
        MyTreeVC * vc = [MyTreeVC new];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        FriendsTheTreeVC * vc = [FriendsTheTreeVC new];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
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
