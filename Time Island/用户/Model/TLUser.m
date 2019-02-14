//
//  TLUser.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/14.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "TLUser.h"

#import "UserDefaultsUtil.h"
//#import "CurrencyModel.h"
#import "TLNetworking.h"
#import "APICodeMacro.h"
#import "TLUIHeader.h"
#import "AppConfig.h"

#import "TLUploadManager.h"
//#import "TabbarViewController.h"

#define USER_ID_KEY @"user_id_key"
#define TOKEN_ID_KEY @"token_id_key"
#define USER_INFO_DICT_KEY @"user_info_dict_key"

NSString *const kUserLoginNotification = @"kUserLoginNotification";
NSString *const kUserLoginOutNotification = @"kUserLoginOutNotification";
NSString *const kUserInfoChange = @"kUserInfoChange";

// ONE("1", "普通交易者"), TWO("2", "代理人")
NSString *const kLevelOrdinaryTraders = @"1";
NSString *const kLevelAgent = @"2";
//谷歌验证(0:关闭 1:开启)
NSString *const kGoogleAuthOpen = @"1";
NSString *const kGoogleAuthClose = @"0";

@implementation TLUser {
    
    NSTimer *_updateLoginTimeTimer;
    
}

+ (instancetype)user {

    static TLUser *user = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        user = [[TLUser alloc] init];
        
    });
    
    return user;

}

#pragma mark - Setting

- (void)setToken:(NSString *)token {
    
    _token = [token copy];
    [[NSUserDefaults standardUserDefaults] setObject:_token forKey:TOKEN_ID_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)setUserId:(NSString *)userId {
    _userId = [userId copy];
    [[NSUserDefaults standardUserDefaults] setObject:_userId forKey:USER_ID_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)checkLogin {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefault objectForKey:USER_ID_KEY];
    NSString *token = [userDefault objectForKey:TOKEN_ID_KEY];
    if (userId && token) {
    
        return YES;
        
    } else {
        
        
        return NO;
    }
    
}

// 登录状态才调用
- (void)loadUserInfoFromDB {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefault objectForKey:USER_ID_KEY];
    NSString *token = [userDefault objectForKey:TOKEN_ID_KEY];
    //
    self.userId = userId;
    self.token = token;
    //
    NSDictionary *dict = [userDefault objectForKey:USER_INFO_DICT_KEY];
    [self setUserInfoWithDict:dict];
    
}

- (BOOL)isLogin {
    
    if ([self checkLogin]) {
        
        [self loadUserInfoFromDB];
        return YES;
        
    } else {
        
        return NO;
    }


}

- (void)reLogin {
    
    self.userName = [UserDefaultsUtil getUserDefaultName];
    
    self.userPassward = [UserDefaultsUtil getUserDefaultPassword];
    
    TLNetworking *http = [TLNetworking new];
    
    http.code = USER_LOGIN_CODE;
    
    http.parameters[@"loginName"] = self.userName;
    http.parameters[@"loginPwd"] = self.userPassward;
    http.parameters[@"kind"] = APP_KIND;
    
    [http postWithSuccess:^(id responseObject) {
        
        self.token = responseObject[@"data"][@"token"];
        self.userId = responseObject[@"data"][@"userId"];
        
        [self updateUserInfo];
        [self requestQiniuDomain];
        
    } failure:^(NSError *error) {
        
        
    }];
}

//- (void)changLoginTime {
////    [self refreshLoginTime];
//    if (_updateLoginTimeTimer) {
//        return;
//    }
//   
//    _updateLoginTimeTimer = [NSTimer scheduledTimerWithTimeInterval:5*60
//                                                             target:self
//                                                        selector:@selector(refreshLoginTime)
//                                                           userInfo:nil repeats:YES];
//}

//- (void)refreshLoginTime {
//    
//    if (![[TLUser user] checkLogin]) {
//        return;
//    }
//    TLNetworking *http = [TLNetworking new];
//    http.code = @"805083";
//    http.parameters[@"userId"] = [TLUser user].userId;
//    [http postWithSuccess:^(id responseObject) {
//        
//        
//    } failure:^(NSError *error) {
//        
//    }];
//}

- (void)requestQiniuDomain {
    
    TLNetworking *http = [TLNetworking new];
    http.code = USER_CKEY_CVALUE;
    http.parameters[SYS_KEY] = @"qiniu_domain";
    [http postWithSuccess:^(id responseObject) {
        
        [AppConfig config].qiniuDomain = [NSString stringWithFormat:@"http://%@", responseObject[@"data"][@"cvalue"]];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 账户

- (void)loginOut {

    self.userId = nil;
    self.token = nil;
    //
    //
    self.secretUserId = nil;
    self.photo = nil;
    self.mobile = nil;
    self.nickname = nil;
    self.gender = nil;
    self.age = nil;
    self.tradepwdFlag = nil;
    self.email = nil;
    self.tradepwdFlag = nil;
    self.googleAuthFlag = nil;
    self.level = nil;
    self.friendCount = nil;
    self.rmbAccountNumber = nil;
    self.jfAccountNumber = nil;
//    self.unReadMsgCount = 0;
    self.realName = nil;
    self.idNo = nil;
    self.idPic = nil;
    self.backIdPic = nil;
    self.introduce = nil;
    self.zfbAccount = nil;
    self.zfbQr = nil;
    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ID_KEY];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:TOKEN_ID_KEY];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ID_KEY];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_INFO_DICT_KEY];
    
    
 
}


- (void)saveUserInfo:(NSDictionary *)userInfo {

//    NSLog(@"原%@--现%@",[TLUser user].userId,userInfo[@"userId"]);
    
//    if (![[TLUser user].userId isEqualToString:userInfo[@"userId"]]) {
//        
//        @throw [NSException exceptionWithName:[LangSwitcher switchLang:@"用户信息错误" key:nil] reason:[LangSwitcher switchLang:@"后台原因" key:nil] userInfo:nil];
//        
//    }
    
    [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:USER_INFO_DICT_KEY];
    //
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)updateUserInfoWithNotification:(BOOL)isPostNotification {
    TLNetworking *http = [TLNetworking new];
    
    http.isShowMsg = NO;
    http.code = USER_INFO;
    http.parameters[@"userId"] = self.userId;
    http.parameters[@"token"] = self.token;
    
    [http postWithSuccess:^(id responseObject) {
        
        [self setUserInfoWithDict:responseObject[@"data"]];
        [self saveUserInfo:responseObject[@"data"]];
//        [self loadTengxunYun];
        if (isPostNotification) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserInfoChange object:nil];
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
}
- (void)loadTengxunYun
{
    
    TLNetworking *http = [TLNetworking new];
    //806052
    http.code = @"805953";
    
    [http postWithSuccess:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [TLUploadManager manager].key = responseObject[@"data"][@"AccessKeyId"];
        [TLUploadManager manager].sec = responseObject[@"data"][@"AccessKeySecret"];
        [TLUploadManager manager].token = responseObject[@"data"][@"SecurityToken"];
        [[TLUploadManager manager] initAliYun];

    } failure:^(NSError *error) {
        
    }];
    
}
- (void)updateUserInfo {
    
    [self updateUserInfoWithNotification:YES];
    
}

- (void)setUserInfoWithDict:(NSDictionary *)dict {
    
    self.userName = dict[@"loginName"];
    self.mobile = dict[@"mobile"];
    self.nickname = dict[@"nickname"];
    self.gender = dict[@"gender"];
    self.age = dict[@"age"];
    self.realName = dict[@"realName"];
    self.idNo = dict[@"idNo"];
    self.idPic = dict[@"userExt"][@"idPic"];
    self.backIdPic = dict[@"userExt"][@"backIdPic"];
    self.tradepwdFlag = dict[@"tradepwdFlag"];
    self.introduce = dict[@"introduce"];
    self.tradepwdFlag = [NSString stringWithFormat:@"%@", dict[@"tradepwdFlag"]];
    self.googleAuthFlag = [NSString stringWithFormat:@"%@", dict[@"googleAuthFlag"]];
    self.level = dict[@"level"];
    self.friendCount = dict[@"friendCount"];
    self.photo = dict[@"photo"];
    self.email = dict[@"email"];
    self.secretUserId =  dict[@"secretUserId"];
    self.zfbQr = dict[@"zfbQr"];

    //腾讯云-设置昵称和头像
//  [IMAPlatform sharedInstance].host.icon = [self.photo convertImageUrl];

}

- (void)setMobile:(NSString *)mobile {
    
    _mobile = [mobile copy];
    
}

- (void)setPhoto:(NSString *)photo {
    
    _photo = [photo copy];
    
}

//- (void)saveUserName:(NSString *)userName pwd:(NSString *)pwd {
//    
//    self.userName = userName;
//    
//    self.userPassward = pwd;
//    
//    [UserDefaultsUtil setUserDefaultName:userName];
//    
//    [UserDefaultsUtil setUserDefaultPassword:pwd];
//    
//}

//- (void)setUnReadMsgCount:(NSInteger)unReadMsgCount {
//    
//    _unReadMsgCount = unReadMsgCount;
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"MessageDidRefresh" object:[NSString stringWithFormat:@"%ld", unReadMsgCount]];
//}

- (void)setGoogleAuthFlag:(NSString *)googleAuthFlag {
    
    _googleAuthFlag = googleAuthFlag;
    _isGoogleAuthOpen = [googleAuthFlag isEqualToString:kGoogleAuthOpen] ? YES: NO;
    
}

+ (NSString*)convertNull:(id)object{
    if ([object isEqual:[NSNull null]]) {
        return @"";
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    else if ([object isEqualToString:@"(null)"])
    {
        return @"";
    }
    else if (object==nil){
        return @"";
    }
    return object;
}
/*  ============================================================  */
#pragma mark - 生成二维码的方法
- (UIImage *)QRCodeMethod:(NSString *)qrCodeString {
    
    UIImage *qrcodeImg = [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:qrCodeString] withSize:250.0f];
    // ** 将生成的图片返回
    return qrcodeImg;
}

/*  ============================================================  */
#pragma mark - InterpolatedUIImage
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

#pragma mark - QRCodeGenerator
- (CIImage *)createQRForString:(NSString *)qrString {
    
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    return qrFilter.outputImage;
}

#pragma mark - imageToTransparent
void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}
- (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
            
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace, kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider, NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}
@end
