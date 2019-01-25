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
@interface MallOrderDetailVC ()
@property (nonatomic ,strong) MallOrderDetailTB *tableView;

@property (nonatomic ,strong) UIScrollView *contentView;

@property (nonatomic ,strong)  UILabel *statusLab;

@property (nonatomic ,strong)  UILabel *orderAddressView;

@property (nonatomic ,strong) OrderAddressView *addressView;

@property (nonatomic ,strong) OrderDetailView *detailView;

@end

@implementation MallOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContentView];
    [self initCustomView];
    [self initTableView];
    [self initBottomView];
}
- (void)initCustomView
{
    UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight(135))];
    top.backgroundColor = kWhiteColor;
    [self.contentView addSubview:top];
    UIImageView *topImage = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-48)/2, (kHeight(135)-48)/2, 48, 48)];
    topImage.image = kImage(@"订单过期");
    [self.contentView addSubview:topImage];
    UILabel *statusLab = [UILabel labelWithFrame:CGRectMake((kScreenWidth-150)/2, topImage.yy+10, 150, 22) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(15) textColor:kBlackColor];
    [statusLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [self.contentView addSubview:statusLab];
    self.statusLab = statusLab;
    statusLab.text = @"订单待收货";
    
    OrderAddressView *addressView = [OrderAddressView new];
    addressView.frame = CGRectMake(0, top.yy, kScreenWidth, kHeight(78+20));
    [self.contentView addSubview:addressView];
    self.addressView = addressView;
    addressView.nameLbl.text = @"测试人员";
    addressView.phoneLbl.text = @"15566566556";
    addressView.addressLbl.text = [NSString stringWithFormat:@"%@ %@ %@ %@",@"浙江",@"杭州",@"余杭",@"中国人工智能小镇"];
    
}
- (void)initContentView
{
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavigationBarHeight)];
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

- (void)initTableView
{
    MallOrderDetailTB *tableView = [[MallOrderDetailTB alloc] initWithFrame:CGRectMake(0, self.addressView.yy, kScreenWidth, kScreenHeight-kNavigationBarHeight)];
    tableView.scrollEnabled = NO;
    [self.contentView addSubview:tableView];
    self.tableView = tableView;
    self.tableView.frame = CGRectMake(0, self.addressView.yy, kScreenWidth, kHeight(3*100));
    
}
- (void)initBottomView {
    OrderDetailView *detail = [[OrderDetailView alloc] initWithFrame:CGRectMake(0, self.tableView.yy, kScreenWidth, kHeight(250))];
    self.detailView = detail;
    [self.contentView addSubview:detail];
    self.contentView.contentSize = CGSizeMake(0, detail.yy+100);
    CoinWeakSelf;
    detail.clickBtnBlock = ^(NSInteger inter) {
        [weakSelf clickBottomWithIndex:inter];
    };
    detail.phoneContentLbl.text  = @"20190125";
    detail.addressContentLbl.text  = @"¥1000";
    detail.backContentLabel.text  = @"产权方";
    detail.payCodeContentLbl.text  = @"201999203312";

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

@end
