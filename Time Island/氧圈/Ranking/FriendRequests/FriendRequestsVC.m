//
//  FriendRequestsVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "FriendRequestsVC.h"
#import "FriendRequestsTableView.h"
@interface FriendRequestsVC ()<RefreshDelegate>

@property (nonatomic , strong)FriendRequestsTableView *tableView;

@end

@implementation FriendRequestsVC


- (FriendRequestsTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[FriendRequestsTableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH,SCREEN_HEIGHT -kNavigationBarHeight) style:UITableViewStyleGrouped];
        
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kBackgroundColor;
        //        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    self.title = @"好友审核";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getdata{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"805155";
    http.parameters[@"start"] = @(1);
    http.parameters[@"limit"] = @(30);
    http.parameters[@"toUser"] = [TLUser user].userId;
    http.parameters[@"type"] = @"2";
    http.parameters[@"isMySelf"] = @(0);
    [http postWithSuccess:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
