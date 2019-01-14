//
//  NoticeVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/14.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "NoticeVC.h"
#import "NoticeTableView.h"
@interface NoticeVC ()<RefreshDelegate>
@property (nonatomic , strong) NoticeTableView *tableView;

@end

@implementation NoticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    self.tableView = [[NoticeTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.refreshDelegate = self;
    self.tableView.scrollEnabled = YES;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
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
