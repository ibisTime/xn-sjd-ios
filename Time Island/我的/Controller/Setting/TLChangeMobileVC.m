//
//  ZHChangeMobileVC.m
//  ZHBusiness
//
//  Created by  蔡卓越 on 2016/12/12.
//  Copyright © 2016年  caizhuoyue. All rights reserved.
//

#import "TLChangeMobileVC.h"

#import "TLPwdRelatedVC.h"

#import "TLCaptchaView.h"
#import "TLTextField.h"

#import "TLUser.h"

#import "NSString+Check.h"
#import "APICodeMacro.h"

@interface TLChangeMobileVC ()

@property (nonatomic,strong) TLTextField *OldphoneTf;
@property (nonatomic,strong) TLTextField *NewphoneTf;
@property (nonatomic,strong) TLCaptchaView *newcaptchaView;
@property (nonatomic,strong) TLCaptchaView *oldcaptchaView;

//@property (nonatomic,strong) TLTextField *tradePwdTf;
@end

@implementation TLChangeMobileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    CGFloat leftW = 90;
    self.title = [LangSwitcher switchLang:@"修改手机号" key:nil];
    CGFloat leftMargin = 15;
    
    //旧手机号
    TLTextField * OldphoneTf = [[TLTextField alloc]initWithFrame:CGRectMake(leftMargin, 0, kScreenWidth - 2*leftMargin, 55) placeholder:@"请输入旧手机号"];
    OldphoneTf.text = [[TLUser user]mobile];
    OldphoneTf.keyboardType = UIKeyboardTypeNumberPad;
    [self.bgSV addSubview:OldphoneTf];
    self.OldphoneTf = OldphoneTf;
    [self createview:CGRectMake(15, self.OldphoneTf.xx - 1, SCREEN_WIDTH - 30, 1)];

    //新手机号
    TLTextField * NewphoneTf = [[TLTextField alloc]initWithFrame:CGRectMake(leftMargin, 55, kScreenWidth - 2*leftMargin, 55) placeholder:@"请输入新手机号"];
    NewphoneTf.keyboardType = UIKeyboardTypeNumberPad;
    [self.bgSV addSubview:NewphoneTf];
    self.NewphoneTf = NewphoneTf;
    [self createview:CGRectMake(15, self.NewphoneTf.xx - 1, SCREEN_WIDTH - 30, 1)];
    
    //验证码
    TLCaptchaView *newcaptchaView = [[TLCaptchaView alloc] initWithFrame:CGRectMake(NewphoneTf.x, NewphoneTf.yy + 1, NewphoneTf.width, NewphoneTf.height)];
    [self.bgSV addSubview:newcaptchaView];
    self.newcaptchaView = newcaptchaView;
    [newcaptchaView.captchaBtn addTarget:self action:@selector(sendCaptcha) forControlEvents:UIControlEventTouchUpInside];
    

//    }
   

  
    
    //确认按钮
    UIButton *confirmBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"确认修改" key:nil] titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16.0 cornerRadius:5];
    
    confirmBtn.frame = CGRectMake(15, 220 + 112.5, kScreenWidth - 30, 44);
    [self.bgSV addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    

    
}

- (void)setTrade:(UIButton *)btn {

    TLPwdRelatedVC *tradeVC = [[TLPwdRelatedVC alloc] initWithType:TLPwdTypeTradeReset];
    tradeVC.success = ^() {
        
        btn.hidden = YES;
        
    };
    [self.navigationController pushViewController:tradeVC animated:YES];


}

- (void)sendCaptcha {

    if (![self.NewphoneTf.text isPhoneNum]) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的手机号" key:nil]];
        
        return;
    }
//    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = CAPTCHA_CODE;
    http.parameters[@"bizType"] = USER_CAHNGE_MOBILE;
    http.parameters[@"mobile"] = self.OldphoneTf.text;
  
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"验证码已发送,请注意查收" key:nil]];

        [self.newcaptchaView.captchaBtn begin];
        
    } failure:^(NSError *error) {
        
    }];


}

- (void)confirm {
    
    if (![self.OldphoneTf.text isPhoneNum]) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的手机号" key:nil]];
        return;
    }
    
    if (![self.newcaptchaView.captchaTf.text valid] || self.newcaptchaView.captchaTf.text.length < 4 ) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的验证码" key:nil]];
        return;
    }

    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = USER_CAHNGE_MOBILE;
    http.parameters[@"newMobile"] = self.NewphoneTf.text;
    http.parameters[@"smsCaptcha"] = self.newcaptchaView.captchaTf.text;
    http.parameters[@"token"] = [TLUser user].token;
    http.parameters[@"userId"] = [TLUser user].userId;
   
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"修改成功" key:nil]];
        [TLUser user].mobile = self.NewphoneTf.text;
        [[TLUser user] updateUserInfo];

        //保存用户账号和密码
//        [[TLUser user] saveUserName:self.phoneTf.text pwd:[TLUser user].userPassward];
        
        [self.navigationController popViewControllerAnimated:YES];
        if (self.done) {
            self.done(self.NewphoneTf.text);
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//底部横线
-(UIView*)createview:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kLineColor;
    return view;
}
@end
