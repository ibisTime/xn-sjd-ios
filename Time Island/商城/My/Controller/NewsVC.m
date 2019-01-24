//
//  NewsVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/21.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "NewsVC.h"
#import "NewsVCCell.h"
@interface NewsVC ()<UITableViewDelegate,UITableViewDataSource,RefreshDelegate>
@property (nonatomic,strong) TLTableView * table;
@end

@implementation NewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self connect];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]init];
    item.title = @"消息";
    self.navigationItem.backBarButtonItem = item;
    
    self.table = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.table registerClass:[NewsVCCell class] forCellReuseIdentifier:@"newscell"];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.refreshDelegate = self;
//    self.table.separatorStyle = YES;
    [self.view addSubview:self.table];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsVCCell * cell = [tableView dequeueReusableCellWithIdentifier:@"newscell" forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:{
            cell.NewsTitle.text = @"平台客服";
            cell.NewsDetails.text = @"最新消息";
            cell.NewsTime.text = @"刚刚";
        }
            break;
        case 1:{
            cell.NewsTitle.text = @"多比宠物用品专营店";
            cell.NewsDetails.text = @"100亿红包在此！就问你抢不抢吧";
            cell.NewsTime.text = @"4:30";
        }
            break;
        case 2:{
            cell.NewsTitle.text = @"CONNIREPET康特牌";
            cell.NewsDetails.text = @"100亿红包在此！就问你抢不抢吧";
            cell.NewsTime.text = @"昨天";
        }
            break;
        case 3:{
            cell.NewsTitle.text = @"多比宠物用品专营店";
            cell.NewsDetails.text = @"100亿红包在此！就问你抢不抢吧";
            cell.NewsTime.text = @"18/10/12";
        }
            break;
        default:
            break;
    }
    
    cell.selectionStyle = UIAccessibilityTraitNone;
    return cell;
}
-(void)connect{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"805315";
    http.parameters[@"id"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        NSDictionary * dic = (NSDictionary * )responseObject;
        
    } failure:^(NSError *error) {
        
    }];
}
@end
