//
//  BookVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BookVC.h"
#import "BookView.h"
#import "IssueBook.h"
#import "BookModel.h"
#import "BoolVideoDetailVC.h"
@interface BookVC ()<RefreshDelegate,UITextFieldDelegate>
@property (nonatomic,strong) BookView * bookview;
@property (nonatomic,strong) NSMutableArray<BookModel *> * BookModels;
@end

@implementation BookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的的文章";
    [self refresh];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
//    self.RightButton.font = FONT(16);
    self.RightButton.titleLabel.font = FONT(16);
    [self.RightButton setFrame:CGRectMake(SCREEN_WIDTH-47.5, 30, 32.5, 45)];
    [self.RightButton setTitle:@"发布" forState:UIControlStateNormal];
    [self.RightButton addTarget:self action:@selector(myRecodeClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.view.backgroundColor = kWhiteColor;
    self.bookview = [[BookView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabBarHeight) style:UITableViewStyleGrouped];
    self.bookview.backgroundColor = kWhiteColor;
    self.bookview.refreshDelegate = self;
    [self.view addSubview:self.bookview];
    CoinWeakSelf
    [self.bookview addRefreshAction:^{
        [weakSelf refresh];
        [weakSelf.bookview endRefreshHeader];
    }];
    // Do any additional setup after loading the view.
}

-(void)myRecodeClick{
    IssueBook * issue = [[IssueBook alloc]init];
    [self.navigationController pushViewController:issue animated:YES];
}
-(void)refresh{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629345";
    http.parameters[@"start"] = @(1);
    http.parameters[@"limit"] = @(10);
    http.parameters[@"publishUserId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        self.BookModels = [BookModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        self.bookview.BookModels = self.BookModels;
        [self.bookview reloadData];
    } failure:^(NSError *error) {
    }];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s",__func__);
    BoolVideoDetailVC * vc = [BoolVideoDetailVC new];
    vc.BookModel = self.BookModels[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
