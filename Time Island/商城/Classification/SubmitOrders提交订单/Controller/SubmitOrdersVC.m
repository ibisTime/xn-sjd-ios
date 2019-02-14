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

@property (nonatomic , strong)SubmitOrdersTableView *tableView;
@property (nonatomic , strong)GoodsDetailsBottomView *BottomView;
@end

@implementation SubmitOrdersVC

#pragma mark - Init
- (void)initTableView {
    CoinWeakSelf
    
    self.tableView = [[SubmitOrdersTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight- 50) style:(UITableViewStyleGrouped)];
    self.tableView.mallGoodsModel = self.MallGoodsModel;
    
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
    self.tableView.count = self.count;
    self.tableView.size = self.size;
    self.tableView.selectnum = self.selectnum;
    self.tableView.returndata = ^(NSInteger count, int selectnum) {
        weakSelf.count = count;
        weakSelf.selectnum = selectnum;
        NSString * str = [NSString stringWithFormat:@"合计 ：%.2f",[self.MallGoodsModel.specsList[self.selectnum][@"price"] floatValue]  * self.count / 1000];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:kTextColor
                        range:NSMakeRange(0, 4)];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:kHexColor(@"#F68646")
                        range:NSMakeRange(4, str.length - 4)];
        weakSelf.BottomView.MonthlyPaymentsLabel.attributedText = attrStr;
    };
    
    self.tableView.remark = ^(NSString *remark) {
        weakSelf.remark = remark;
    };
    
    [self.tableView reloadData];
    
}

-(GoodsDetailsBottomView *)BottomView
{
    if (!_BottomView) {
        _BottomView = [[GoodsDetailsBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kNavigationBarHeight - 50, SCREEN_WIDTH, 50)];
        [_BottomView.shoppingButton addTarget:self action:@selector(chooseViewClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_BottomView.shoppingButton setTitle:@"确认购买" forState:(UIControlStateNormal)];
        
        NSString * str = [NSString stringWithFormat:@"合计 ：%.2f",[self.MallGoodsModel.specsList[self.selectnum][@"price"] floatValue]  * self.count / 1000];
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
    
    NSString * str = [NSString stringWithFormat:@"合计 ：%.2f",[self.MallGoodsModel.specsList[self.selectnum][@"price"] floatValue]  * self.count / 1000];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:kTextColor
                    range:NSMakeRange(0, 4)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:kHexColor(@"#F68646")
                    range:NSMakeRange(4, str.length - 4)];
    self.BottomView.MonthlyPaymentsLabel.attributedText = attrStr;
    [self.view addSubview:self.BottomView];
    

}


- (void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CoinWeakSelf;
    if (indexPath.section == 0) {
        ReceivingAddressVC *address = [ReceivingAddressVC new];
        address.selectCellBlock = ^(AddressModel * _Nonnull model) {
            weakSelf.addressModel = model;
            weakSelf.tableView.addressModel = model;
            NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:0];
            [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
            [self.navigationController popViewControllerAnimated:YES];
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:address animated:YES];
        
    }
    
}

- (void)chooseViewClick
{
    NSLog(@"去付款");
    if (self.addressModel.code) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"629720";
        http.parameters[@"applyUser"] = [TLUser user].userId;
        http.parameters[@"expressType"] = @(0);
        http.parameters[@"specsId"] =self.MallGoodsModel.specsList[self.selectnum][@"id"] ;
        http.parameters[@"quantity"] = @(self.count);
        http.parameters[@"addressCode"] = self.addressModel.code;
        http.parameters[@"applyNote"] = self.remark;
        NSLog(@"self.remark = %@",self.remark);
        [http postWithSuccess:^(id responseObject) {
            self.code = responseObject[@"data"][@"code"];
            PayVC * vc = [PayVC new];
            vc.Code = self.code;
            vc.PayCount = self.count;
            vc.mallGoodsModel = self.MallGoodsModel;
            vc.GoodsSizeCount = self.selectnum;
            vc.money = [NSString stringWithFormat:@"合计 ：%.2f",[self.MallGoodsModel.specsList[self.selectnum][@"price"] floatValue]  * self.count / 1000];
            [self.navigationController pushViewController:vc animated:YES];
        } failure:^(NSError *error) {
            
        }];
    }
    else{
        [TLAlert alertWithError:@"请选择地址"];
    }
    
}

@end
