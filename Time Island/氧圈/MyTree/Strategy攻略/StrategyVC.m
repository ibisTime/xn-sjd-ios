//
//  StrategyVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "StrategyVC.h"
#import "StrategyTableView.h"
@interface StrategyVC ()<RefreshDelegate>

@property (nonatomic , strong)StrategyTableView *tableView;

@end

@implementation StrategyVC

- (StrategyTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[StrategyTableView alloc] initWithFrame:CGRectMake(0,0 , SCREEN_WIDTH,SCREEN_HEIGHT -kNavigationBarHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = kTabbarColor;
        _tableView.refreshDelegate = self;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kTabbarColor;
    [self.view addSubview:self.tableView];
    self.title = @"养树攻略";
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
