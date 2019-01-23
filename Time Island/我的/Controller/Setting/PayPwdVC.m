//
//  PayPwdVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "PayPwdVC.h"
#import "TLCaptchaView.h"
@interface PayPwdVC ()
@property (nonatomic,strong) TLTextField * PayPwdPhone;
@property (nonatomic,strong) TLCaptchaView *captchaView;
@property (nonatomic,strong) TLTextField * PayPwd;
@end

@implementation PayPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TLTextField * PayPwdPhone = [[TLTextField alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 55) placeholder:@"请输入手机号"];
    PayPwdPhone.text = [TLUser user].mobile;
    [self.view addSubview:PayPwdPhone];
    self.PayPwdPhone = PayPwdPhone;
    
    TLCaptchaView *captchaView = [[TLCaptchaView alloc] initWithFrame:CGRectMake(15, PayPwdPhone.yy + 1, PayPwdPhone.width, PayPwdPhone.height)];
    [self.view addSubview:captchaView];
    self.captchaView = captchaView;
    [captchaView.captchaBtn addTarget:self action:@selector(sendCaptcha) forControlEvents:UIControlEventTouchUpInside];
    
    
    TLTextField * PayPwd = [[TLTextField alloc]initWithFrame:CGRectMake(15, captchaView.yy, SCREEN_WIDTH, 55) placeholder:@"请输入支付密码（至少6个字符）"];
    PayPwd.isSecurity = YES;
    [self.view addSubview:PayPwd];
    self.PayPwd = PayPwd;
    
    UIButton *confirmBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"确认" key:nil] titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16.0 cornerRadius:5];
    
    confirmBtn.frame = CGRectMake(15, 220 + 112.5, kScreenWidth - 30, 44);
    [self.view addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
}

- (void)sendCaptcha {
    
    if (![self.PayPwdPhone.text isPhoneNum]) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的手机号" key:nil]];
        
        return;
    }
    //
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = CAPTCHA_CODE;
    http.parameters[@"bizType"] = @"805066";
    http.parameters[@"mobile"] = self.PayPwdPhone.text;
    
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"验证码已发送,请注意查收" key:nil]];
        
        [self.captchaView.captchaBtn begin];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)confirm {
    
    if (![self.PayPwdPhone.text isPhoneNum]) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的手机号" key:nil]];
        return;
    }
    
    if (![self.captchaView.captchaTf.text valid] || self.captchaView.captchaTf.text.length < 4 ) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的验证码" key:nil]];
        return;
    }
    if(self.PayPwd.text.length < 6){
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"支付密码至少6个字符" key:nil]];
        return;
    }
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = @"805066";
    
    http.parameters[@"tradePwd"] = self.PayPwd.text;
    http.parameters[@"smsCaptcha"] = self.captchaView.captchaTf.text;
    http.parameters[@"userId"] = [TLUser user].userId;
    
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"设置成功" key:nil]];
        
        [[TLUser user] updateUserInfo];
        
        //保存用户账号和密码
        //        [[TLUser user] saveUserName:self.phoneTf.text pwd:[TLUser user].userPassward];
        
        [self.navigationController popViewControllerAnimated:YES];
        //        if (self.done) {
        //            self.done(self.mailadd.text);
        //        }
        
    } failure:^(NSError *error) {
        
    }];
}

@end
