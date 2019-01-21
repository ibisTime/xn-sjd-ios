//
//  SettingVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "SettingVC.h"
#import "SettingVCCell.h"
#import "BindMobileVC.h"
#import "TLChangeMobileVC.h"
#import "CardVC.h"
#import "InfoVC.h"
#import "GetAddVC.h"
#import "ReceivingAddressVC.h"
#define titlearray @[@"修改手机号",@"我的银行卡",@"完善资料",@"收货地址"]
@interface SettingVC ()
@property (nonatomic,strong) UITableView *table;
@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220) style:UIAccessibilityTraitNone];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.scrollEnabled = false;
    [self.view addSubview:self.table];
    
    UIButton * logout = [UIButton buttonWithTitle:@"退出登录" titleColor:[UIColor colorWithHexString:@"#23AD8C"] backgroundColor:[UIColor clearColor] titleFont:15];
    logout.frame = CGRectMake(15, self.table.yy + 81.5, SCREEN_WIDTH - 30, 42);
    logout.layer.cornerRadius = 4;
    logout.layer.masksToBounds = YES;
    [logout.layer setBorderWidth:1.0];
    [logout.layer setBorderColor:[UIColor colorWithHexString:@"#23AD8C"].CGColor];
    [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logout];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingVCCell * cell = [[SettingVCCell alloc]initWithtitle:titlearray[indexPath.row]];
    cell.selectionStyle = UIAccessibilityTraitNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.row) {
        case 0:
        {
            TLChangeMobileVC * vc = [[TLChangeMobileVC alloc]init];
            [self.navigationController pushViewController: vc animated:YES];
        }
            break;
        case 1:
        {
            CardVC * vc = [[CardVC alloc]init];
            [self.navigationController pushViewController: vc animated:YES];
        }
            break;
        case 2:
        {
            InfoVC * vc = [[InfoVC alloc]init];
            [self.navigationController pushViewController: vc animated:YES];
        }
            break;
        case 3:
        {
            ReceivingAddressVC * vc = [ReceivingAddressVC new];
            vc.state = 1;
            UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
            backBtn.title = @"我的收货地址";
            self.navigationItem.backBarButtonItem = backBtn;
            [self.navigationController pushViewController: vc animated:YES];
        }
            break;
        default:
            break;
    }
}
-(void)logout{
    NSLog(@"%s",__func__);
}
@end
