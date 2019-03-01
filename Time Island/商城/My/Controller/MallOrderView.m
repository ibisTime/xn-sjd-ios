//
//  MallOrderView.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/21.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallOrderView.h"
#import "MallOrderCell.h"
#import "MallOrderDetailVC.h"
#import "MallOrderModel.h"
@interface MallOrderView ()<MallOrderCellDelegrate>
@property (nonatomic,strong) TLTableView * table;
@property (nonatomic,strong) NSMutableArray<MallOrderModel *> * MallOrderModels;

@end

@implementation MallOrderView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.table = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 40)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.refreshDelegate = self;
    self.table.defaultNoDataImage = kImage(@"暂无订单");
    self.table.defaultNoDataText = @"还没有商品订单哦";
    [self.table registerClass:[MallOrderCell class] forCellReuseIdentifier:@"mallordercell"];
    [self.view addSubview:self.table];
    [self loadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.MallOrderModels.count;
//    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    MallOrderModel * model = self.MallOrderModels[section];
//    return model.detailList.count;
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *rid=<#rid#>;
    static NSString *CellIdentifier = @"Cell";
    MallOrderCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (cell == nil) {
        cell = [[MallOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delagate = self;
    cell.model = self.MallOrderModels[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MallOrderModel * model = self.MallOrderModels[indexPath.section];
    return 50.5+90 * (model.detailList.count) + 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MallOrderDetailVC *detailVC  = [MallOrderDetailVC new];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
-(void)MallOrderCell:(MallOrderCell *)tableViewCell clickDeleteButton:(UIButton *)sender{
    NSLog(@"%d",(int)sender.tag);
}
-(void)loadData{
    CoinWeakSelf;
    TLPageDataHelper * help = [TLPageDataHelper new];
    help.code = @"629725";
    
    if (self.status) {
        help.parameters[@"status"] = self.status;
    }else{
        help.parameters[@"status"] = @"";
    }
    help.parameters[@"orderDir"] = @"desc";
    help.parameters[@"orderColumn"] = @"update_datetime";
    help.parameters[@"applyUser"] = [TLUser user].userId;
    [help modelClass:[MallOrderModel class]];
    help.tableView = self.table;
    help.isCurrency = YES;
    [self.table addRefreshAction:^{
        [help refresh:^(NSMutableArray *objs, BOOL stillHave) {
            if (objs.count > 0) {
                weakSelf.MallOrderModels = objs;
                [weakSelf.table reloadData];
                [weakSelf.table endRefreshHeader];
            }
            [weakSelf.table endRefreshHeader];
        } failure:^(NSError *error) {
            [weakSelf.table endRefreshHeader];
        }];
    }];
    [self.table addLoadMoreAction:^{
        [help loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            if (objs.count>0) {
                weakSelf.MallOrderModels = objs;
                [weakSelf.table reloadData];
                [weakSelf.table endRefreshFooter];
            }
            [weakSelf.table endRefreshFooter];
        } failure:^(NSError *error) {
            [weakSelf.table endRefreshFooter];
        }];
    }];
    [self.table beginRefreshing];
}
@end
