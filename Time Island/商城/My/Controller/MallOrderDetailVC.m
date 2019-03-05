//
//  MallOrderDetailVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallOrderDetailVC.h"
#import "MallOrderDetailTB.h"
#import "OrderAddressView.h"
#import "OrderDetailView.h"
#import "ViewExpressVC.h"
#import "JudgeViewController.h"
#import "MallOrderModel.h"
#import "MallGoodsModel.h"
#import "MallGoodDetailVC.h"
 #import "RefundVC.h"
@interface MallOrderDetailVC ()<RefreshDelegate>
@property (nonatomic ,strong) MallOrderDetailTB *tableView;

@property (nonatomic ,strong) UIScrollView *contentView;

@property (nonatomic ,strong)  UILabel *statusLab;

@property (nonatomic ,strong)  UILabel *orderAddressView;

@property (nonatomic ,strong) OrderAddressView *addressView;

@property (nonatomic ,strong) OrderDetailView *detailView;

@property (nonatomic,strong) MallOrderModel * model;
@property (nonatomic,strong) MallGoodsModel * GoodsModel;
@end

@implementation MallOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
//    [self initContentView];
//    [self initCustomView];
//    [self initTableView];
//    [self initBottomView];
}
- (void)initCustomView
{
    UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight(135))];
    top.backgroundColor = kWhiteColor;
    [self.contentView addSubview:top];
    UIImageView *topImage = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-48)/2, (kHeight(135)-48)/2, 48, 48)];
//    topImage.image = kImage(@"订单过期");
    [self.contentView addSubview:topImage];
    UILabel *statusLab = [UILabel labelWithFrame:CGRectMake((kScreenWidth-150)/2, topImage.yy+10, 150, 22) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(15) textColor:kBlackColor];
    [statusLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [self.contentView addSubview:statusLab];
    self.statusLab = statusLab;
//    statusLab.text = @"订单待收货";
    int status = [self.model.status intValue];
    switch (status) {
        case 1:{
            topImage.image = kImage(@"订单待收货");
            self.statusLab.text= @"订单待收货";
        }
            break;
        case 5:{
            topImage.image = kImage(@"订单待收货");
            self.statusLab.text= @"订单已取消";
        }
            break;
        default:
            break;
    }
    
    
    
    OrderAddressView *addressView = [OrderAddressView new];
    addressView.frame = CGRectMake(0, top.yy, kScreenWidth, kHeight(78+20));
    [self.contentView addSubview:addressView];
    self.addressView = addressView;
    
    
}
- (void)initContentView
{
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavigationBarHeight)];
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

- (void)initTableView
{
//    MallOrderDetailTB *tableView = [[MallOrderDetailTB alloc] initWithFrame:CGRectMake(0, self.addressView.yy, kScreenWidth, kScreenHeight-kNavigationBarHeight)];
    MallOrderDetailTB *tableView = [[MallOrderDetailTB alloc] initWithFrame:CGRectMake(0, self.addressView.yy, kScreenWidth, 40 + 100 * self.model.detailList.count)];
    tableView.scrollEnabled = NO;
    tableView.refreshDelegate = self;
    [self.contentView addSubview:tableView];
    self.tableView = tableView;
//    self.tableView.frame = CGRectMake(0, self.addressView.yy, kScreenWidth, kHeight(3*100));
    self.tableView.frame = CGRectMake(0, self.addressView.yy, kScreenWidth, 40 + 163 * self.model.detailList.count);
    
    
}
- (void)initBottomView {
    OrderDetailView *detail = [[OrderDetailView alloc] initWithFrame:CGRectMake(0, self.tableView.yy, kScreenWidth, kHeight(310 - 28))];
    self.detailView = detail;
    [self.contentView addSubview:detail];
    self.contentView.contentSize = CGSizeMake(0, detail.yy+100);
    CoinWeakSelf;
    detail.clickBtnBlock = ^(NSInteger inter) {
        [weakSelf clickBottomWithIndex:inter];
    };

}

- (void)clickBottomWithIndex :(NSInteger)inter
{
    if (inter == 2) {
        JudgeViewController *judge = [JudgeViewController new];
        judge.title = @"发布评价";
        [self.navigationController pushViewController:judge animated:YES];
        return;
    }
    ViewExpressVC *expressVC = [ViewExpressVC new];
    expressVC.title = @"查看物流";
    [self.navigationController pushViewController:expressVC animated:YES];
}

-(void)loadData{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.showView = self.view;
    http.code = @"629726";
    http.parameters[@"code"] = self.code;
    [http postWithSuccess:^(id responseObject) {
        self.model = [MallOrderModel mj_objectWithKeyValues:responseObject[@"data"]];
        

        [self initContentView];
        [self initCustomView];
        [self initTableView];
        [self initBottomView];
        
        self.tableView.model = self.model;
        [self loadValue];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)loadValue{
    self.addressView.nameLbl.text = self.model.receiver;
    self.addressView.phoneLbl.text = self.model.receiverMobile;
    self.addressView.addressLbl.text = [NSString stringWithFormat:@"%@ %@ %@ %@",self.model.province,self.model.city,self.model.district,self.model.detailAddress];
    
    self.detailView.orderTime.text = [self.model.updateDatetime convertToDetailDate];
    self.detailView.OrderID.text = self.model.code;
    if ([self.model.postalFee isEqualToString:@"0"]) {
        self.detailView.orderMoney.text = [NSString stringWithFormat:@"¥%.2f(%.2f)",[self.model.payAmount floatValue]/1000,[self.model.amount floatValue]/1000];
    }
    else{
        self.detailView.orderMoney.text = [NSString stringWithFormat:@"¥%.2f(%.2f+邮费(%.2f))",[self.model.payAmount floatValue]/1000,[self.model.amount floatValue]/1000,[self.model.postalFee floatValue]/1000];
    }
//    self.detailView.orderMoney.text = [NSString stringWithFormat:@"%.2f",[self.model.payAmount floatValue] / 1000];
    
    
    self.detailView.seller.text = self.model.sellersName;
    if ([self.model.payType isEqualToString:@"1"]) {
        self.detailView.payType.text = @"余额支付";
    }
//    [self.model.remark substringToIndex:self.model.remark.length - 2];
    self.detailView.payID.text = self.model.jourCode;
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.showView = self.view;
    http.code= @"629707";
    http.parameters[@"code"] = self.model.detailList[0][@"commodityCode"];
    [http postWithSuccess:^(id responseObject) {
        self.GoodsModel = [MallGoodsModel mj_objectWithKeyValues:responseObject[@"data"]];
        MallGoodDetailVC * vc = [MallGoodDetailVC new];
        vc.MallGoodsModel = self.GoodsModel;
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {
        
    }];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index{
    if ([self.model.detailList[index][@"afterSaleStatus"] isEqualToString:@"2"]) {
        [TLAlert alertWithTitle:@"提示" msg:@"是否取消售后" confirmMsg:@"是" cancleMsg:@"否" maker:self cancle:^(UIAlertAction *action) {
            
        } confirm:^(UIAlertAction *action) {
            NSLog(@"1234567890");
            TLNetworking * http = [[TLNetworking alloc]init];
            http.code = @"629722";
            http.parameters[@"code"] = self.model.detailList[index][@"orderCode"];
            http.parameters[@"updater"] = [TLUser user].userId;
            [http postWithSuccess:^(id responseObject) {
                [self.navigationController popViewControllerAnimated:YES];
            } failure:^(NSError *error) {
                
            }];
        }];
    }
    else{
        RefundVC * vc = [RefundVC new];
        vc.code = self.model.detailList[index][@"code"];
        vc.money = self.model.detailList[index][@"amount"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
