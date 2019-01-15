//
//  TLUserLoginVC.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/12.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "TLUserLoginVC.h"

#import "BindMobileVC.h"
#import "TLUserRegisterVC.h"
#import "TLUserForgetPwdVC.h"

#import "APICodeMacro.h"
#import "AppMacro.h"
#import "NSString+Check.h"
#import "UIBarButtonItem+convience.h"
#import "UILabel+Extension.h"

//#import "CurrencyModel.h"

#import "AccountTf.h"

//腾讯云

//#import <ImSDK/TIMManager.h>

@interface TLUserLoginVC ()


@property (nonatomic,strong) UITextField * phone;
@property (nonatomic,strong) UITextField * pwd;

@property (nonatomic,strong)  UILabel * welcome;
@property (nonatomic,strong) UILabel * weichat;

@property (nonatomic, copy) NSString *verifyCode;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic,strong) UIView * phoneview;
@property (nonatomic,strong) UIView * pwdview;
@end

@implementation TLUserLoginVC

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    //    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    [self navigationwhiteColor];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self navigationSetDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.title = [LangSwitcher switchLang:@"登录" key:nil];
    self.title = @"登录";
    self.welcome = [[UILabel alloc]initWithFrame:CGRectMake(30, 139-64, 97, 33.5)];
    self.welcome.text = @"欢迎回来";
    self.welcome.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:24];
    self.welcome.textColor = [UIColor colorWithHexString:@"#2D2D2D"];
    [self.view addSubview:self.welcome];
    
    
    
    
    [self setUpUI];
    //腾讯云登录成功
    //    [self setUpNotification];
    
    
}

#pragma mark - Init

- (void)setUpUI {
    
    self.view.backgroundColor = kBackgroundColor;
    
    CGFloat w = kScreenWidth;
    CGFloat h = ACCOUNT_HEIGHT;
    
    
    //账号
    UITextField * phone = [[UITextField alloc]initWithFrame:CGRectMake(30, self.welcome.yy + 36 ,w-60, 55)];
    phone.placeholder = @"请输入账号";
    phone.borderStyle = UITextBorderStyleNone;
    phone.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    phone.textColor = [UIColor colorWithHexString:@"#333333"];
    [phone resignFirstResponder];
    [self.view addSubview:phone];
    phone.tag = 0;
    phone.delegate = self;
    self.phone = phone;
    
    //phoneview
    self.phoneview = [self createview:CGRectMake(30, phone.yy, w-60, 1)];
    [self.view addSubview:self.phoneview];
    
    //密码
    UITextField * pwd = [[UITextField alloc]initWithFrame:CGRectMake(30, phone.yy + 10 , w-60, 55)];
    pwd.placeholder = @"请输入密码（6～16个字符或字母组成）";
    pwd.borderStyle = UITextBorderStyleNone;
    pwd.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    pwd.textColor = [UIColor colorWithHexString:@"#333333"];
    pwd.tag = 1;
    pwd.delegate = self;
    pwd.secureTextEntry = YES;
    [self.view addSubview:pwd];
    
    //pwdview
    self.pwdview = [self createview:CGRectMake(30, pwd.yy, w-60, 1)];
    [self.view addSubview:self.pwdview];
    
    //登录
    UIButton *loginBtn = [UIButton buttonWithTitle:@"登录" titleColor:[UIColor colorWithHexString:@"#FFFFFF"] backgroundColor:[UIColor colorWithHexString:@"#23AD8C"] titleFont:16.0 cornerRadius:4];
    loginBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16.0];
    [loginBtn addTarget:self action:@selector(goLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@(30));
        make.height.equalTo(@(45));
        make.right.equalTo(@(-30));
        make.top.equalTo(pwd.mas_bottom).offset(40);
        
    }];
    
    //立即注册
    UIButton * registerbtn = [UIButton buttonWithTitle:@"立即注册" titleColor:kTextColor2 backgroundColor:kClearColor titleFont:13.0];
    registerbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:registerbtn];
    [registerbtn addTarget:self action:@selector(goReg) forControlEvents:UIControlEventTouchUpInside];
    [registerbtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(loginBtn.mas_left);
        make.top.equalTo(loginBtn.mas_bottom).offset(20);
        make.width.equalTo(@(55));
        make.height.equalTo(@(18.5));
    }];
    
    
    //找回密码
    UIButton *forgetPwdBtn = [UIButton buttonWithTitle:@"忘记密码？" titleColor:kTextColor2 backgroundColor:kClearColor titleFont:13.0];
    forgetPwdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [forgetPwdBtn addTarget:self action:@selector(findPwd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPwdBtn];
    
    [forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@(70));
        make.height.equalTo(@(18.5));
        make.right.equalTo(loginBtn.mas_right);
        make.top.equalTo(loginBtn.mas_bottom).offset(20);
        
    }];
    
    [self.view addSubview: [self createview:CGRectMake(113, 510, 15, 1)]];
    
    UIImageView * weichatlogin = [[UIImageView alloc]initWithFrame:CGRectMake(136, 502, 20, 17)];
    weichatlogin.image = [UIImage imageNamed:@"微信登录"];
    [self.view addSubview:weichatlogin];
    
    self.weichat = [[UILabel alloc]initWithFrame:CGRectMake(163, 501, 78, 19)];
    self.weichat.text = @"微信快速登录";
    self.weichat.textAlignment = NSTextAlignmentCenter;
    self.weichat.textColor = kTextColor2;
    self.weichat.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    [self.view addSubview:self.weichat];
    
    [self.view addSubview: [self createview:CGRectMake(249, 510, 15, 1)]];
    
}

#pragma mark - Events

- (void)back {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)findPwd {
    
    TLUserForgetPwdVC *vc = [[TLUserForgetPwdVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)goReg {
    
    TLUserRegisterVC *registerVC = [[TLUserRegisterVC alloc] init];
    
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

- (void)goLogin {
    if (![self.phone.text isPhoneNum]) {
        [TLAlert alertWithInfo:@"请输入正确的账号"];
        return;
    }
    if (!(self.pwd.text && self.pwd.text.length > 5)) {
        [TLAlert alertWithInfo:@"请输入正确的密码"];
        return;
    }
    [self.view endEditing:YES];
    
}

- (void)requesUserInfoWithResponseObject:(id)responseObject {
    
    NSString *token = responseObject[@"data"][@"token"];
    NSString *userId = responseObject[@"data"][@"userId"];
    
    //保存用户账号和密码
    //    [[TLUser user] saveUserName:self.phoneTf.text pwd:self.pwdTf.text];
    
    //1.获取用户信息
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = USER_INFO;
    http.parameters[@"userId"] = userId;
    http.parameters[@"token"] = token;
    [http postWithSuccess:^(id responseObject) {
        
        NSDictionary *userInfo = responseObject[@"data"];
        
        [TLUser user].userId = userId;
        [TLUser user].token = token;
        
        //保存用户信息
        [[TLUser user] saveUserInfo:userInfo];
        //初始化用户信息
        [[TLUser user] setUserInfoWithDict:userInfo];
        //
        [self dismissViewControllerAnimated:YES completion:nil];
        
        if (self.loginSuccess) {
            
            self.loginSuccess();
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginNotification object:nil];
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

//
- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    NSString *callbackString =
    [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
     [self logSet:tags], alias];
    
    NSLog(@"TagsAlias回调:%@", callbackString);
}

- (NSString *)logSet:(NSSet *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == 0) {
        self.phoneview.backgroundColor = [UIColor blackColor];
    }
    else{
        self.pwdview.backgroundColor = [UIColor blackColor];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 0) {
        self.phoneview.backgroundColor = [UIColor grayColor];
    }
    else{
        self.pwdview.backgroundColor = [UIColor grayColor];
    }
}

-(UIView*)createview:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kLineColor;
    return view;
}
@end
