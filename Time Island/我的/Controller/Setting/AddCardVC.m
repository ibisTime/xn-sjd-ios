//
//  AddCardVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "AddCardVC.h"
#import "TLCaptchaView.h"
@interface AddCardVC ()
@property (nonatomic,strong) TLTextField * CardNum;
@property (nonatomic,strong) TLTextField * BankName;
@property (nonatomic,strong) TLTextField * CardName;
@property (nonatomic,strong) TLTextField * CardUserName;
@property (nonatomic,strong) TLTextField * CardUserId;
@property (nonatomic,strong) TLTextField * CardUserPhone;
@property (nonatomic,strong) TLCaptchaView *captchaView;
@end

@implementation AddCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加银行卡";
    [self setup];
    
}

-(void)setup{
    CGFloat margin = 15;
    CGFloat height = 55;
    
    //银行卡
    TLTextField * CardNum = [[TLTextField alloc]initWithFrame:CGRectMake(margin, 0, SCREEN_WIDTH-30, height) leftTitle:@"银行卡" placeholder:@"银行卡类型"];
    [self.view addSubview:CardNum];
    self.CardNum = CardNum;
    
    //银行名称
    TLTextField * BankName = [[TLTextField alloc]initWithFrame:CGRectMake(margin, CardNum.yy, SCREEN_WIDTH - 30, height) leftTitle:@"银行名称" placeholder:@"银行名称"];
    [self.view addSubview:BankName];
    self.BankName = BankName;
    
    
    //支行名称
    TLTextField * CardName = [[TLTextField alloc]initWithFrame:CGRectMake(margin, BankName.yy, SCREEN_WIDTH-30, height) leftTitle:@"支行名称" placeholder:@"银行卡支行名称"];
    [self.view addSubview:CardName];
    self.CardName = CardName;
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, CardName.yy, SCREEN_WIDTH, 10)];
    view.backgroundColor = kLineColor;
    [self.view addSubview:view];
    
    //持卡人
    TLTextField * CardUserName = [[TLTextField alloc]initWithFrame:CGRectMake(margin, CardName.yy + 10, SCREEN_WIDTH - 30, height) leftTitle:@"持卡人" placeholder:@"持卡人姓名"];
    [self.view addSubview:CardUserName];
    self.CardUserName = CardUserName;
    
    
    //身份证
     TLTextField * CardUserId = [[TLTextField alloc]initWithFrame:CGRectMake(margin, CardUserName.yy, SCREEN_WIDTH - 30, height) leftTitle:@"身份证" placeholder:@"持卡人身份证号"];
    [self.view addSubview:CardUserId];
    self.CardUserId = CardUserId;
    
    //手机号
     TLTextField * CardUserPhone = [[TLTextField alloc]initWithFrame:CGRectMake(margin, CardUserId.yy + 10, SCREEN_WIDTH - 30, height) leftTitle:@"手机号" placeholder:@"银行预留手机号"];
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
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"802020";
    http.parameters[@"bankcardNumber"] = self.CardNum.text;
    http.parameters[@"bindMobile"] = self.CardUserPhone.text;
    http.parameters[@"smsCaptcha"] = self.captchaView.captchaTf.text;
    http.parameters[@"realName"] = self.CardUserName.text;
//    http.parameters[@"subbranch"] = self.
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
