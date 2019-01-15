//
//  ToClaimTheGiftVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/15.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "ToClaimTheGiftVC.h"
#import "ToClaimTheGiftTableView.h"
#import "ToClaimTheGiftVC2.h"
@interface ToClaimTheGiftVC ()<RefreshDelegate>

@property (nonatomic , strong)ToClaimTheGiftTableView *tableView;

@end

@implementation ToClaimTheGiftVC

- (ToClaimTheGiftTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[ToClaimTheGiftTableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH,SCREEN_HEIGHT -kNavigationBarHeight - kHeight(65)) style:UITableViewStyleGrouped];
        
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kWhiteColor;
        //        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"认领礼物";
    [self.view addSubview:self.tableView];
    [self BottomView];
    self.view.backgroundColor = kWhiteColor;
}


-(void)BottomView
{
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kNavigationBarHeight - kHeight(65), SCREEN_WIDTH, kHeight(65))];
    bottomView.backgroundColor = kWhiteColor;
    [self.view addSubview:bottomView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = kLineColor;
    [bottomView addSubview:lineView];
    
    
    UIButton *confirmBtn = [UIButton buttonWithTitle:@"认领礼物" titleColor:kWhiteColor backgroundColor:kHexColor(@"#23AD8C") titleFont:16];
    confirmBtn.frame = CGRectMake(kWidth(15),lineView.y + kHeight(10), SCREEN_WIDTH - kWidth(30), kHeight(45));
    kViewRadius(confirmBtn, 4);
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:confirmBtn];
}

-(void)confirmBtnClick
{
    ToClaimTheGiftVC2 *vc = [ToClaimTheGiftVC2 new];
    [self.navigationController pushViewController:vc animated:YES];
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
