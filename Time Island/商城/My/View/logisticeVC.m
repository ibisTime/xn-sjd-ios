//
//  logisticeVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/6.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "logisticeVC.h"
#import "logisticsModel.h"
#import "PasswayModel.h"
#import "LogisticeCell.h"
@interface logisticeVC ()<UITableViewDelegate,UITableViewDataSource,RefreshDelegate>
@property (nonatomic,strong) NSMutableArray<logisticsModel *> * logisticsModels;
@property (nonatomic,strong) UIView * headview;
@property (nonatomic,strong) UILabel * status;
@property (nonatomic,strong) UILabel * company;
@property (nonatomic,strong) UILabel * PassID;
@property (nonatomic,strong) TLTableView * tableview;
@property (nonatomic,strong) PasswayModel * PasswayModel;
@end

@implementation logisticeVC

-(void)viewWillDisappear:(BOOL)animated{
    self.expNo = @"";
    self.expCode = @"";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物流详情";
    [self initTopview];
    [self getcompanyname];
    [self getData];
    
    self.tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
    self.tableview.defaultNoDataImage = kImage(@"暂无订单");
    self.tableview.defaultNoDataText = @"抱歉，暂无物流消息";
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.refreshDelegate = self;
    self.tableview.tableHeaderView = self.headview;
    [self.view addSubview:self.tableview];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.PasswayModel.Traces.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"cell";
    
    LogisticeCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
        
        cell=[[LogisticeCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        
    }
    if (indexPath.row == self.PasswayModel.Traces.count - 1) {
        [cell.line setHidden:YES];
        cell.circle.backgroundColor = kLineColor;
    }
    else if (indexPath.row == 0){
        cell.circle.backgroundColor = kTabbarColor;
        [cell.line setHidden:NO];
    }else
    {
        cell.circle.backgroundColor = kLineColor;
        [cell.line setHidden:NO];
    }
    NSMutableArray * arr =[NSMutableArray array];
    arr = (NSMutableArray *)[[self.PasswayModel.Traces reverseObjectEnumerator]allObjects];
    
    cell.contentLab.frame = CGRectMake(35, 15, SCREEN_WIDTH - 45, 60);
    cell.contentLab.text = arr[indexPath.row][@"AcceptStation"];
    cell.timeLab.text = arr[indexPath.row][@"AcceptTime"];
    [cell.contentLab sizeToFit];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}










-(void)initTopview{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 70, 70)];
    kViewRadius(img, 4);
    [img sd_setImageWithURL:[NSURL URLWithString:[self.photo convertImageUrl]] placeholderImage:kImage(@"树 跟背景")];
    [view addSubview:img];
    
    UILabel * label1 = [UILabel labelWithFrame:CGRectMake(img.xx + 15, 15, 80, img.height / 3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kBlackColor];
    label1.text = @"物流状态：";
    
    self.status = [UILabel labelWithFrame:CGRectMake(label1.xx, 15, SCREEN_WIDTH - label1.xx, img.height / 3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:[UIColor blueColor]];
    self.status.text = @"待收货";
    
    UILabel * label2 = [UILabel labelWithFrame:CGRectMake(img.xx + 15, label1.yy, 80, img.height / 3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kBlackColor];
    label2.text = @"承运来源：";
    self.company = [UILabel labelWithFrame:CGRectMake(label2.xx, label1.yy, SCREEN_WIDTH - label2.xx, img.height / 3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kBlackColor];
    
    UILabel * label3 = [UILabel labelWithFrame:CGRectMake(img.xx + 15, label2.yy, 80, img.height / 3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kBlackColor];
    label3.text = @"物流单号:";
    self.PassID = [UILabel labelWithFrame:CGRectMake(label3.xx, label2.yy, SCREEN_WIDTH - label3.xx, img.height / 3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kBlackColor];
    self.PassID.text = self.expNo;
    
    [view addSubview:label1];
    [view addSubview:self.status];
    [view addSubview:label2];
    [view addSubview:self.company];
    [view addSubview:label3];
    [view addSubview:self.PassID];
    self.headview = view;
}
-(void)getcompanyname{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630036";
    http.parameters[@"parentKey"] = @"logistics_company";
    [http postWithSuccess:^(id responseObject) {
        self.logisticsModels = [logisticsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        for (int i = 0; i < self.logisticsModels.count; i ++) {
            if ([self.expCode isEqualToString:self.logisticsModels[i].dkey]) {
                self.company.text = self.logisticsModels[i].dvalue;
            }
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)getData{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629820";
    http.parameters[@"expCode"] = self.expCode;
    http.parameters[@"expNo"] = self.expNo;
    [http postWithSuccess:^(id responseObject) {
//        self.PasswayModel = responseObject[@"data"];
        self.PasswayModel = [PasswayModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self.tableview reloadData];
    } failure:^(NSError *error) {
        
    }];
}


@end
