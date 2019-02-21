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
@interface ReceivingAddressVC ()<AddressCellDelegrate>
@property (nonatomic,strong) TLTableView * table;

@property (nonatomic , strong)NSMutableArray <AddressModel *>*addressModels;

@end

@implementation ReceivingAddressVC

-(void)viewWillAppear:(BOOL)animated{
    [self refresh];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收货地址";

    if (self.state == 2) {
        self.navigationController.navigationBar.barTintColor = kHexColor(@"#333333");
    }
    else if (self.state == 1){
        self.navigationController.navigationBar.barTintColor = kHexColor(@"#23AD8C");
    }
    
    self.table = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50 - kNavigationBarHeight - kDevice_Is_iPhoneX)];
    [self.table registerClass:[AddressCell class] forCellReuseIdentifier:@"cell"];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.refreshDelegate = self;
    [self.view addSubview:self.table];
    
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    negativeSpacer.width = -10;
//    [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
//    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
//    self.RightButton.titleLabel.font = FONT(16);
//    [self.RightButton setFrame:CGRectMake(SCREEN_WIDTH-47.5, 30, 32.5, 45)];
//    [self.RightButton setTitle:@"···" forState:UIControlStateNormal];
    

    UIButton * addbtn = [UIButton buttonWithTitle:@"新增地址" titleColor:kHexColor(@"#FFFFFF") backgroundColor:kHexColor(@"#F68646") titleFont:15 cornerRadius:4];
    addbtn.frame = CGRectMake(15, self.table.yy + 3.5, SCREEN_WIDTH - 30, 42);
    [addbtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addbtn];


    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"%D",(int)self.addressModels.count);
    return self.addressModels.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    cell.delegrate = self;
    if (self.addressModels.count > 0) {
        AddressModel * model = self.addressModels[indexPath.row];
        cell.UserName.text = model.addressee;
        cell.UserPhone.text = model.mobile;
        cell.UserAddress.text = [NSString stringWithFormat:@"%@ %@ %@ %@",model.province,model.city,model.district,model.detailAddress];
        if ([model.isDefault isEqualToString:@"0"]) {
            cell.checkBtn.selected = NO;
            
        }else{
            cell.checkBtn.selected = YES;
        }
        cell.checkBtn.tag = indexPath.row;
        [cell.checkBtn addTarget:self action:@selector(checkBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        cell.editbtn.tag = indexPath.row;
        [cell.editbtn addTarget:self action:@selector(editbtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        cell.cancelbtn.tag = indexPath.row;
        [cell.cancelbtn addTarget:self action:@selector(cancelbtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    cell.selectionStyle = UIAccessibilityTraitNone;
    return cell;
}

-(void)checkBtnClick:(UIButton *)sender
{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"805173";
    http.parameters[@"code"] = self.addressModels[sender.tag].code;
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"设置成功"];
        [self refresh];
    } failure:^(NSError *error) {
    }];
    [self.table reloadData];
}

-(void)editbtnClick:(UIButton *)sender
{
    GetAddVC * vc = [[GetAddVC alloc]init];
    vc.NameString = self.addressModels[sender.tag].addressee;
    vc.PhoneString = self.addressModels[sender.tag].mobile;
//    vc.AddressString = [NSString stringWithFormat:@"%@ %@ %@",self.addressModels[sender.tag].province,self.addressModels[sender.tag].city,self.addressModels[sender.tag].district];
    vc.AddressCode = self.addressModels[sender.tag].code;
    vc.sheng = self.addressModels[sender.tag].province;
    vc.shi = self.addressModels[sender.tag].city;
    vc.qu = self.addressModels[sender.tag].district;
    vc.DoorNumString = self.addressModels[sender.tag].detailAddress;
    vc.state = 1;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)cancelbtnClick:(UIButton *)sender
{
    TLNetworking * http = [[TLNetworking alloc]init];
    [TLAlert alertWithTitle:@"提示" msg:@"确定删除地址吗？" confirmMsg:@"确定" cancleMsg:@"取消" cancle:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } confirm:^(UIAlertAction *action) {
        http.code = @"805171";
        http.parameters[@"code"] = self.addressModels[sender.tag].code;
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"设置成功"];
            [self refresh];
        } failure:^(NSError *error) {
        }];
        [self.table reloadData];
    }];
    
    
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
    NSLog(@"%d",(int)indexPath.row);
    if (self.selectCellBlock) {
        self.selectCellBlock(self.addressModels[indexPath.row]);
    }
}
-(void)refresh{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"805175";
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        self.addressModels = [AddressModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.table reloadData];

    } failure:^(NSError *error) {
    }];
}

@end

