//
//  NewsVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/21.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "NewsVC.h"
#import "NewsVCCell.h"
#import "MesModel.h"
#import "ServiceVC.h"
@interface NewsVC ()<UITableViewDelegate,UITableViewDataSource,RefreshDelegate>
@property (nonatomic,strong) TLTableView * table;
@property (nonatomic,strong) NSMutableArray<MesModel *> * MessageModels;
@end

@implementation NewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIBarButtonItem * item = [[UIBarButtonItem alloc]init];
//    item.title = @"消息";
//    self.navigationItem.backBarButtonItem = item;
    self.title = @"消息";
    self.table = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.table registerClass:[NewsVCCell class] forCellReuseIdentifier:@"newscell"];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.refreshDelegate = self;
    self.table.defaultNoDataImage = kImage(@"暂无订单");
    self.table.defaultNoDataText = @"抱歉，暂无消息";
    [self.view addSubview:self.table];
    [self connect];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.MessageModels.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"cell";
    
    NewsVCCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
        cell=[[NewsVCCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:rid];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.MessageModels[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceVC * vc = [[ServiceVC alloc]init];
    vc.user2 = self.MessageModels[indexPath.row].user2;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)connect{

    CoinWeakSelf;
    TLPageDataHelper * http = [TLPageDataHelper new];
    http.code = @"629785";
    http.parameters[@"user1"] = [TLUser user].userId;
    http.parameters[@"orderColumn"] = @"update_datetime";
    http.parameters[@"orderDir"] = @"desc";
    [http modelClass:[MesModel class]];
    http.tableView = self.table;
    http.isCurrency = YES;
    [self.table addRefreshAction:^{
        [http refresh:^(NSMutableArray *objs, BOOL stillHave) {
            if (objs.count > 0) {
                weakSelf.MessageModels = objs;
                [weakSelf.table reloadData];
                [weakSelf.table endRefreshHeader];
            }
            else
                [weakSelf.table endRefreshHeader];
        } failure:^(NSError *error) {
            [weakSelf.table endRefreshHeader];
        }];
    }];
    [self.table addLoadMoreAction:^{
        [http loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            if (objs.count > 0) {
                weakSelf.MessageModels = objs;
                [weakSelf.table reloadData];
                [weakSelf.table endRefreshFooter];
            }
            else
                [weakSelf.table endRefreshFooter];
        } failure:^(NSError *error) {
            [weakSelf.table endRefreshFooter];
        }];
    }];
    [self.table beginRefreshing];
}
@end
