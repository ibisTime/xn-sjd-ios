//
//  CompanyCertifyVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/13.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "CompanyCertifyVC.h"
#import "CompanyCertifyTableView.h"

@interface CompanyCertifyVC ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) TLTextField * ComName;
@property (nonatomic,strong) TLTextField * ComAddress;
@property (nonatomic,strong) TLTextField * BossName;
@property (nonatomic,strong) TLTextField * BossTel ;
@property (nonatomic,strong) TLTextField * BossID ;
@property (nonatomic,strong) TLTextField * ComUser ;
@property (nonatomic,strong) TLTextField * ComUserTel ;
@property (nonatomic,strong) TLTextField * ComUserAddress ;
@property (nonatomic,strong) TLTextField * ComBankName ;
@property (nonatomic,strong) TLTextField * ComBankID ;
@property (nonatomic,strong) TLTextField * ComID ;

@property (nonatomic,strong) UIImageView * idPic;
@property (nonatomic,strong) UIImageView * backIdPic;
@property (nonatomic,strong) UIImageView * LicencePic;

@property (nonatomic,assign) int state;
@property (nonatomic,strong) NSMutableArray * imagearray;
@property (nonatomic,strong) NSString * key1;
@property (nonatomic,strong) NSString * key2;
@property (nonatomic,strong) NSString * key3;
@property (nonatomic,strong) NSMutableArray * keyarray;
@property (nonatomic,strong) CompanyCertifyTableView * tableview;

@property (nonatomic,strong) UIView * footview;
@end

@implementation CompanyCertifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"企业认证";
    self.KeyArray = @[@"ComName",@"ComAddress",@"BossName",@"BossTel",@"BossID",@"ComUser",@"ComUserTel",@"ComUserAddress",@"ComBankName",@"ComBankID",@"ComID"];
    
    [self setup];
    self.tableview.tableFooterView = self.footview;
    [self.view addSubview:self.tableview];
    
    
    if ([TLUser user].userExt[@"companyChargerBackIdPic"]||[TLUser user].userExt[@"companyChargerIdPic"]||[TLUser user].userExt[@"bussinessLicense"]) {
        [self.idPic sd_setImageWithURL: [NSURL URLWithString:[[TLUser user].userExt[@"companyChargerBackIdPic"] convertImageUrl]]];
        [self.backIdPic sd_setImageWithURL:[NSURL URLWithString:[[TLUser user].userExt[@"companyChargerIdPic"] convertImageUrl]]];
        [self.LicencePic sd_setImageWithURL:[NSURL URLWithString:[[TLUser user].userExt[@"bussinessLicense"] convertImageUrl]]];
    }
}
-(CompanyCertifyTableView *)tableview{
    if (!_tableview) {
        _tableview = [[CompanyCertifyTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableview.backgroundColor = kWhiteColor;
    }
    return _tableview;
}
-(void)setup{

    
    self.footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    
//    UIImageView * idPic = [[UIImageView alloc]initWithFrame:CGRectMake(15, more.yy + 25, 100, 100)];
    UIImageView * idPic = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 100, 100)];
    
//    UILabel * l1 = [UILabel labelWithFrame:CGRectMake(0, idPic.height * 3 / 4, idPic.width, idPic.height / 4) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(11) textColor:kTextColor3];
//    l1.text = @"身份证正面";
//    [idPic addSubview:l1];
    idPic.image = kImage(@"上传图片");
    idPic.tag = 1;
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seleckImage:)];
    ges.delegate = self;
    [idPic addGestureRecognizer:ges];
    idPic.userInteractionEnabled = YES;
//    [self.view addSubview:idPic];
    [self.footview addSubview:idPic];
    self.idPic = idPic;
    
//    UIImageView * backIdPic = [[UIImageView alloc]initWithFrame:CGRectMake(idPic.xx +  20 , more.yy + 25, 100, 100)];
    UIImageView * backIdPic = [[UIImageView alloc]initWithFrame:CGRectMake(idPic.xx +  20 , 0, 100, 100)];
    backIdPic.image = kImage(@"上传图片");
    backIdPic.tag = 2;
    UITapGestureRecognizer * ges1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seleckImage:)];
    ges1.delegate = self;
    [backIdPic addGestureRecognizer:ges1];
    backIdPic.userInteractionEnabled = YES;
//    [self.view addSubview:backIdPic];
    [self.footview addSubview:backIdPic];
    self.backIdPic = backIdPic;
    
    
    UIImageView * licence = [[UIImageView alloc]initWithFrame:CGRectMake(backIdPic.xx +  20 , 0, 100, 100)];
    licence.image = kImage(@"上传图片");
    licence.tag = 3;
    UITapGestureRecognizer * ges2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seleckImage:)];
    ges2.delegate = self;
    [licence addGestureRecognizer:ges2];
    licence.userInteractionEnabled = YES;
    //    [self.view addSubview:backIdPic];
    [self.footview addSubview:licence];
    self.LicencePic = licence;
    
    
    UIButton *confirmBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"确认" key:nil] titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16.0 cornerRadius:5];
    confirmBtn.frame = CGRectMake(15, idPic.yy + 40, kScreenWidth - 30, 42);
//    [self.view addSubview:confirmBtn];
    [self.footview addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
}

-(void)confirm{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"key1 = %@ key2 = %@",self.key1,self.key2);

        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"805072";
        
        //企业名称
        UITextField *textfield0 = [self.view viewWithTag:1000];
        http.parameters[@"companyName"] = textfield0.text;
        
        //地址
        UITextField * textfield1 = [self.view viewWithTag:1001];
        http.parameters[@"companyAddress"] = textfield1.text;
        
        //法人姓名
        UITextField * textfield2 = [self.view viewWithTag:1002];
        http.parameters[@"companyChargerName"] = textfield2.text;
        
        //法人联系方式
        UITextField * textfield3 = [self.view viewWithTag:1003];
        http.parameters[@"companyChargerMobile"] = textfield3.text;
        
        //企业法人身份证
        UITextField * textfield4 = [self.view viewWithTag:1004];
        http.parameters[@"companyChargerIdNo"] = textfield4.text;
        
        //企业联系人
        UITextField * textfield5 = [self.view viewWithTag:1005];
        http.parameters[@"companyContactName"] = textfield5.text;
        
        
        //企业联系人电话
        UITextField * textfield6 = [self.view viewWithTag:1006];
        http.parameters[@"companyContactMobile"] = textfield6.text;
        
        //企业联系人地址
        UITextField * textfield7 = [self.view viewWithTag:1007];
        http.parameters[@"companyContactAddress"] = textfield7.text;
        
        //企业开户行
        UITextField * textfield8 = [self.view viewWithTag:1008];
        http.parameters[@"companyBank"] = textfield8.text;
        
        //企业开户行账号
        UITextField * textfield9 = [self.view viewWithTag:1009];
        http.parameters[@"companyBankNumber"] = textfield9.text;
        
        //企业注册统一码
        UITextField * textfield10 = [self.view viewWithTag:1010];
        http.parameters[@"bussinessLicenseId"] = textfield10.text;
        
        if (textfield0.text || textfield1.text || textfield2.text || textfield3.text || textfield4.text || textfield5.text || textfield6.text || textfield7.text || textfield8.text || textfield9.text || textfield10.text ) {
            http.parameters[@"companyChargerIdPic"] = self.key1;
            http.parameters[@"companyChargerBackIdPic"] = self.key2;
            http.parameters[@"bussinessLicense"] = self.key3;
            
            http.parameters[@"userId"] = [TLUser user].userId;
            http.parameters[@"introduce"] = [TLUser user].introduce;
            [http postWithSuccess:^(id responseObject) {
                [TLAlert alertWithSucces:[LangSwitcher switchLang:@"设置成功" key:nil]];
                [[TLUser user] updateUserInfo];
                [self.navigationController popViewControllerAnimated:YES];
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
                [TLAlert alertWithSucces:[LangSwitcher switchLang:@"设置失败" key:nil]];
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }
        else{
            [TLAlert alertWithError:@"请输入完整!"];
        }
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
    else if(self.state == 2){
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
    else{
        self.LicencePic.image = nil;
        self.LicencePic.image = image;
        TLUploadManager * manager1 = [TLUploadManager manager];
        manager1.imgData = UIImageJPEGRepresentation(self.LicencePic.image, 11.0);
        manager1.image = self.LicencePic.image;
        [manager1 getTokenShowView:self.LicencePic succes:^(NSString *token) {
            self.key3 = token;
        } failure:^(NSError *error) {
        }];
    }
    //    [picker dismissViewControllerAnimated:YES completion:nil];
    [picker dismissModalViewControllerAnimated:YES];
}
@end
