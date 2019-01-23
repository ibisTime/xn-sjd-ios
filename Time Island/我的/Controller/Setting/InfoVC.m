//
//  InfoVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "InfoVC.h"
#import "TLUploadManager.h"

@interface InfoVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UIImageView * image;
@property (nonatomic,strong) TLTextField * name;
@property (nonatomic,strong) TLTextField * gender;
@property (nonatomic,strong) TLTextField * age;
@end

@implementation InfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"完善资料";
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    self.RightButton.font = FONT(16);
    [self.RightButton setFrame:CGRectMake(SCREEN_WIDTH-47.5, 30, 32.5, 45)];
    [self.RightButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.RightButton addTarget:self action:@selector(myRecodeClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self setup];
}
-(void)setup{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-22.5, 37.5, 55, 55)
                           ];
    image.image = kImage(@"头像");
    image.layer.cornerRadius = 27.5;
    image.layer.masksToBounds = YES;
//    [self.view addSubview:image];
    [view addSubview:image];
    self.image = image;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seleckImage)];
    [self.image addGestureRecognizer:tapGesture];
    self.image.userInteractionEnabled = YES;
    
    
    UIImageView * image1 = [[UIImageView alloc]initWithFrame:CGRectMake(image.x + 38, image.y + 38, 17, 17)
                           ];
    image1.image = kImage(@"更改头像");
    [view addSubview:image1];
    [self.view addSubview:view];

    [self.view addSubview:[self createview:CGRectMake(0, view.yy - 1, SCREEN_WIDTH, 1)]];
    
    TLTextField * name = [[TLTextField alloc]initWithFrame:CGRectMake(15,view.yy, SCREEN_WIDTH-30, 55) leftTitle:@"昵称" placeholder:@"请输入昵称"];
    [self.view addSubview:name];
    self.name = name;
    
    TLTextField * gender = [[TLTextField alloc]initWithFrame:CGRectMake(15, name.yy, SCREEN_WIDTH-30, 55) leftTitle:@"性别" placeholder:@"请选择"];
    [self.view addSubview:gender];
    self.gender = gender;
    
    TLTextField * age = [[TLTextField alloc]initWithFrame:CGRectMake(15, gender.yy, SCREEN_WIDTH-30, 55) leftTitle:@"年龄" placeholder:@"请选择"];
    [self.view addSubview:age];
    self.age = age;
    
    TLTextField * more = [[TLTextField alloc]initWithFrame:CGRectMake(15, age.yy, SCREEN_WIDTH-30, 100) placeholder:@"请输入个人简介（最多输入20个字符）"];
    
    [self.view addSubview:more];
}
-(void)myRecodeClick{
    NSLog(@"%s",__func__);
}

-(UIView * )createview:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kLineColor;
    return view;
}

-(void)seleckImage{
    
    NSLog(@"%s",__func__);
    //这部分代码是用来打开相册的
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;//是否允许编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    TLUploadManager * manager = [TLUploadManager manager];
    manager.imgData = UIImageJPEGRepresentation(image, 1.0);;
    manager.image = image;
    [manager getTokenShowView:self.view succes:^(NSString *key) {
        
//        [self changeHeadIconWithKey:key imgData:imgData];
        TLNetworking *http = [TLNetworking new];
        http.code = @"805080";
        http.parameters[@"photo"] = key;
        http.parameters[@"userId"] = [TLUser user].userId;
        
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:[LangSwitcher switchLang:@"设置成功" key:nil]];
            [[TLUser user] updateUserInfo];
            self.image.image = image;
            [picker dismissViewControllerAnimated:YES completion:nil];
        } failure:^(NSError *error) {
            [TLAlert alertWithError:@"设置失败"];
            [picker dismissViewControllerAnimated:YES completion:nil];
        }];
        
    } failure:^(NSError *error) {
        
    }];

   
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
