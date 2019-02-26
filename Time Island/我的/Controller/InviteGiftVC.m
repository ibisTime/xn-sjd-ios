//
//  InviteGiftVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/12.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "InviteGiftVC.h"

@interface InviteGiftVC ()
@property (nonatomic,strong) UIImageView * QRCodeView;
@property (nonatomic,strong) NSString * url;
@property (nonatomic,strong) UIView * view1;
@end

@implementation InviteGiftVC
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self navigationSetDefault];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self refresh];
    
    UIButton * backbtn = [UIButton buttonWithImageName:@"详情-返回"];
    backbtn.frame = CGRectMake(10, kStatusBarHeight, 44, 44);
    [backbtn addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backbtn];
    
    UILabel * label = [UILabel labelWithFrame:CGRectMake(15, kStatusBarHeight, SCREEN_WIDTH - 30, 44) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(17) textColor:kBlackColor];
    label.text = @"分享二维码";
    [self.view addSubview:label];
    
    UILabel * label1 = [UILabel labelWithFrame:CGRectMake(15, label.yy + 19, SCREEN_WIDTH - 30, 40) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(16) textColor:kTabbarColor];
    label1.text = @"氧护青山，绿水长流";
    [self.view addSubview:label1];
    

    
    UIButton * button = [UIButton buttonWithTitle:@"保存到本地" titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:16];
    button.frame = CGRectMake(30, SCREEN_HEIGHT - 100, SCREEN_WIDTH - 60, 50);
    button.layer.cornerRadius = 20;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(save) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
}
-(void)save{
    UIImage * image = [self imageFromView:self.view1];
    [self saveImageToPhotos:image];
}
-(UIImage*)imageFromView:(UIView*)view{
    CGSize s = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数。
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)saveImageToPhotos:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error == nil) {
        [TLAlert alertWithSucces:@"存入手机相册成功"];
        NSLog(@"存入手机相册成功");
    }else{
        [TLAlert alertWithError:@"存入手机相册失败,请检查是否打开照片权限后再次保存，谢谢！"];
        NSLog(@"存入手机相册失败");
    }
}

-(UIView *)createview1{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(30, 150, SCREEN_WIDTH - 60, SCREEN_HEIGHT - 140 - 150)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel * label = [UILabel labelWithFrame:CGRectMake(0, 15, view.width, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(15) textColor:kBlackColor];
    label.text = @"-扫一扫，养棵树-";
    [view addSubview:label];
    
    self.QRCodeView = [[UIImageView alloc]initWithFrame:CGRectMake(30, label.yy + 20, view.width - 60, view.width - 60)];
    NSString * string = [NSString stringWithFormat:@"?type=U&userReferee=%@",[TLUser user].mobile];
    NSString * string1 = [self.url stringByAppendingString:string];
   self.QRCodeView.image = [[TLUser user]QRCodeMethod:string1];
    [view addSubview:self.QRCodeView];
    
    UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.QRCodeView.yy + 30, view.width, 1)];
    v1.backgroundColor = kLineColor;
    [view addSubview:v1];
    
    UILabel * label1 = [UILabel labelWithFrame:CGRectMake(0, self.QRCodeView.yy + 50, view.width, 0) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(15) textColor:kTextColor2];
    label1.text = @"1.使用扫一扫注册氧林账号\n2.分享给好友一起认养树";
    label1.numberOfLines = 0;
    [label1 sizeToFit];
    label1.frame = CGRectMake(0, self.QRCodeView.yy + 50, view.width, label1.height);
    [view addSubview:label1];
    
    self.view1 = view;
    
    return self.view1;

}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)refresh{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.showView = self.view;
    http.code = @"630047";
    http.parameters[@"ckey"] = @"REGISTER_URL";
    [http postWithSuccess:^(id responseObject) {
        self.url = responseObject[@"data"][@"cvalue"];
        self.view1 = [self createview1];
        [self.view addSubview:self.view1];
    } failure:^(NSError *error) {
        
    }];
}
@end
