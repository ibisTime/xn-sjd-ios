//
//  PersonalCertifyVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/23.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "PersonalCertifyVC.h"

@interface PersonalCertifyVC ()
@property (nonatomic,strong) TLTextField * Name;
@property (nonatomic,strong) TLTextField * ID;
@property (nonatomic,strong) UIImageView * idPic;
@property (nonatomic,strong) UIImageView * backIdPic;
@property (nonatomic,assign) int state;
@property (nonatomic,strong) NSMutableArray * imagearray;
@property (nonatomic,strong) NSString * key1;
@property (nonatomic,strong) NSString * key2;
@property (nonatomic,strong) NSMutableArray * keyarray;

@end

@implementation PersonalCertifyVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.Name.text = [TLUser user].realName;
    self.ID.text = [TLUser user].idNo;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人认证";
    [self setup];
    if ([[TLUser user]idPic] || [[TLUser user]backIdPic]) {
        [self.idPic sd_setImageWithURL: [NSURL URLWithString:[[TLUser user].idPic convertImageUrl]]];
        [self.backIdPic sd_setImageWithURL:[NSURL URLWithString:[[TLUser user].backIdPic convertImageUrl]]];
    }
}

-(void)setup{
    CGFloat margin = 15;
    CGFloat height = 55;
    //姓名
    TLTextField * Name = [[TLTextField alloc]initWithFrame:CGRectMake(margin, 0, SCREEN_WIDTH-30, height) leftTitle:@"真实姓名" placeholder:@"请输入您的姓名"];
    Name.font = FONT(15);
    Name.leftLbl.font = FONT(15);
    [self.view addSubview:Name];
    self.Name = Name;
    
    //身份证号
    TLTextField * ID = [[TLTextField alloc]initWithFrame:CGRectMake(margin, Name.yy, SCREEN_WIDTH-30, height) leftTitle:@"身份证号" placeholder:@"请输入您的身份证号"];
    ID.font = FONT(15);
    ID.leftLbl.font = FONT(15);
    [self.view addSubview:ID];
    self.ID = ID;
    
    UIImageView * idPic = [[UIImageView alloc]initWithFrame:CGRectMake(15, ID.yy + 25, 100, 100)];
    idPic.image = kImage(@"上传图片");
    idPic.tag = 1;
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seleckImage:)];
    ges.delegate = self;
    [idPic addGestureRecognizer:ges];
    idPic.userInteractionEnabled = YES;
    [self.view addSubview:idPic];
    self.idPic = idPic;
    
    UIImageView * backIdPic = [[UIImageView alloc]initWithFrame:CGRectMake(idPic.xx +  20 , ID.yy + 25, 100, 100)];
    backIdPic.image = kImage(@"上传图片");
    backIdPic.tag = 2;
    UITapGestureRecognizer * ges1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seleckImage:)];
    ges1.delegate = self;
    [backIdPic addGestureRecognizer:ges1];
    backIdPic.userInteractionEnabled = YES;
    [self.view addSubview:backIdPic];
    self.backIdPic = backIdPic;
    
    
    
    UIButton *confirmBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"确认" key:nil] titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16.0 cornerRadius:5];
    confirmBtn.frame = CGRectMake(15, idPic.yy + 40, kScreenWidth - 30, 42);
    [self.view addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
}

-(void)confirm{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"key1 = %@ key2 = %@",self.key1,self.key2);
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"805071";
        http.parameters[@"idPic"] = self.key1;
        http.parameters[@"backIdPic"] = self.key2;
        http.parameters[@"realName"] = self.Name.text;
        http.parameters[@"userId"] = [TLUser user].userId;
        http.parameters[@"idNo"] = self.ID.text;
        http.parameters[@"introduce"] = [TLUser user].introduce;
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:[LangSwitcher switchLang:@"设置成功" key:nil]];
            [[TLUser user] updateUserInfo];
//            [self dismissViewControllerAnimated:YES completion:nil];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            [TLAlert alertWithSucces:[LangSwitcher switchLang:@"设置失败" key:nil]];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    });

}
-(void)seleckImage:(UITapGestureRecognizer * )image{
    self.state = (int)image.view.tag;
    NSLog(@"%s",__func__);
    //这部分代码是用来打开相册的
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;//是否允许编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//    [picker dismissViewControllerAnimated:YES completion:nil];
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (self.state == 1) {
        self.idPic.image = nil;
        self.idPic.image = image;
        TLUploadManager * manager = [TLUploadManager manager];
        manager.imgData = UIImageJPEGRepresentation(self.idPic.image, 1.0);
        manager.image = self.idPic.image;
        [manager getTokenShowView:self.idPic succes:^(NSString *token) {
            self.key1 = token;
        } failure:^(NSError *error) {
        }];
    }
    else{
        self.backIdPic.image = nil;
        self.backIdPic.image = image;
        TLUploadManager * manager1 = [TLUploadManager manager];
        manager1.imgData = UIImageJPEGRepresentation(self.backIdPic.image, 11.0);
        manager1.image = self.backIdPic.image;
        [manager1 getTokenShowView:self.backIdPic succes:^(NSString *token) {
            self.key2 = token;
        } failure:^(NSError *error) {
        }];
    }
//    [picker dismissViewControllerAnimated:YES completion:nil];
    [picker dismissModalViewControllerAnimated:YES];
}
@end
