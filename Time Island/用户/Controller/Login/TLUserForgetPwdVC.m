//
//  TLUserForgetPwdVC.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/12.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "TLUserForgetPwdVC.h"
#import "CaptchaView.h"
#import "NSString+Check.h"
#import "APICodeMacro.h"

@interface TLUserForgetPwdVC ()

@property (nonatomic,strong) TLTextField *phoneTf;

@property (nonatomic,strong) TLTextField *pwdTf;

@property (nonatomic,strong) TLTextField *rePwdTf;

@property (nonatomic, strong) CaptchaView *captchaView;

@end

@implementation TLUserForgetPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [LangSwitcher switchLang:@"找回密码" key:nil];
    
    self.view.backgroundColor = kWhiteColor;
    
    [self initSubviews];
    
}

- (void)initSubviews {

    self.view.backgroundColor = kBackgroundColor;
    
    CGFloat margin = ACCOUNT_MARGIN;
    CGFloat w = kScreenWidth - 2*margin;
    CGFloat h = ACCOUNT_HEIGHT;
    
    CGFloat btnMargin = 15;
    
    //账号
     TLTextField *phoneTf = [[TLTextField alloc] initWithFrame:CGRectMake(margin, 10, w, h) leftTitle:[LangSwitcher switchLang:@"账号" key:nil] titleWidth:100 placeholder:[LangSwitcher switchLang:@"请输入手机号或邮箱" key:nil]];
    [self.view addSubview:phoneTf];
    self.phoneTf = phoneTf;
    
    //验证码
    CaptchaView *captchaView = [[CaptchaView alloc] initWithFrame:CGRectMake(margin, phoneTf.yy + 1, w, h)];
    [captchaView.captchaBtn addTarget:self action:@selector(sendCaptcha) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:captchaView];
    
    self.captchaView = captchaView;
    
    //密码
    TLTextField *pwdTf = [[TLTextField alloc] initWithFrame:CGRectMake(margin, captchaView.yy + 10, w, h) leftTitle:[LangSwitcher switchLang:@"新密码" key:nil] titleWidth:100 placeholder:[LangSwitcher switchLang:@"请输入密码" key:nil]];
    pwdTf.secureTextEntry = YES;
    
    [self.view addSubview:pwdTf];
    self.pwdTf = pwdTf;
    
    //re密码
    TLTextField *rePwdTf = [[TLTextField alloc] initWithFrame:CGRectMake(margin, pwdTf.yy + 1, w, h) leftTitle:[LangSwitcher switchLang:@"确认密码" key:nil] titleWidth:100 placeholder:[LangSwitcher switchLang:@"确认密码" key:nil]];
    rePwdTf.secureTextEntry = YES;
    [self.view addSubview:rePwdTf];
    self.rePwdTf = rePwdTf;
    
    for (int i = 0; i < 2; i++) {
        
        UIView *line = [[UIView alloc] init];
        
        line.backgroundColor = [UIColor lineColor];
        
        [self.view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(margin);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
            make.top.mas_equalTo(10 + h + i*(2*h + 10 + 1));
            
        }];
    }
    
    //
    UIButton *confirmBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"确认" key:nil] titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16.0 cornerRadius:5];
    
    [confirmBtn addTarget:self action:@selector(changePwd) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(btnMargin);
        make.width.mas_equalTo(kScreenWidth - 2*btnMargin);
        make.height.mas_equalTo(h - 5);
        make.top.mas_equalTo(rePwdTf.mas_bottom).mas_equalTo(40);
        
    }];
}

#pragma mark - Events
- (void)sendCaptcha {
    
    if (![self.phoneTf.text isPhoneNum]) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的账号" key:nil]];

        return;
    }
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    if([self.phoneTf.text containsString:@"@"])
    {
        http.code = @"504832";
        http.parameters[@"email"] = self.phoneTf.text;

    }else{
        http.code = CAPTCHA_CODE;
        http.parameters[@"mobile"] = self.phoneTf.text;

    }
    http.parameters[@"bizType"] = USER_FIND_PWD_CODE;
    
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"验证码已发送,请注意查收" key:nil]];
        
        [self.captchaView.captchaBtn begin];
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

- (void)changePwd {
    
    if (![self.phoneTf.text isPhoneNum]) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的账号" key:nil]];
        
        return;
    }
    
    if (!(self.captchaView.captchaTf.text && self.captchaView.captchaTf.text.length > 3)) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的验证码" key:nil]];
        
        return;
    }
    
    if (!(self.pwdTf.text &&self.pwdTf.text.length > 5)) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入6位以上密码" key:nil]];
        return;
    }
    
    if (![self.pwdTf.text isEqualToString:self.rePwdTf.text]) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"输入的密码不一致" key:nil]];
        return;
        
    }
    
    [self.view endEditing:YES];

    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = USER_FIND_PWD_CODE;
    http.parameters[@"mobile"] = self.phoneTf.text;
    http.parameters[@"smsCaptcha"] = self.captchaView.captchaTf.text;
    http.parameters[@"newLoginPwd"] = self.pwdTf.text;
    http.parameters[@"kind"] = APP_KIND;
    
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"找回成功" key:nil]];
        
        //保存用户账号和密码
//        [[TLUser user] saveUserName:self.phoneTf.text pwd:self.pwdTf.text];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
            
        });
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
