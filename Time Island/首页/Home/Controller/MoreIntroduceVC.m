//
//  MoreIntroduceVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MoreIntroduceVC.h"
#import "MoreIntroduceCell.h"
#define MoreIntroduce @"MoreIntroduceCell"
#import "IntroduceModel.h"
#import "introduceView.h"
@interface MoreIntroduceVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) TLTableView * tableview;
@property (nonatomic,strong) NSMutableArray<IntroduceModel *> * IntroduceModels;
@end

@implementation MoreIntroduceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.refreshDelegate = self;
    [self.tableview setBackgroundColor:kWhiteColor];
    [self.tableview registerClass:[MoreIntroduceCell class] forCellReuseIdentifier:MoreIntroduce];
    [self.view addSubview:self.tableview];
    [self GetData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.IntroduceModels.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MoreIntroduceCell * cell = [tableView dequeueReusableCellWithIdentifier:MoreIntroduce forIndexPath:indexPath];
    cell.model = self.IntroduceModels[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    IntroduceModel * model = self.IntroduceModels[indexPath.row];
    introduceView * vc = [introduceView new];
    vc.title = @"公告详情";
    vc.web = model.content;
    vc.IntroduceTitle = model.title;
    vc.time = [model.createDatetime convertToDetailDate];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)GetData{
    CoinWeakSelf;
//    TLNetworking * help = [[TLNetworking alloc]init];
    
    
    TLPageDataHelper * help = [[TLPageDataHelper alloc]init];
    help.code = @"805305";
    help.parameters[@"type"] = @(1);
    help.parameters[@"status"] = @(1);
    help.parameters[@"object"] = @"C";
    help.parameters[@"orderDir"] = @"desc";
    help.parameters[@"orderColumn"] = @"create_datetime";
    
    [help modelClass:[IntroduceModel class]];
    help.isCurrency = YES;
    help.tableView = self.tableview;
    [self.tableview addRefreshAction:^{
        [help refresh:^(NSMutableArray *objs, BOOL stillHave) {
            if (objs.count > 0) {
                weakSelf.IntroduceModels = objs;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview endRefreshHeader];
            }
        } failure:^(NSError *error) {
            [weakSelf.tableview endRefreshHeader];
        }];
    }];

    [self.tableview addLoadMoreAction:^{
        [help loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            if (objs.count > 0) {
                weakSelf.IntroduceModels = objs;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview endRefreshHeader];
            }
        } failure:^(NSError *error) {
            [weakSelf.tableview endRefreshFooter];
        }];
    }];
    [self.tableview beginRefreshing];
    
    
//    help.parameters[@"limit"] = @(10);
//    help.parameters[@"start"] = @(1);
//
//    [help postWithSuccess:^(id responseObject) {
//        self.IntroduceModels = [IntroduceModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
//        [self.tableview reloadData];
//    } failure:^(NSError *error) {
//
//    }];
}

@end
