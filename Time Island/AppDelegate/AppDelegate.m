//
//  AppDelegate.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/2.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "AppDelegate.h"
#import "TLUIHeader.h"
#import "TLTabBarController.h"
#import "TLUser.h"
#import "TLNetworking.h"
#import "UITabBar+Badge.h"
#import "AppConfig.h"
#import "TLNavigationController.h"
#import "IQKeyboardManager.h"

#import "ZMChineseConvert.h"
//#import "SettingModel.h"

#import "LangSwitcher.h"
#import "CoinUtil.h"
#import "RespHandler.h"
#import "NBNetwork.h"
#import "CoinModel.h"
#import "TLTabBarController.h"
#import "TLUserLoginVC.h"

#import "TLWXManager.h"
//Extension

#import "IQKeyboardManager.h"

@interface AppDelegate ()
//<WeiboSDKDelegate>

//@property (nonatomic, strong) FBKVOController *chatKVOCtrl;   czy
@property (nonatomic, strong) RespHandler *respHandler;
@property (nonatomic ,assign) BOOL IsEnterBack;
//@property (nonatomic, strong) NSMutableArray <DataBaseModel *>*dataBaseModels;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //    [NSThread sleepForTimeInterval:2];
    
    //服务器环境7
    //    研发
    [AppConfig config].runEnv = RunEnvDev;
    //    测试
    //    [AppConfig config].runEnv = RunEnvTest;
    //    正式
    //    [AppConfig config].runEnv = RunEnvRelease;
    
    [AppConfig config].isChecking = NO;

    self.respHandler = [[RespHandler alloc] init];
    
    //    [MobClick profileSignInWithPUID:@"UserID"];
    //    [MobClick profileSignInWithPUID:@"UserID" provider:@"WB"];
    [NBNetworkConfig config].respDelegate = self.respHandler;
    //2.新版本请求
    [NBNetworkConfig config].baseUrl = [AppConfig config].apiUrl;
    
    //配置键盘
    [self configIQKeyboard];
    
//    [[TLWXManager manager] registerApp];
//    [WeiboSDK registerApp:@"947817370"];
//    [WeiboSDK enableDebugMode:YES];
    
    [self configWeibo];
    
    //配置友盟统计
//    [self configUManalytics];
//    [self configZendSdk];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //UIStatusBarStyleLightContent状态栏字体白色 UIStatusBarStyleDefault黑色
    
    //配置根控制器
    [self configRootViewController];
    [LangSwitcher startWithTraditional];
    //初始化为繁体

    
    //退出登录消息通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginOut)
                                                 name:kUserLoginOutNotification
                                               object:nil];
    //用户登录消息通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userLogin) name:kUserLoginNotification
                                               object:nil];
    
    
    
    
    [[TLUser user] updateUserInfo];
    // 登录时间变更到，didBecomeActive中
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginNotification
                                                        object:nil];
    
    
    
    
    
    //czy    [[IMAPlatform sharedInstance] configOnAppLaunchWithOptions:launchOptions];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        
    });
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //
    //        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    //
    //    });
    
    
    //
    return YES;
    
    
}

- (void)configWeibo
{
    
    
}

- (void)configZendSdk
{
    //    [ ZDKCoreLogger  setEnabled :YES ];
    //    [ ZDKCoreLogger  setLogLevel :ZDKLogLevelDebug ];
    //    [ZDKZendesk initializeWithAppId: @"71d2ca9aba0cccc12deebfbdd352fbae8c53cd8999dd10bc"
    //                           clientId: @"mobile_sdk_client_7af3526c83d0c1999bc3"
    //                         zendeskUrl: @"https://thachainhelp.zendesk.com"];
    //    id<ZDKObjCIdentity> userIdentity = [[ZDKObjCAnonymous alloc] initWithName:nil email:nil];
    //    [[ZDKZendesk instance] setIdentity:userIdentity];
    //
    //    [ZDKSupport initializeWithZendesk: [ZDKZendesk instance]];
    
    //    [ZDKLocalization localizedStringWithKey:@"en"];
    // //hc/en-us
    //    [ZDKSupport initializeWithZendesk: [ZDKZendesk instance]];
    //                         zendeskUrl: @"https://hzcl.zendesk.com/hc/ko"];
    //    ZDKRequest
    
}


#pragma mark- 上传推送 token
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//
//czy
//    [[IMAPlatform sharedInstance] configOnAppRegistAPNSWithDeviceToken:deviceToken];
//
//}



// 用户重新登录需要重新，需要重新调用此方法监听czy
//- (void)kvoUnReadMsgToChangeTabbar {
//
//    //这里监听主要是为了，tabbar上的消息提示, 和icon上的图标
//    // 此处有坑， [IMAPlatform sharedInstance].conversationMgr 切换账户是会销毁
//    self.chatKVOCtrl = [FBKVOController controllerWithObserver:self];
//    [self.chatKVOCtrl observe:[IMAPlatform sharedInstance].conversationMgr
//                        keyPath:@"unReadMessageCount"
//                        options:NSKeyValueObservingOptionNew
//                          block:^(id observer, id object, NSDictionary *change) {
//
//                              NSInteger count =  [IMAPlatform sharedInstance].conversationMgr.unReadMessageCount;
//
//                              int location = 4;
//                              if (count > 0) {
//
//                                  [[self rootTabBarController].tabBar showBadgeOnItemIndex:location];
//
//                              } else {
//
//                                  [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//                                  [[self rootTabBarController].tabBar hideBadgeOnItemIndex:location];
//
//                              }
//
//                          }];
//
//}
//
//

#pragma mark- 退出登录
- (void)loginOut {
    //user 退出
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KWalletWord];
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KWalletPrivateKey];
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KWalletAddress];
    [[TLUser user] loginOut];
    
    //退出登录
    //    [[IMAPlatform sharedInstance] logout:^{
    //
    //czy
    //    } fail:^(int code, NSString *msg) {
    //
    //
    //    }];
    
    //
    
    UITabBarController *tabbarContrl = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //    if ([tabbarContrl isKindOfClass:[TLUpdateVC class]]) {
    //        return;
    //    }
    if ([tabbarContrl isKindOfClass:[TLNavigationController class]]) {
        return;
    }
  
    TLTabBarController *tab = [[TLTabBarController alloc] init];
    
    //    tabbarContrl.selectedIndex = 2;
    //    [tabbarContrl.tabBar hideBadgeOnItemIndex:4];
    //应用外数量为0
    TLUserLoginVC *login = [TLUserLoginVC new];
    
    //
    TLNavigationController *na = [[TLNavigationController alloc] initWithRootViewController:login];
    self.window.rootViewController = na;
    
    login.loginSuccess = ^{
        self.window.rootViewController = tab;
        
    };
    //    TLTabBarController *tab = [TLTabBarController new];
    //    [UIApplication sharedApplication].keyWindow.rootViewController = na;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
}


#pragma mark - 用户登录
- (void)userLogin {
    
    
    //zendesk czy
    //    ZDKAnonymousIdentity *identity = [ZDKAnonymousIdentity new];
    //    identity.name = [TLUser user].nickname;
    //    identity.email = [NSString stringWithFormat:@"%@",[TLUser user].email];
    //    [ZDKConfig instance].userIdentity = identity;
    //
    //    // 重新登录的时候要重新，配置一下
    //    [self kvoUnReadMsgToChangeTabbar];
    //    [[ChatManager sharedManager] loginIM];
    
}

- (UITabBarController *)rootTabBarController {
    
    id obj = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([obj isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController *tabBarController = (UITabBarController *)obj;
        return tabBarController;
        
    } else {
        
        return nil;
    }
    
}


- (void)configWeChat {
    
    [[TLWXManager manager] registerApp];
}

- (void)configIQKeyboard {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES; // 控制整个功能是否启用。
    manager.shouldResignOnTouchOutside =YES; // 控制点击背景是否收起键盘
    manager.shouldToolbarUsesTextFieldTintColor =YES; // 控制键盘上的工具条文字颜色是否用户自定义
    manager.enableAutoToolbar = NO; // 控制是否显示键盘上的工具条
    manager.toolbarManageBehaviour =IQAutoToolbarByTag;
    
    
    
    
}

- (void)configRootViewController {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //    if (![AppConfig config].isChecking) {
    //        //先配置到，检查更新的VC,开启更新检查
    //        BuildWalletMineVC *MineVC = [[BuildWalletMineVC alloc] init];
    //        TLNavigationController *na = [[TLNavigationController alloc] initWithRootViewController:MineVC];
    //        NSString *name;
    //        TLDataBase *db = [TLDataBase sharedManager];
    //        if ([db.dataBase open]) {
    //            FMResultSet *set = [db.dataBase executeQuery:@"SELECT Mnemonics from THAWallet"];
    //            while ([set next])
    //            {
    //                name = [set stringForColumn:@"Mnemonics"];
    //
    //            }
    //            [set close];
    //
    //        }
    //
    //        [db.dataBase close];
    ////        NSString *word = [[NSUserDefaults standardUserDefaults] objectForKey:KWalletWord];
    //
    //    }
  
        TLTabBarController *tabBarCtrl = [[TLTabBarController alloc] init];
        self.window.rootViewController = tabBarCtrl;
   
    
}

//- (void)pushToChatViewControllerWith:(IMAUser *)user {
//
//    TLTabBarController *tab = (TLTabBarController *)self.window.rootViewController;
//    [tab pushToChatViewControllerWith:user];
//
//}

+ (id)sharedAppDelegate {
    
    return [UIApplication  sharedApplication ].delegate;
    
}

#pragma mark- 本地推送
//- (void)configLocalPushNotification {
//
//    // 创建分类，注意使用可变子类
//    UIMutableUserNotificationCategory *category = [UIMutableUserNotificationCategory new];
//    // 设置标识符，注意与发送通知设置的category标识符一致~！
//    category.identifier = @"category";
//    // 设置按钮，注意使用可变子类UIMutableUserNotificationAction
//    // 设置前台按钮，点击后能使程序回到前台的叫做前台按钮
//    UIMutableUserNotificationAction *action1 = [UIMutableUserNotificationAction new];
//    action1.identifier = @"qiantai";
//    action1.activationMode = UIUserNotificationActivationModeForeground;
//    // 设置按钮的标题，即按钮显示的文字
//    action1.title = @"呵呵";
//
//    // 设置后台按钮，点击后程序还在后台执行，如QQ的消息
//    UIMutableUserNotificationAction *action2 = [UIMutableUserNotificationAction new];
//    action2.identifier = @"houtai";
//    action2.activationMode = UIUserNotificationActivationModeBackground;
//    // 设置按钮的标题，即按钮显示的文字
//    action1.title = @"后台呵呵";
//    // 给分类设置按钮
//    [category setActions:@[action1,action2] forContext:UIUserNotificationActionContextDefault];
//
//    // 注册，请求授权的时候将分类设置给授权，注意是 NSSet 集合
//    NSSet *categorySet = [NSSet setWithObject:category];
//    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:categorySet];
//    // 注册通知
//    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//
//
//}


#pragma mark - 微信和芝麻认证回调
// iOS9 NS_AVAILABLE_IOS
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    //    if ([url.host isEqualToString:@"certi.back"]) {
    //
    //        //查询是否认证成功
    //        TLNetworking *http = [TLNetworking new];
    //        http.showView = [UIApplication sharedApplication].keyWindow;
    //        http.code = @"805196";
    //        http.parameters[@"bizNo"] = [TLUser user].tempBizNo;
    //        http.parameters[@"userId"] = [TLUser user].userId;
    //        [http postWithSuccess:^(id responseObject) {
    //
    //            NSString *str = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"isSuccess"]];
    //            [[NSNotificationCenter defaultCenter] postNotificationName:@"RealNameAuthResult" object:str];
    //
    //        } failure:^(NSError *error) {
    //
    //
    //        }];
    //
    //        return YES;
    //    }
    
    //    if ([url.host isEqualToString:@"safepay"]) {
    //
    //        [TLAlipayManager hadleCallBackWithUrl:url];
    //        return YES;
    //
    //    } else {
    
    //        return [WXApi handleOpenURL:url delegate:[TLWXManager manager]];
    //    }
    
    
    //    BOOL isQQ = [QQApiInterface handleOpenURL:url delegate:[QQManager manager]];
    
//    if ([url.host containsString:@"response"]) {
//        [WeiboSDK handleOpenURL:url delegate:self];
//
//        //            if(response.statusCode == WeiboSDKResponseStatusCodeSuccess){
//        //                [TLAlert alertWithSucces:[LangSwitcher switchLang:@"分享成功" key:nil]];
//        //            }else{
//        //                [TLAlert alertWithSucces:[LangSwitcher switchLang:@"分享失败" key:nil]];
//
//    }
//    else {
//
//        return [WXApi handleOpenURL:url delegate:[TLWXManager manager]];
//    }
    
    return YES;
    
}

#pragma mark- 应用进入前台，改变登录时间
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    if([TLUser user].isLogin) {
        
        [[TLUser user] changLoginTime];
        //czy      [[IMAPlatform sharedInstance] configOnAppDidBecomeActive];
        
    }
    //    if (self.IsEnterBack == YES) {
    //        if ([TLUser user].isLogin==NO) {
    //
    //            TLUserLoginVC *login = [TLUserLoginVC new];
    //            TLNavigationController *na = [[TLNavigationController alloc] initWithRootViewController:login];
    //            self.IsEnterBack = NO;
    //            login.IsAPPJoin = YES;
    //            self.window.rootViewController = na;
    //
    //        }
    //    }
    
    

    
    
}

#pragma mark- 应用切后台
- (void)applicationDidEnterBackground:(UIApplication *)application  {
    
    //
    self.IsEnterBack = YES;
    __block UIBackgroundTaskIdentifier bgTaskID;
    bgTaskID = [application beginBackgroundTaskWithExpirationHandler:^ {
        
        //不管有没有完成，结束background_task任务
        [application endBackgroundTask: bgTaskID];
        bgTaskID = UIBackgroundTaskInvalid;
    }];
    
    
    //    if([[TLUser user] checkLogin]) {
    //
    //        [[IMAPlatform sharedInstance] configOnAppEnterBackground];
    //
    //    } czy
    
}

#pragma mark- 应用切前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLanch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *) dataFilePath//应用程序的沙盒路径
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *document = [path objectAtIndex:0];
    return[document stringByAppendingPathComponent:@"THAWallet.sqlite"];
}




@end
