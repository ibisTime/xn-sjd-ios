//
//  BookListVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/18.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BookListVC.h"
#import "BookTableView.h"
#import "BoolVideoDetailVC.h"
@interface BookListVC ()<RefreshDelegate>
@property (nonatomic , strong) BookTableView *tableView;

@end

@implementation BookListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    self.tableView = [[BookTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.refreshDelegate = self;
//    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BoolVideoDetailVC *detailavc = [[BoolVideoDetailVC alloc] init];
    detailavc.title =@"文章详情";
    [self.navigationController pushViewController:detailavc animated:YES];
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
