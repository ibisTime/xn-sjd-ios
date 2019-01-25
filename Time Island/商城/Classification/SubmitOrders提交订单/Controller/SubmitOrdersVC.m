//
//  SubmitOrdersVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SubmitOrdersVC.h"
#import "SubmitOrdersTableView.h"
#import "ReceivingAddressVC.h"
#import "GoodsDetailsBottomView.h"
//#import "GoodsDetailsBottomView.h"
#import "PayVC.h"
@interface SubmitOrdersVC ()<RefreshDelegate>
{
//    还款编号
    NSString *bankcardCode;
//
    NSString *reAddress;
    NSString *reMobile;
    NSString *receiver;
    NSDictionary *dataDic;
}
@property (nonatomic , strong)AddressModel *adressModel;
@property (nonatomic , strong)NSMutableArray <AddressModel *>*addressArray;
@property (nonatomic , strong)BankCardModel *bankCardModel;
@property (nonatomic , strong)NSMutableArray <BankCardModel *>*bankCardArray;
@property (nonatomic , strong)SubmitOrdersTableView *tableView;
@property (nonatomic , strong)GoodsDetailsBottomView *BottomView;
@end

@implementation SubmitOrdersVC

-(GoodsDetailsBottomView *)BottomView
{
    if (!_BottomView) {
        _BottomView = [[GoodsDetailsBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kNavigationBarHeight - 50, SCREEN_WIDTH, 50)];
        [_BottomView.shoppingButton addTarget:self action:@selector(chooseViewClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_BottomView.shoppingButton setTitle:@"确认购买" forState:(UIControlStateNormal)];
        NSString *str = [NSString stringWithFormat:@"合计: %.2f",[@"200" floatValue]];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:kTextColor
                        range:NSMakeRange(0, 4)];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:kHexColor(@"#F68646")
                        range:NSMakeRange(4, str.length - 4)];
        _BottomView.MonthlyPaymentsLabel.attributedText = attrStr;

    }
    return _BottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"订单提交";
    [self.view addSubview:self.tableView];
    [self initTableView];
    [self.view addSubview:self.BottomView];

}
#pragma mark - Init
- (void)initTableView {

    self.tableView = [[SubmitOrdersTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight- 50) style:(UITableViewStyleGrouped)];
   MallOrderModel *model = [MallOrderModel new];
    model.ShopName = @"十年";
    model.GoodsName = @"苍天大树";
    model.GoodsMoney = @"688";
    model.GoodsCount = @"2";

    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    NSString *specifications = [self.selectArray componentsJoinedByString:@","];
    self.tableView.specificationsStr = specifications;
    [self.view addSubview:self.tableView];
    self.tableView.homeModel = model;

    [self.tableView reloadData];

}

- (void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CoinWeakSelf;
    ReceivingAddressVC *address = [ReceivingAddressVC new];
    address.selectCellBlock = ^(AddressModel * _Nonnull model) {
        weakSelf.tableView.addressModel = model;
        NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:0];
        [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    };
    [self.navigationController pushViewController:address animated:YES];
}

- (void)chooseViewClick
{
    NSLog(@"去付款");
}

@end
