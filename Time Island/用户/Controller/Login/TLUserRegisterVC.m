//
//  TLUserRegisterVC.m
//  YS_iOS
//
//  Created by 蔡卓越 on 2017/6/8.
//  Copyright © 2017年 cuilukai. All rights reserved.
//

#import "TLUserRegisterVC.h"
//#import "SGScanningQRCodeVC.h"
#import <Photos/Photos.h>
#import "TLNavigationController.h"
#import "HTMLStrVC.h"

#import <CoreLocation/CoreLocation.h>

#import "CaptchaView.h"

#import "APICodeMacro.h"
#import "NSString+Check.h"

@interface TLUserRegisterVC ()<CLLocationManagerDelegate>


//昵称
//@property (nonatomic, strong) TLTextField *nickNameTF;
//@property (nonatomic, strong) TLTextField *referTF;
//
//
//@property (nonatomic,strong) TLTextField *phoneTf;
//
//@property (nonatomic,strong) TLTextField *pwdTf;
//
//@property (nonatomic,strong) TLTextField *rePwdTf;

//@property (nonatomic,strong) CLLocationManager *sysLocationManager;
//
@property (nonatomic,copy) NSString *province;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *area;
//同意按钮
@property (nonatomic, strong) UIButton *checkBtn;


@property (nonatomic,strong)  UILabel * welcome;
//账号
@property (nonatomic,strong) UITextField * phone;
@property (nonatomic,strong) UIView * phoneview;
//验证码
//@property (nonatomic,strong) UITextField * check;
@property (nonatomic,strong) CaptchaView *captchaView;
@property (nonatomic,strong) UIView * checkview;
//密码
@property (nonatomic,strong) UITextField * pwd;
@property (nonatomic,strong) UIView * pwdview;
//确认密码
@property (nonatomic,strong) UITextField * checkpwd;
@property (nonatomic,strong) UIView * checkpwdview;


@end

@implementation TLUserRegisterVC

-(void)viewWillAppear:(BOOL)animated{
    [self navigationwhiteColor];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"注册";
    self.welcome = [[UILabel alloc]initWithFrame:CGRectMake(30, 139-64, 48, 34)];
    self.welcome.text = @"注册";
    self.welcome.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:24];
    self.welcome.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.view addSubview:self.welcome];
    
    [self setUpUI];
    
}

#pragma mark - Events

- (void)setUpUI {
    
    self.view.backgroundColor = kBackgroundColor;
    
    //    CGFloat margin = ACCOUNT_MARGIN;
    CGFloat margin = 30;
    CGFloat w = kScreenWidth - 2*margin;
    CGFloat h = ACCOUNT_HEIGHT;
//    CGFloat titleWidth = 110;
    
    CGFloat btnMargin = 15;
    
    //账号
    UITextField * phone = [[UITextField alloc]initWithFrame:CGRectMake(margin, self.welcome.yy+38, w, h)];
//    [phone setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    phone.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    phone.placeholder = @"请输入手机号";
    phone.keyboardType = UIKeyboardTypeNumberPad;
    phone.delegate = self;
    phone.tag = 0;
    [self.view addSubview:phone];
    self.phone = phone;
    
    //phoneview
    self.phoneview = [self createview:CGRectMake(margin, phone.yy, w, 1)];
    [self.view addSubview:self.phoneview];
    
    //验证码
    self.captchaView = [[CaptchaView alloc]initWithFrame:CGRectMake(margin, self.phone.yy+10, w, h) leftTitleWidth:96];
    [self.captchaView.captchaBtn addTarget:self action:@selector(sendCaptcha) forControlEvents:UIControlEventTouchUpInside];
    self.captchaView.captchaTf.delegate = self;
    [self.view addSubview:self.captchaView];
    

    //checkview
    self.checkview = [self createview:CGRectMake(margin, self.captchaView.yy, w, 1)];
    [self.view addSubview:self.checkview];
    
    //密码
    UITextField * pwd = [[UITextField alloc]initWithFrame:CGRectMake(margin,self.captchaView.yy + 10, w, h)];
    pwd.secureTextEntry = YES;
    pwd.placeholder = @"请输入密码";
//    [pwd setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    pwd.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    pwd.delegate = self;
    pwd.tag = 2;
    [self.view addSubview:pwd];
    self.pwd = pwd;
    
    
    //pwdview
    self.pwdview = [self createview:CGRectMake(margin, pwd.yy, w, 1)];
    [self.view addSubview:self.pwdview];
    
    //确认密码
    UITextField * checkpwd = [[UITextField alloc]initWithFrame:CGRectMake(margin, pwd.yy + 10, w, h)];
    checkpwd.secureTextEntry = YES;
    checkpwd.placeholder = @"请确认密码";
//    [checkpwd setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    checkpwd.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    checkpwd.delegate = self;
    checkpwd.tag = 3;
    [self.view addSubview:checkpwd];
    self.checkpwd = checkpwd;
    
    //checkpwdview
    self.checkpwdview = [self createview:CGRectMake(margin, checkpwd.yy, w, 1)];
    [self.view addSubview:self.checkpwdview];
    
    
    //选择按钮
    UIButton *checkBtn = [UIButton buttonWithImageName:@"条款-未选中" selectedImageName:@"条款-选中"];
    
    checkBtn.selected = YES;
    [checkBtn addTarget:self action:@selector(clickSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:checkBtn];
    [checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.checkpwdview.mas_left);
        make.top.equalTo(self.checkpwdview.mas_bottom).offset(18);
        make.width.equalTo(@(12));
        make.height.equalTo(@(12));
        
    }];
    
    self.checkBtn = checkBtn;
    
    NSString *text = @"我已阅读并同意";
    
    //text
    UILabel *textLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:12];
    
    textLbl.text = text;
    
    textLbl.userInteractionEnabled = YES;
    
    [self.view addSubview:textLbl];
    [textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(checkBtn.mas_right).offset(5);
        make.centerY.equalTo(checkBtn.mas_centerY);
        
    }];
    
    UIButton *protocolBtn = [UIButton buttonWithTitle:@"《时间岛服务产品条款》" titleColor:kAppCustomMainColor backgroundColor:kClearColor titleFont:12.0];
    
    [protocolBtn addTarget:self action:@selector(readProtocal) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:protocolBtn];
    [protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(textLbl.mas_right);
        make.centerY.equalTo(checkBtn.mas_centerY);
        
    }];
    
    //注册按钮
    UIButton *confirmBtn = [UIButton buttonWithTitle:@"确认注册" titleColor:kWhiteColor backgroundColor:[UIColor colorWithHexString:@"#23AD8C"] titleFont:16.0 cornerRadius:5];
    [confirmBtn addTarget:self action:@selector(goReg) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(btnMargin);
        make.width.mas_equalTo(kScreenWidth - 2*btnMargin);
        make.height.mas_equalTo(h - 5);
        make.top.mas_equalTo(protocolBtn.mas_bottom).mas_equalTo(40);
        
    }];
}



#pragma mark - Events
- (void)sendCaptcha {
    
    if (![self.phone.text isPhoneNum]) {
        
        [TLAlert alertWithInfo:@"请输入正确的手机号"];
        
        return;
    }
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = CAPTCHA_CODE;
    http.parameters[@"bizType"] = USER_REG_CODE;
    http.parameters[@"mobile"] = self.phone.text;
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"验证码已发送,请注意查收" key:nil]];
//
        [self.captchaView.captchaBtn begin];
        
        
    } failure:^(NSError *error) {
        
        [TLAlert alertWithError:[LangSwitcher switchLang:@"发送失败,请检查手机号" key:nil]];
        
    }];
    
}

- (void)goReg {
    
    if (![self.phone.text isPhoneNum]) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的手机号" key:nil]];
        
        return;
    }
    
    if (!(self.pwd.text &&self.pwd.text.length > 5)) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入6位以上密码" key:nil]];
        return;
    }
    
    if (![self.pwd.text isEqualToString:self.checkpwd.text]) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"输入的密码不一致" key:nil]];
        return;
        
    }
    
    if (!self.checkBtn.selected) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请同意《时间岛服务产品条款》" key:nil]];
        return ;
    }
    
    [self.view endEditing:YES];
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = USER_REG_CODE;
    http.parameters[@"mobile"] = self.phone.text;
    http.parameters[@"loginPwd"] = self.pwd.text;
    //    http.parameters[@"isRegHx"] = @"0";
    http.parameters[@"smsCaptcha"] = self.captchaView.captchaTf.text;
//    http.parameters[@"kind"] = APP_KIND;
//    http.parameters[@"nickname"] = self.nickNameTF.text;
//    if ([self.referTF.text valid]) {
//
//        http.parameters[@"userReferee"] = self.referTF.text;
//        http.parameters[@"userRefereeKind"] = APP_KIND;
//
//    }
    
    [http postWithSuccess:^(id responseObject) {
        
        [self.view endEditing:YES];
        
        NSString *token = responseObject[@"data"][@"token"];
        NSString *userId = responseObject[@"data"][@"userId"];
        
        //保存用户账号和密码
        //        [[TLUser user] saveUserName:self.phoneTf.text pwd:self.pwdTf.text];
        
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //获取用户信息
        TLNetworking *http = [TLNetworking new];
        http.showView = self.view;
        http.code = USER_INFO;
        http.parameters[@"userId"] = userId;
        http.parameters[@"token"] = token;
        [http postWithSuccess:^(id responseObject) {
            
            [TLAlert alertWithSucces:[LangSwitcher switchLang:@"注册成功" key:nil]];
            NSDictionary *userInfo = responseObject[@"data"];
            [TLUser user].userId = userId;
            [TLUser user].token = token;
            
            //保存信息
            [[TLUser user] saveUserInfo:userInfo];
            [[TLUser user] setUserInfoWithDict:userInfo];
            //dismiss 掉
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginNotification object:nil];
            
        } failure:^(NSError *error) {
            
        }];
        
        //        });
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)clickSelect:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
}

- (void)readProtocal {
    
    HTMLStrVC *htmlVC = [[HTMLStrVC alloc] init];
    
    htmlVC.type = HTMLTypeRegProtocol;
    
    [self.navigationController pushViewController:htmlVC animated:YES];
    
}
-(UIView * )createview:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kLineColor;
    return view;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
            self.phoneview.backgroundColor = [UIColor blackColor];
            break;
        case 1:
            self.checkview.backgroundColor = [UIColor blackColor];
            break;
        case 2:
            self.pwdview.backgroundColor = [UIColor blackColor];
            break;
        case 3:
            self.checkpwdview.backgroundColor = [UIColor blackColor];
            break;
        default:
            break;
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
            self.phoneview.backgroundColor = kLineColor;
            break;
        case 1:
            self.checkview.backgroundColor = kLineColor;
            break;
        case 2:
            self.pwdview.backgroundColor = kLineColor;
            break;
        case 3:
            self.checkpwdview.backgroundColor = kLineColor;
            break;
        default:
            break;
    }
}
@end
