//
//  MessageVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/12.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MessageVC.h"
#import "MessageModel.h"
#import "MessageCell.h"
#import <MJRefreshNormalHeader.h>
#import <MJRefreshBackNormalFooter.h>
#import "MessageDetailsVC.h"
@interface MessageVC ()<UITableViewDelegate,UITableViewDataSource,RefreshDelegate>
@property (nonatomic,strong) TLTableView * messagetable;
@property (nonatomic,assign) int start;
@property (nonatomic,strong) NSArray * array;
@property (nonatomic,strong) NSMutableArray<MessageModel *> * MessageModels;

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.start = 1;
    self.title = @"我的通知";
    TLTableView * table = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
    [table registerClass:[MessageCell class] forCellReuseIdentifier:@"cell"];
    table.delegate = self;
    table.dataSource = self;
    table.refreshDelegate = self;
    [self.view addSubview:table];
    self.messagetable = table;
//    [self headRefresh];
    [self refresh];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.MessageModels.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.MessageModel = self.MessageModels[indexPath.row];
    cell.selectionStyle = UIAccessibilityTraitNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageDetailsVC * vc = [MessageDetailsVC new];
    MessageModel * model = self.MessageModels[indexPath.row];
    vc.code = model.code;
    [self.navigationController pushViewController:vc animated:YES];
}
//-(void)headRefresh
//{
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    header.automaticallyChangeAlpha = YES;
//    header.lastUpdatedTimeLabel.hidden = YES;
//    header.stateLabel.hidden = YES;
//    self.messagetable.mj_header = header;
//    [self.messagetable.mj_header beginRefreshing];
//
//    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataFooter)];
//    footer.arrowView.hidden = YES;
//    footer.stateLabel.hidden = YES;
//    self.messagetable.mj_footer = footer;
//}
//-(void)loadNewData
//{
//    self.start = 1;
//    [self refresh];
//    [self.messagetable endRefreshHeader];
//}
//-(void)loadNewDataFooter
//{
//    self.start ++;
//    [self refresh];
//    [self.messagetable endRefreshFooter];
//}
-(void)refresh{
    CoinWeakSelf;
//    TLNetworking * http = [[TLNetworking alloc]init];
    TLPageDataHelper * http = [[TLPageDataHelper alloc]init];
    http.code = @"805305";
    http.parameters[@"start"] = @(self.start);
//    http.parameters[@"limit"] = @(10);
//    http.parameters[@"status"] = @(1);
    http.parameters[@"type"] = @(4);
    http.parameters[@"object"] = @"C";
    http.parameters[@"orderDir"] = @"desc";
    http.parameters[@"orderColumn"] = @"create_datetime";
    http.parameters[@"userId"] = [TLUser user].userId;
    http.tableView = self.messagetable;
    [http modelClass:[MessageModel class]];
    http.isCurrency = YES;
    
    [self.messagetable addRefreshAction:^{
        [http refresh:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.MessageModels = objs;
            [weakSelf.messagetable reloadData];
            [weakSelf.messagetable endRefreshHeader];
        } failure:^(NSError *error) {
            [weakSelf.messagetable endRefreshHeader];
        }];
    }];
    
    [self.messagetable addLoadMoreAction:^{
        [http loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.MessageModels = objs;
            [weakSelf.messagetable reloadData];
            [weakSelf.messagetable endRefreshFooter];
        } failure:^(NSError *error) {
            [weakSelf.messagetable endRefreshFooter];
        }];
    }];
    [self.messagetable beginRefreshing];
    
    
    
    
    
//    [http postWithSuccess:^(id responseObject) {
////        self.array = responseObject[@"data"][@"list"];
//        self.MessageModels = [MessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
//        [self.messagetable reloadData_tl];
//    } failure:^(NSError *error) {
//    }];
}

@end
