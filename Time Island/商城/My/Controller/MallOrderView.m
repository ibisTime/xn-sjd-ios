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
#import "logisticeVC.h"
#import "MallGoodsModel.h"
#import "MallStoreListVC.h"
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
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    MallOrderCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (cell == nil) {
        cell = [[MallOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delagate = self;
    cell.model = self.MallOrderModels[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.logisticeBtn.tag = indexPath.section;
    cell.consignBtn.tag = indexPath.section;
    cell.ShopNameBtn.tag = indexPath.section;
    [cell.logisticeBtn addTarget:self action:@selector(lookPassway:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.consignBtn addTarget:self action:@selector(ReceiveGoods:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [cell.ShopNameBtn addTarget:self action:@selector(goshop:) forControlEvents:(UIControlEventTouchUpInside)];

    return cell;

}
-(void)goshop:(UIButton *)sender{
    MallStoreListVC * vc = [[MallStoreListVC alloc]init];
    vc.shopcode = self.MallOrderModels[sender.tag].shopCode;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)lookPassway:(UIButton *)sender{
    logisticeVC * vc = [[logisticeVC alloc]init];
    vc.expNo = self.MallOrderModels[sender.tag].logisticsNumber;
    vc.expCode = self.MallOrderModels[sender.tag].logisticsCompany;
    vc.photo = self.MallOrderModels[sender.tag].detailList[0][@"listPic"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)ReceiveGoods:(UIButton *)sender{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629724";
    http.parameters[@"receiver"] = [TLUser user].userId;
    http.parameters[@"shopCode"] = self.MallOrderModels[sender.tag].shopCode;
    http.parameters[@"code"] = self.MallOrderModels[sender.tag].code;
    [http postWithSuccess:^(id responseObject) {
        [self loadData];
    } failure:^(NSError *error) {
        
    }];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MallOrderModel * model = self.MallOrderModels[indexPath.section];
    if ([model.status isEqualToString:@"2"]) {
        return 50.5+90 * (model.detailList.count) + 40 + 45;
    }
    return 50.5+90 * (model.detailList.count) + 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MallOrderDetailVC *detailVC  = [MallOrderDetailVC new];
    detailVC.code = self.MallOrderModels[indexPath.section].code;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
-(void)MallOrderCell:(MallOrderCell *)tableViewCell clickDeleteButton:(UIButton *)sender{
    NSLog(@"%d",(int)sender.tag);
}
-(void)loadData{
    CoinWeakSelf;
    TLPageDataHelper * help = [TLPageDataHelper new];
    if (self.statusList) {
        help.code = @"629735";
    }else
        help.code = @"629725";
    
    if (self.status) {
        help.parameters[@"status"] = self.status;
        help.parameters[@"orderDir"] = @"desc";
        help.parameters[@"orderColumn"] = @"update_datetime";
    }
    else if (self.statusList) {
        help.parameters[@"statusList"] = self.statusList;
    }else{
        help.parameters[@"status"] = @"";
        help.parameters[@"orderDir"] = @"desc";
        help.parameters[@"orderColumn"] = @"update_datetime";
    }
    
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
