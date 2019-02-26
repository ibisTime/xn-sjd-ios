//
//  GetAddVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "GetAddVC.h"
#import "AddressPickView.h"
#import "ReceivingAddressVC.h"
@interface GetAddVC ()
//@property (nonatomic,strong) TLTextField * Name;
//@property (nonatomic,strong) TLTextField * Phone;
//@property (nonatomic,strong) TLTextField * Address;
//@property (nonatomic,strong) TLTextField * DoorNum;
@property (nonatomic,strong) AddressPickView * pickerView;
@property (nonatomic,strong) NSString * code;
//@property (nonatomic,strong) NSString * sheng;
//@property (nonatomic,strong) NSString * shi;
//@property (nonatomic,strong) NSString * qu;
@end

@implementation GetAddVC


- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.state == 1) {
        self.title = @"修改收货地址";
        self.code = @"805172";
    }
    else{
        self.title = @"新增收货地址";
        self.code = @"805170";
    }
    
//    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
//    backBtn.title = @"新增收货地址";
//    self.navigationItem.backBarButtonItem = backBtn;
    [self setup];
    // Do any additional setup after loading the view.
}

-(void)setup{
    CGFloat margin = 15;
    CGFloat height = 55;
    //姓名
    TLTextField * Name = [[TLTextField alloc]initWithFrame:CGRectMake(margin, 0, SCREEN_WIDTH-30, height) leftTitle:@"收货人" placeholder:@"您的姓名"];
    [self.view addSubview:Name];
    if (self.NameString) {
        Name.text = self.NameString;
    }
    self.Name = Name;
    //电话
    TLTextField * Phone = [[TLTextField alloc]initWithFrame:CGRectMake(margin, Name.yy, SCREEN_WIDTH-30, height) leftTitle:@"电话" placeholder:@"您的电话"];
    [self.view addSubview:Phone];
    if (self.PhoneString) {
        Phone.text = self.PhoneString;
    }
    self.Phone = Phone;
    //地址
    
    
    TLTextField * Address = [[TLTextField alloc]initWithFrame:CGRectMake(margin, Phone.yy, SCREEN_WIDTH-30, height) leftTitle:@"地址" placeholder:@"所在地区"];
    Address.delegate = self;
    [self.view addSubview:Address];
    if (self.sheng||self.shi||self.qu) {
        Address.text = [NSString stringWithFormat:@"%@ %@ %@",self.sheng,self.shi,self.qu];
    }
    self.Address = Address;
    
    
    
    //门牌号
    TLTextField * DoorNum = [[TLTextField alloc]initWithFrame:CGRectMake(margin, Address.yy, SCREEN_WIDTH-30, 80) leftTitle:@"门牌号" placeholder:@"10号楼5层501室"];
    [self.view addSubview:DoorNum];
    if (self.DoorNumString) {
        DoorNum.text = self.DoorNumString;
    }
    self.DoorNum = DoorNum;

    
    
    UIButton *confirmBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"确认" key:nil] titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16.0 cornerRadius:5];
    confirmBtn.frame = CGRectMake(15, DoorNum.yy + 80, kScreenWidth - 30, 42);
    [self.view addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
}
-(void)confirm{
    NSLog(@"%s",__func__);
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = self.code;
    if (self.state == 1) {
        http.parameters[@"code"] = self.AddressCode;
    }
    if (![self.Phone.text isPhoneNum]) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的手机号" key:nil]];
        return;
    }
    if (self.Name.text.length == 0) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入姓名" key:nil]];
        return;
    }
    if (self.Address.text.length == 0) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入地址" key:nil]];
        return;
    }
    if (self.DoorNum.text.length == 0) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入详细地址" key:nil]];
        return;
    }
    http.parameters[@"addressee"] = self.Name.text;
    http.parameters[@"mobile"] = self.Phone.text;
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"detailAddress"] = self.DoorNum.text;
    http.parameters[@"province"] = self.sheng;
    http.parameters[@"city"] = self.shi;
    http.parameters[@"isDefault"] = @"0";
    http.parameters[@"district"] = self.qu;
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"添加成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(AddressPickView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AddressPickView alloc] init];
    }
    return _pickerView;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    [self pickerView];
    
    [_pickerView show];
    
    __weak typeof(self) weakSelf = self;
    //block传值
    _pickerView.determineBtnBlock = ^(NSString *shengId, NSString *shiId, NSString *xianId, NSString *shengName, NSString *shiName, NSString *xianName, NSString *postCode) {
        weakSelf.sheng = shengName;
        weakSelf.shi = shiName;
        weakSelf.qu = xianName;
        weakSelf.Address.text = [NSString stringWithFormat:@"%@ %@ %@",shengName,shiName,xianName];
    };
}

@end
