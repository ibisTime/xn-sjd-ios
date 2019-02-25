//
//  CompanyCertifyTableView.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "CompanyCertifyTableView.h"
#import "CompanyCertifycell.h"
#define CompanyCertify @"CompanyCertifycell"
@implementation CompanyCertifyTableView{
    CompanyCertifycell * cell;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[CompanyCertifycell class] forCellReuseIdentifier:CompanyCertify];
        self.titleArray = @[@"企业名称",@"企业地址",@"企业法人姓名",@"企业法人联系方式",@"企业法人身份证",@"企业联系人",@"企业联系人电话",@"企业联系人地址",@"企业开户行",@"企业开户行帐号",@"企业注册统一码"];
        self.placeholderArray = @[@"请输入企业名称（必填）",@"请输入企业地址（必填）",@"请输入企业法人姓名（必填）",@"请输入企业法人联系方式（必填）",@"请输入企业法人身份证（必填）",@"请输入企业联系人（必填）",@"请输入企业联系人电话（必填）",@"请输入企业联系人地址（必填）",@"请输入企业开户行（必填）",@"请输入企业开户行帐号（必填）",@"请输入企业注册统一码（必填）"];
//        self.KeyArray = @[@"ComName",@"ComAddress",@"BossName",@"BossTel",@"BossID",@"ComUser",@"ComUserTel",@"ComUserAddress",@"ComBankName",@"ComBankID",@"ComID"];
    }
    return self;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    cell = [tableView dequeueReusableCellWithIdentifier:CompanyCertify forIndexPath:indexPath];
    cell.title = self.titleArray[indexPath.row];
    cell.placeholder = self.placeholderArray[indexPath.row];
    cell.keyStr = self.KeyArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.Text = ^(NSString * _Nonnull text, NSString * _Nonnull key) {
//
//    };
    cell.textfield.tag = 1000 + indexPath.row;
//    cell.textfield.delegate = self;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}
//-(void)textFieldDidEndEditing:(UITextField *)textField{
//    cell.Text = ^(NSString * _Nonnull text, NSString * _Nonnull key) {
//        [self.ValueDic setObject:text forKey:key];
//    };
//    NSLog(@"self.ValueDic%@",self.ValueDic);
//}

@end
