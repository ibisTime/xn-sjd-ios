//
//  MailVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MailVC.h"
#import "TLCaptchaView.h"
@interface MailVC ()
@property (nonatomic,strong) TLTextField * mailadd;
@property (nonatomic,strong) TLCaptchaView *captchaView;
@end

@implementation MailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[TLUser user]email]) {
        
        UILabel * label = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 55) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(18) textColor:kTextBlack];
        label.text = [@"已绑定邮箱 " stringByAppendingFormat:@"%@",[TLUser user].email];
        
        [self.view addSubview:label];
        
        TLTextField * mailadd = [[TLTextField alloc]initWithFrame:CGRectMake(15, label.yy, SCREEN_WIDTH - 30, 55) placeholder:@"请输入新邮箱地址"];
        [self.view addSubview:mailadd];
        self.mailadd = mailadd;
        
        TLCaptchaView *captchaView = [[TLCaptchaView alloc] initWithFrame:CGRectMake(15, mailadd.yy + 1, mailadd.width, mailadd.height)];
        [self.view addSubview:captchaView];
        self.captchaView = captchaView;
        [captchaView.captchaBtn addTarget:self action:@selector(sendCaptcha) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *confirmBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"确认" key:nil] titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16.0 cornerRadius:5];
        
        confirmBtn.frame = CGRectMake(15, 220 + 112.5, kScreenWidth - 30, 44);
        [self.view addSubview:confirmBtn];
        [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        TLTextField * mailadd = [[TLTextField alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 55) placeholder:@"请输入新邮箱地址"];
        [self.view addSubview:mailadd];
        self.mailadd = mailadd;
        
        TLCaptchaView *captchaView = [[TLCaptchaView alloc] initWithFrame:CGRectMake(15, mailadd.yy + 1, mailadd.width, mailadd.height)];
        [self.view addSubview:captchaView];
        self.captchaView = captchaView;
        [captchaView.captchaBtn addTarget:self action:@selector(sendCaptcha) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        UIButton *confirmBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"确认" key:nil] titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16.0 cornerRadius:5];
        
        confirmBtn.frame = CGRectMake(15, 220 + 112.5, kScreenWidth - 30, 44);
        [self.view addSubview:confirmBtn];
        [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}
- (void)sendCaptcha {
    
    if (![self.mailadd.text isValidateEmail]) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的邮箱地址" key:nil]];
        
        return;
    }
    //
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = @"630093";
    http.parameters[@"bizType"] = @"805086";
    http.parameters[@"email"] = self.mailadd.text;
    
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"验证码已发送,请注意查收" key:nil]];
        
        [self.captchaView.captchaBtn begin];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)confirm {
    
    if (![self.mailadd.text isValidateEmail]) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的邮箱地址" key:nil]];
        return;
    }
    
    if (![self.captchaView.captchaTf.text valid] || self.captchaView.captchaTf.text.length < 4 ) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的验证码" key:nil]];
        return;
    }
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = @"805086";

    http.parameters[@"email"] = self.mailadd.text;
    http.parameters[@"captcha"] = self.captchaView.captchaTf.text;
    http.parameters[@"token"] = [TLUser user].token;
    http.parameters[@"userId"] = [TLUser user].userId;
    
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"修改成功" key:nil]];

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
