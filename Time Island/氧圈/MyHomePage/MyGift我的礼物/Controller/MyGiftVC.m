//
//  MyGiftVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/15.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MyGiftVC.h"
#import "MyGiftTableView.h"
#import "ToClaimTheGiftVC.h"
@interface MyGiftVC ()<RefreshDelegate>

@property (nonatomic , strong)MyGiftTableView *tableView;

@end

@implementation MyGiftVC

- (MyGiftTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[MyGiftTableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH,SCREEN_HEIGHT -kNavigationBarHeight) style:UITableViewStyleGrouped];
        
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kWhiteColor;
        //        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"礼物";
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = kWhiteColor;
    
    [self getdata];
}




-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ToClaimTheGiftVC *vc = [[ToClaimTheGiftVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)getdata{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629325";
    http.parameters[@"adoptTreeCode"] = @"";
    http.parameters[@"start"] = @(1);
    http.parameters[@"limit"] = @(10);
    http.parameters[@"toUser"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
