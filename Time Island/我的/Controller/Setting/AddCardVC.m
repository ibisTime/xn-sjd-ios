//
//  AddCardVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "AddCardVC.h"
#import "TLCaptchaView.h"
#import "CardModel.h"
@interface AddCardVC ()
@property (nonatomic,strong) TLTextField * CardType;
@property (nonatomic,strong) TLTextField * BankName;
@property (nonatomic,strong) TLTextField * CardName;
@property (nonatomic,strong) TLTextField * CardNum;
@property (nonatomic,strong) TLTextField * CardUserName;
@property (nonatomic,strong) TLTextField * CardUserId;
@property (nonatomic,strong) TLTextField * CardUserPhone;
@property (nonatomic,strong) TLCaptchaView *captchaView;
@property (nonatomic,assign) NSInteger BankSelectIndex;

@property (nonatomic , strong)NSMutableArray <CardModel *>*CardModels;
@end

@implementation AddCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加银行卡";
    [self getbank];
    [self setup];
    
}

-(void)setup{
    CGFloat margin = 15;
    CGFloat height = 55;
    
    //银行卡
//    TLTextField * CardType = [[TLTextField alloc]initWithFrame:CGRectMake(margin, 0, SCREEN_WIDTH-30, height) leftTitle:@"银行卡" placeholder:@"银行卡类型"];
//    [self.view addSubview:CardType];
//    self.CardType = CardType;
    
    //银行名称
    TLTextField * BankName = [[TLTextField alloc]initWithFrame:CGRectMake(margin, 0, SCREEN_WIDTH - 30, height) leftTitle:@"银行名称" placeholder:@"银行名称"];
    [self.view addSubview:BankName];
    BankName.delegate = self;
    self.BankName = BankName;
    
    
    //支行名称
//    TLTextField * CardName = [[TLTextField alloc]initWithFrame:CGRectMake(margin, BankName.yy, SCREEN_WIDTH-30, height) leftTitle:@"支行名称" placeholder:@"银行卡支行名称"];
//    [self.view addSubview:CardName];
//    self.CardName = CardName;

    //银行卡号
    TLTextField * CardNum = [[TLTextField alloc]initWithFrame:CGRectMake(margin, BankName.yy, SCREEN_WIDTH-30, height) leftTitle:@"卡号" placeholder:@"银行卡号"];
    [self.view addSubview:CardNum];
    self.CardNum = CardNum;
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, CardNum.yy, SCREEN_WIDTH, 10)];
    view.backgroundColor = kLineColor;
    [self.view addSubview:view];
    
    //持卡人
    TLTextField * CardUserName = [[TLTextField alloc]initWithFrame:CGRectMake(margin, CardNum.yy + 10, SCREEN_WIDTH - 30, height) leftTitle:@"持卡人" placeholder:@"持卡人姓名"];
    [self.view addSubview:CardUserName];
    self.CardUserName = CardUserName;
    
    
    //身份证
//     TLTextField * CardUserId = [[TLTextField alloc]initWithFrame:CGRectMake(margin, CardUserName.yy, SCREEN_WIDTH - 30, height) leftTitle:@"身份证" placeholder:@"持卡人身份证号"];
//    [self.view addSubview:CardUserId];
//    self.CardUserId = CardUserId;
    
    //手机号
     TLTextField * CardUserPhone = [[TLTextField alloc]initWithFrame:CGRectMake(margin, CardUserName.yy + 10, SCREEN_WIDTH - 30, height) leftTitle:@"手机号" placeholder:@"银行预留手机号"];
    [self.view addSubview:CardUserPhone];
    self.CardUserPhone = CardUserPhone;
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(margin, CardUserPhone.yy, 70, CardUserPhone.height)];
    label.text = @"验证码";
    [self.view addSubview:label];
    //验证码
    TLCaptchaView *newCaptchaView = [[TLCaptchaView alloc] initWithFrame:CGRectMake(label.right, CardUserPhone.yy + 1, CardUserPhone.width - label.width, CardUserPhone.height)];
    
    [self.view addSubview:newCaptchaView];
    self.captchaView = newCaptchaView;
    [newCaptchaView.captchaBtn addTarget:self action:@selector(sendCaptcha) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *confirmBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"确认" key:nil] titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16.0 cornerRadius:5];
    
    confirmBtn.frame = CGRectMake(15, newCaptchaView.yy + 71.5, kScreenWidth - 30, 42);
    [self.view addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)sendCaptcha{
    NSLog(@"%s",__func__);
    if (![self.CardUserPhone.text isPhoneNum]) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的手机号" key:nil]];
        
        return;
    }
    //
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = CAPTCHA_CODE;
    http.parameters[@"bizType"] = @"802020";
    http.parameters[@"mobile"] = self.CardUserPhone.text;
    
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"验证码已发送,请注意查收" key:nil]];
        
        [self.captchaView.captchaBtn begin];
        
    } failure:^(NSError *error) {
        
    }];
}
-(void)confirm{
    if (self.BankName.text.length == 0) {
        [TLAlert alertWithInfo:@"请选择银行名称！"];
        return;
    }
    if (![self.CardNum.text isBankCardNo]) {
        [TLAlert alertWithInfo:@"请输入正确的银行卡号！"];
        return;
    }
    if (self.CardUserName.text.length == 0) {
        [TLAlert alertWithInfo:@"请输入持卡人姓名！"];
        return;
    }
    if (![self.CardUserPhone.text isPhoneNum]) {
        [TLAlert alertWithInfo:@"请输入正确的手机号！"];
        return;
    }
    if (self.captchaView.captchaTf.text.length == 0) {
        [TLAlert alertWithInfo:@"请输入验证码！"];
        return;
    }
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"802020";
    http.parameters[@"bankCode"] = self.CardModels[self.BankSelectIndex].bankCode;
    http.parameters[@"bankName"] = self.BankName.text;
    http.parameters[@"bankcardNumber"] = self.CardNum.text;
    http.parameters[@"bindMobile"] = self.CardUserPhone.text;
    http.parameters[@"currency"] = @"CNY";
    http.parameters[@"realName"] = self.CardUserName.text;
    http.parameters[@"smsCaptcha"] = self.captchaView.captchaTf.text;
    http.parameters[@"subbranch"] = @"";
    http.parameters[@"type"] = @"1";
    http.parameters[@"userId"] = [TLUser user].userId;
    
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"添加成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [TLAlert alertWithSucces:@"添加失败，请确认信息！"];
    }];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField resignFirstResponder];
   
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0;  i < self.CardModels.count; i ++) {
        [array addObject:[[SelectedListModel alloc] initWithSid:i Title:self.CardModels[i].bankName]];
    }
    SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
    view.isSingle = YES;
    view.array = array;
    view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
        [LEEAlert closeWithCompletionBlock:^{
            SelectedListModel *model = array[0];
            NSLog(@"选中第%ld行" , model.sid);
            self.BankName.text = model.title;
            self.BankSelectIndex = model.sid;
            
        }];
    };
    [LEEAlert alert].config
    .LeeTitle(@"选择银行卡")
    .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
    .LeeCustomView(view)
    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
    .LeeClickBackgroundClose(YES)
    .LeeShow();
    
}
-(void)getbank{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"802116";
    http.parameters[@""] = @"1";
    [http postWithSuccess:^(id responseObject) {
        self.CardModels = [CardModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
    } failure:^(NSError *error) {
    }];
}
@end
