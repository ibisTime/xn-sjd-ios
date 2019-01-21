//
//  TreeFieldVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/10.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TreeFieldVC.h"
#import "TreeFieldTB.h"
@interface TreeFieldVC ()<RefreshDelegate>
@property (nonatomic , strong) TreeFieldTB *tableView;

@end

@implementation TreeFieldVC

- (void)viewDidLoad {
    self.view.backgroundColor = kAppCustomMainColor;
    [super viewDidLoad];
    self.tableView = [[TreeFieldTB alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-200) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.refreshDelegate = self;
    self.tableView.scrollEnabled = NO;

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
