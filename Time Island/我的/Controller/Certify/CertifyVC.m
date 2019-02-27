//
//  CertifyVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/23.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "CertifyVC.h"
#import "CertifyVCCell.h"
#import "PersonalCertifyVC.h"
#import "CompanyCertifyVC.h"
@interface CertifyVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) TLTableView * table;
@end

@implementation CertifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"认证";
    self.table = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:[CertifyVCCell class] forCellReuseIdentifier:@"CertifyVCCell"];
    [self.view addSubview:self.table];
    
    TLNetworking * http = [TLNetworking new];
    http.code = USER_INFO;
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        NSDictionary * dic = responseObject[@"data"];
        [[TLUser user]saveUserInfo:dic];
        [[TLUser user]setUserInfoWithDict:dic];
     } failure:^(NSError *error) {
         
     }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[TLUser user].userExt[@"personAuthStatus"] isEqualToString:@"1"] ||[[TLUser user].userExt[@"companyAuthStatus"] isEqualToString:@"1"]) {
        return 1;
    }
    else
        return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CertifyVCCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CertifyVCCell" forIndexPath:indexPath];
    if ([[TLUser user].userExt[@"personAuthStatus"] isEqualToString:@"1"] ||[[TLUser user].userExt[@"companyAuthStatus"] isEqualToString:@"1"]) {
        if ([[TLUser user].userExt[@"personAuthStatus"] isEqualToString:@"1"]) {
            cell.title.text = @"个人认证";
            cell.state.text = @"已认证";
        }
        if ([[TLUser user].userExt[@"companyAuthStatus"] isEqualToString:@"1"]) {
            cell.title.text = @"企业认证";
            cell.state.text = @"已认证";
        }
    }
    else{
        if (indexPath.row == 0) {
            cell.title.text = @"个人认证";
            cell.state.text = @"未认证";
        }
        if (indexPath.row == 1) {
            cell.title.text = @"企业认证";
            cell.state.text = @"未认证";
        }
    }
    
    cell.selectionStyle = UIAccessibilityTraitNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[TLUser user].userExt[@"personAuthStatus"] isEqualToString:@"1"] ||[[TLUser user].userExt[@"companyAuthStatus"] isEqualToString:@"1"]) {
        if ([[TLUser user].userExt[@"personAuthStatus"] isEqualToString:@"1"]) {
            PersonalCertifyVC * vc = [PersonalCertifyVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([[TLUser user].userExt[@"companyAuthStatus"] isEqualToString:@"1"]) {
            CompanyCertifyVC * vc = [CompanyCertifyVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        if (indexPath.row == 0) {
            PersonalCertifyVC * vc = [PersonalCertifyVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 1) {
            CompanyCertifyVC * vc = [CompanyCertifyVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
@end
