//
//  MyNoticeVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/15.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MyNoticeVC.h"
#import "MyNoticeTableView.h"
#import "MyNoticeDetailsVC.h"
#import "NoticeModel.h"
@interface MyNoticeVC ()<RefreshDelegate>

@property (nonatomic , strong)MyNoticeTableView *tableView;
@property (nonatomic,strong) NSMutableArray<NoticeModel *> * NoticeModels;
@end

@implementation MyNoticeVC

- (MyNoticeTableView *)tableView {
//    [self refresh];
    
    if (!_tableView) {
        
        _tableView = [[MyNoticeTableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH,SCREEN_HEIGHT -kNavigationBarHeight) style:UITableViewStyleGrouped];
        
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kWhiteColor;
       
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refresh];
    [self.view addSubview:self.tableView];
    self.title = @"公告";
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyNoticeDetailsVC *vc = [MyNoticeDetailsVC new];
    vc.model = self.NoticeModels[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refresh{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"805305";
    http.parameters[@"start"] = @(1);
    http.parameters[@"limit"] = @(10);
    http.parameters[@"status"] = @"1";
    http.parameters[@"type"] = @"3";
    http.parameters[@"object"] = @"C";
    [http postWithSuccess:^(id responseObject) {
        self.NoticeModels = [NoticeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        
         _tableView.NoticeModels = self.NoticeModels;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
    }];
}
@end
