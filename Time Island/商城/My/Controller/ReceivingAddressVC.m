//
//  ReceivingAddressVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/18.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "ReceivingAddressVC.h"
#import "AddressCell.h"
#import "GetAddVC.h"
@interface ReceivingAddressVC ()
@property (nonatomic,strong) TLTableView * table;
@end

@implementation ReceivingAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收货地址";
//    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
//    backBtn.title = @"我的收货地址";
//    self.navigationItem.backBarButtonItem = backBtn;
////
    
//    self.backLbl.text = @"我的收货地址";
//    self.navigationItem.titleView = self.backLbl;
    
    if (self.state == 2) {
        self.navigationController.navigationBar.barTintColor = kHexColor(@"#333333");
    }
    else if (self.state == 1){
        self.navigationController.navigationBar.barTintColor = kHexColor(@"#23AD8C");
    }
    
    self.table = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 45.5 - 3.5 - kNavigationBarHeight)];
    [self.table registerClass:[AddressCell class] forCellReuseIdentifier:@"cell"];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.refreshDelegate = self;
    [self.view addSubview:self.table];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    self.RightButton.titleLabel.font = FONT(16);
    [self.RightButton setFrame:CGRectMake(SCREEN_WIDTH-47.5, 30, 32.5, 45)];
    [self.RightButton setTitle:@"···" forState:UIControlStateNormal];
    

    UIButton * addbtn = [UIButton buttonWithTitle:@"新增地址" titleColor:kHexColor(@"#FFFFFF") backgroundColor:kHexColor(@"#F68646") titleFont:15 cornerRadius:4];
    addbtn.frame = CGRectMake(15, self.table.yy + 3.5, SCREEN_WIDTH - 30, 42);
    [addbtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addbtn];

    
    

    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 137.5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UIAccessibilityTraitNone;
    if (indexPath.section == 1) {
        cell.checkBtn.selected = NO;
    }
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, tableView.yy, SCREEN_WIDTH, 10)];
    return view;
}
-(void)confirm{
    GetAddVC * vc = [GetAddVC new];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
    backBtn.title = @"新增收货地址";
    vc.navigationItem.backBarButtonItem = backBtn;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressModel *model = [AddressModel new];
    model.province = @"浙江省";
    model.city = @"杭州市";
    model.area = @"余杭区";
    model.detail = @"人工智能小镇";

    model.mobile = @"18612233322";
    model.addressee = @"测试";
    if (self.selectCellBlock) {
        self.selectCellBlock(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end

