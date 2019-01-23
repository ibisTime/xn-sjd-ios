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
@property (nonatomic,strong) TLTextField * Address;
@property (nonatomic,strong) UITextView * DoorNum;
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
    self.DoorNum.text = [TLUser user].introduce;
    if ([[TLUser user]idPic] || [[TLUser user]backIdPic]) {
        [self.idPic sd_setImageWithURL: [NSURL URLWithString:[[TLUser user].idPic convertImageUrl]]];
        [self.backIdPic sd_setImageWithURL:[NSURL URLWithString:[[TLUser user].backIdPic convertImageUrl]]];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人认证";
    [self setup];
}

-(void)setup{
    CGFloat margin = 15;
    CGFloat height = 55;
    //姓名
    TLTextField * Name = [[TLTextField alloc]initWithFrame:CGRectMake(margin, 0, SCREEN_WIDTH-30, height) leftTitle:@"真是姓名" placeholder:@"请输入您的姓名"];
    [self.view addSubview:Name];
    self.Name = Name;
    
    //身份证号
    TLTextField * ID = [[TLTextField alloc]initWithFrame:CGRectMake(margin, Name.yy, SCREEN_WIDTH-30, height) leftTitle:@"身份证号" placeholder:@"请输入您的身份证号"];
    [self.view addSubview:ID];
    self.ID = ID;
    //门牌号
        UITextView * DoorNum = [[UITextView alloc]initWithFrame:CGRectMake(15, ID.yy, SCREEN_WIDTH-30, 80)];
        DoorNum.font = [UIFont systemFontOfSize:15.0];
        DoorNum.text = @"说下什么吧";
//        DoorNum.clearsOnInsertion = YES;
        [self.view addSubview:DoorNum];
    self.DoorNum = DoorNum;
    
    UIImageView * idPic = [[UIImageView alloc]initWithFrame:CGRectMake(15, DoorNum.yy + 5, SCREEN_WIDTH / 2 - 20, SCREEN_WIDTH / 2 - 20)];
    idPic.image = kImage(@"上传图片");
    idPic.tag = 1;
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seleckImage:)];
    ges.delegate = self;
    [idPic addGestureRecognizer:ges];
    idPic.userInteractionEnabled = YES;
    [self.view addSubview:idPic];
    self.idPic = idPic;
    
    UIImageView * backIdPic = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 15 + 10 , DoorNum.yy + 5, SCREEN_WIDTH / 2 - 20, SCREEN_WIDTH / 2 - 20)];
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
//    TLUploadManager * manager = [TLUploadManager manager];
//    for (int i = 0; i < 2; i++) {
//        manager.imgData = UIImageJPEGRepresentation(self.imagearray[i], 1.0);;
//        manager.image = self.imagearray[i];
//        [manager getTokenShowView:self.view succes:^(NSString *token) {
//            self.keyarray[i] = [NSMutableArray arrayWithObject:token];
//        } failure:^(NSError *error) {
//            NSLog(@"%@",error);
//        }];
//    }
    TLUploadManager * manager1 = [TLUploadManager manager];
    TLUploadManager * manager2 = [TLUploadManager manager];
    manager1.imgData = UIImageJPEGRepresentation(self.idPic.image, 1.0);
    manager2.imgData = UIImageJPEGRepresentation(self.backIdPic.image, 2.0);
    manager1.image = self.idPic.image;
    manager2.image = self.backIdPic.image;
    [manager1 getTokenShowView:self.view succes:^(NSString *key1) {
        self.key1 = key1;
    } failure:^(NSError *error) {
    }];
    [manager2 getTokenShowView:self.view succes:^(NSString *key2) {
        self.key2 = key2;
    } failure:^(NSError *error) {
    }];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"key1 = %@ key2 = %@",self.key1,self.key2);
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"805071";
        http.parameters[@"idPic"] = self.key1;
        http.parameters[@"backIdPic"] = self.key2;
        http.parameters[@"realName"] = self.Name.text;
        http.parameters[@"userId"] = [TLUser user].userId;
        http.parameters[@"idNo"] = self.ID.text;
        http.parameters[@"introduce"] = self.DoorNum.text;
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:[LangSwitcher switchLang:@"设置成功" key:nil]];
            [[TLUser user] updateUserInfo];
            [self dismissViewControllerAnimated:YES completion:nil];
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
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (self.state == 1) {
        self.idPic.image = image;
        self.imagearray[0] = [NSArray arrayWithObject:image];
    }
    else{
        self.backIdPic.image = image;
        self.imagearray[1] = [NSArray arrayWithObject:image];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
