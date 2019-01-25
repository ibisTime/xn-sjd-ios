//
//  ViewExpressVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "ViewExpressVC.h"
#import "ExpressView.h"
#import "ExpressTableView.h"
@interface ViewExpressVC ()
@property (nonatomic ,strong) ExpressTableView *tableView;
@end

@implementation ViewExpressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTopView];
}
- (void)initTopView
{
    ExpressView *exView = [[ExpressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight(105))];
    [self.view addSubview:exView];
    exView.phoneContentLbl.text  = @"待收货";
    exView.addressContentLbl.text  = @"申通快递";
    exView.backContentLabel.text  = @"2089333029334323";
    self.tableView = [[ExpressTableView alloc] initWithFrame:CGRectMake(0, exView.yy, kScreenWidth, kScreenHeight-kNavigationBarHeight-kHeight(105))];
    [self.view addSubview:self.tableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
