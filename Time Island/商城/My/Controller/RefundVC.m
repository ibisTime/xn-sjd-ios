//
//  RefundVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/4.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "RefundVC.h"
#import "RefundCell.h"
@interface RefundVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton * selectBtn;
    int state;
}
@property (nonatomic,strong) UIView * headview;
@property (nonatomic,strong) UIView * footview;
//@property (nonatomic,strong) UIButton * selectBtn;
@property (nonatomic,strong) TLTableView * tableview;
@property (nonatomic,strong) NSArray * titlearr;
#define refund @"RefundCell"
@end

@implementation RefundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请退款";
    
    self.titlearr = @[@"退款金额",@"退款原因",@"留言"];
    state = 0;
    [self headerview];
    [self footerview];
    self.tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kTabBarHeight)];
    self.tableview.tableHeaderView = self.headview;
    self.tableview.tableFooterView = self.footview;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
//    [self.tableview registerClass:[RefundCell class] forCellReuseIdentifier:refund];
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableview];
}

-(void)headerview{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    view.backgroundColor = kWhiteColor;
    NSArray * maintitle = @[@"仅退款",@"退货退款"];
    NSArray * subtitle = @[@"卖家未发货或与卖家协商同意前提下",@"卖家已发货，需要退货物"];
    for (int i = 0; i < 2; i ++) {
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.frame = CGRectMake(15,  i % 2 * 70, 30, 70);
        [btn setImage:kImage(@"未选中") forState:(UIControlStateNormal)];
        [btn setImage:kImage(@"选中") forState:(UIControlStateSelected)];
        if (i == 0) {
            btn.selected = YES;
            selectBtn = btn;
        }
        [btn addTarget:self action:@selector(payBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        btn.tag = 100 + i;
        [view addSubview:btn];
        
        UILabel * mainlabel = [UILabel labelWithFrame:CGRectMake(60, 15 + i % 2 * 70, SCREEN_WIDTH - 75, 70 / 2) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(14) textColor:kBlackColor];
        mainlabel.text = maintitle[i];
        [view addSubview:mainlabel];
        
        
        UILabel * sublabel = [UILabel labelWithFrame:CGRectMake(60, 40 + i % 2 * 70, SCREEN_WIDTH - 75, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kBlackColor];
        sublabel.text = subtitle[i];
        [view addSubview:sublabel];
        
    }
    UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15, 75, SCREEN_WIDTH - 30, 1)];
    v1.backgroundColor = kLineColor;
    [view addSubview:v1];
    self.headview = view;
}
-(void)footerview{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 40) title:@"提交" backgroundColor:kTabbarColor];
    [button setTintColor:kWhiteColor];
    kViewRadius(button, 4);
    [button addTarget:self action:@selector(comfirm) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:button];
    self.footview = view;
}
-(void)payBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    selectBtn.selected = !selectBtn.selected;
    selectBtn = sender;
    if (sender.tag == 100) {
        self.titlearr = @[@"退款金额",@"退款原因",@"留言"];
        state = 0;
        [self.tableview reloadData];
    }
    else if(sender.tag == 101){
        self.titlearr = @[@"退款金额",@"物流公司",@"物流单号",@"发货人",@"退款原因",@"留言"];
        state = 1;
        [self.tableview reloadData];
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titlearr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > self.titlearr.count - 1) {
        return 80;
    }
    return 55;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * v2 =[[UIView alloc]initWithFrame:CGRectMake(0, 140, SCREEN_WIDTH, 10)];
    v2.backgroundColor = kLineColor;
    return v2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"cell";
    RefundCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[RefundCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        }
//    if (indexPath.row == 0) {
//        cell.textfield.text = self.money;
//    }else{
//        cell.textfield.text = @"";
//    }
    
    cell.title = self.titlearr[indexPath.row];
    cell.textfield.tag = indexPath.row + 1;
    return cell;
  
}
-(void)comfirm{
    NSLog(@"self.money%@",self.money);
    TLTextField * t0 = [self.view viewWithTag:1];
    TLTextField * t1 = [self.view viewWithTag:2];
    TLTextField * t2 = [self.view viewWithTag:3];
    TLTextField * t3 = [self.view viewWithTag:4];
    TLTextField * t4 = [self.view viewWithTag:5];
    TLTextField * t5 = [self.view viewWithTag:6];
    
    
    if (t0.text.length == 0) {
        [TLAlert alertWithInfo:@"请输入金额！"];
        return;
    }
    else if ([t0.text integerValue] > [self.money integerValue]) {
        [TLAlert alertWithInfo:@"您输入的金额大于商品价格，请重新输入！"];
    }
    else if (state == 1){
        if (t1.text.length == 0) {
            [TLAlert alertWithInfo:@"请填入物流公司名称！"];
        }
        else if (t2.text.length == 0){
            [TLAlert alertWithInfo:@"请填入物流单号！"];
        }
        else if (t3.text.length == 0){
            [TLAlert alertWithInfo:@"请填入发货人！"];
        }
    }else{
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"629771";
        http.parameters[@"orderDetailCode"] = self.code;
        http.parameters[@"applyUser"] = [TLUser user].userId;
        if (state == 0) {
            http.parameters[@"refundAmount"] = [NSString stringWithFormat:@"%.2f",[t0.text floatValue] * 1000];
            http.parameters[@"refundReason"] = t1.text;
            http.parameters[@"message"] = t2.text;
        }
        else if (state == 1){
            http.parameters[@"refundAmount"] = [NSString stringWithFormat:@"%F",[t0.text floatValue] * 1000];
            http.parameters[@"logisticsCompany"] = t1.text;
            http.parameters[@"logisticsNumber"] = t2.text;
            http.parameters[@"deliver"] = t3.text;
            http.parameters[@"refundReason"] = t4.text;
            http.parameters[@"message"] = t5.text;
            
        }
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithMsg:@"申请成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            
        }];
    }
    
    
    
    
}
@end
