//
//  ChangeLoginPwdVC.m
//  Coin
//
//  Created by 蔡卓越 on 2017/12/12.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "ChangeLoginPwdVC.h"

#import "TLTextField.h"
#import "TLUser.h"

#import "APICodeMacro.h"
#import "NSString+Check.h"

@interface ChangeLoginPwdVC ()
//谷歌验证码
//@property (nonatomic, strong) TLTextField *googleAuthTF;
//旧密码
@property (nonatomic,strong) TLTextField *oldPwdTf;
//新密码
@property (nonatomic,strong) TLTextField *rePwdTf;

@end

@implementation ChangeLoginPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [LangSwitcher switchLang:@"修改登录密码" key:nil];

    [self setUpUI];

}

#pragma mark - Init

- (void)setUpUI {

    TLTextField *oldPwdTf = [[TLTextField alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 55) placeholder:@"请输入原密码(不少于6位)"];
    oldPwdTf.returnKeyType = UIReturnKeyNext;
    oldPwdTf.secureTextEntry = YES;
    [oldPwdTf addTarget:self action:@selector(next:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.view addSubview:oldPwdTf];
    self.oldPwdTf = oldPwdTf;
    
    //重新输入
//    TLTextField *rePwdTf = [[TLTextField alloc] initWithFrame:CGRectMake(0, oldPwdTf.yy + 1, kScreenWidth, height)
//                                                    leftTitle:[LangSwitcher switchLang:@"新密码" key:nil]
//                                                   titleWidth:leftW
//                                                  placeholder:[LangSwitcher switchLang:@"请输入新密码(不少于6位)" key:nil]];
    TLTextField *rePwdTf = [[TLTextField alloc]initWithFrame:CGRectMake(15, 55, SCREEN_WIDTH - 30, 55) placeholder:@"请输入新密码(不少于6位)"];
    
    rePwdTf.returnKeyType = UIReturnKeyDone;
    
    [rePwdTf addTarget:self action:@selector(done:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.view addSubview:rePwdTf];
    rePwdTf.secureTextEntry = YES;
    
    self.rePwdTf = rePwdTf;
    
    NSString *btnStr = [LangSwitcher switchLang:@"确认修改" key:nil];
    
    //确认按钮
    UIButton *confirmBtn = [UIButton buttonWithTitle:btnStr titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:15.0 cornerRadius:5];
    
    confirmBtn.frame = CGRectMake(15, rePwdTf.yy + 30, kScreenWidth - 30, 44);
    [self.view addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - Events
//- (void)clickPaste {
//
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//
//    if (pasteboard.string != nil) {
//
//        self.googleAuthTF.text = pasteboard.string;
//
//    } else {
//
//        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"粘贴内容为空" key:nil]];
//    }
//}

- (void)next:(UIButton *)sender {
    
    [_rePwdTf becomeFirstResponder];
}

- (void)done:(UIButton *)sender {
    
    [_rePwdTf resignFirstResponder];
}

- (void)confirm {
    
//    if ([TLUser user].isGoogleAuthOpen) {
//
//        if (![self.googleAuthTF.text valid]) {
//
//            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入谷歌验证码" key:nil]];
//            return;
//        }
//
//        //判断谷歌验证码是否为纯数字
//        if (![NSString isPureNumWithString:self.googleAuthTF.text]) {
//
//            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的谷歌验证码" key:nil]];
//            return ;
//        }
//
//        //判断谷歌验证码是否为6位
//        if (self.googleAuthTF.text.length != 6) {
//
//            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的谷歌验证码" key:nil]];
//            return ;
//        }
//    }
    
    if (!([self.oldPwdTf.text valid])) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入旧密码" key:nil]];
        return;
    }
    
    if (!(self.oldPwdTf.text.length > 5)) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入6位以上旧密码" key:nil]];
        return;
    }
    
    if (!([self.rePwdTf.text valid])) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入新密码" key:nil]];
        return;
    }
    
    if (!(self.rePwdTf.text.length > 5)) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入6位以上新密码" key:nil]];
        return;
    }
    
    if ([self.oldPwdTf.text isEqualToString:self.rePwdTf.text]) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"新登录密码不能与原有密码重复" key:nil]];
        return;
        
    }
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    
    http.code = USER_CHANGE_PWD_CODE;
    http.parameters[@"oldLoginPwd"] = self.oldPwdTf.text;
    http.parameters[@"newLoginPwd"] = self.rePwdTf.text;
    http.parameters[@"userId"] = [TLUser user].userId;
    
//    if ([TLUser user].isGoogleAuthOpen) {
//
//        http.parameters[@"googleCaptcha"] = self.googleAuthTF.text;
//
//    }
    
    [http postWithSuccess:^(id responseObject) {
        
        NSString *promptStr = [LangSwitcher switchLang:@"修改成功" key:nil];
        //保存用户账号和密码
//        [[TLUser user] saveUserName:[TLUser user].mobile pwd:self.rePwdTf.text];
        
        [TLAlert alertWithSucces:promptStr];
        
        [[TLUser user] updateUserInfo];
        
        if (self.success) {
            
            self.success();
        }
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        
        
    }];
    //
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
