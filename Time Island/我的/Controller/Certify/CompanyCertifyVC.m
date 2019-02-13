//
//  CompanyCertifyVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/13.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "CompanyCertifyVC.h"

@interface CompanyCertifyVC ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) TLTextField * Name;
@property (nonatomic,strong) TLTextField * ID;
@property (nonatomic,strong) TLTextField * more;
@property (nonatomic,strong) UIImageView * idPic;
@property (nonatomic,strong) UIImageView * backIdPic;
@property (nonatomic,assign) int state;
@property (nonatomic,strong) NSMutableArray * imagearray;
@property (nonatomic,strong) NSString * key1;
@property (nonatomic,strong) NSString * key2;
@property (nonatomic,strong) NSMutableArray * keyarray;
@end

@implementation CompanyCertifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"企业认证";
    [self setup];
    // Do any additional setup after loading the view.
}

-(void)setup{
    CGFloat margin = 15;
    CGFloat height = 55;
    //姓名
    TLTextField * Name = [[TLTextField alloc]initWithFrame:CGRectMake(margin, 0, SCREEN_WIDTH-30, height) leftTitle:@"企业名称" placeholder:@"请输入您所在企业名称"];
    Name.font = FONT(15);
    Name.leftLbl.font = FONT(15);
    [self.view addSubview:Name];
    self.Name = Name;
    
    //身份证号
    TLTextField * ID = [[TLTextField alloc]initWithFrame:CGRectMake(margin, Name.yy, SCREEN_WIDTH-30, height) leftTitle:@"营业执照号" placeholder:@"请输入您所在企业营业执照号"];
    ID.font = FONT(15);
    ID.leftLbl.font = FONT(13);
//    [ID.leftLbl sizeToFit];
    
    [self.view addSubview:ID];
    self.ID = ID;
    
    
    TLTextField * more = [[TLTextField alloc]initWithFrame:CGRectMake(15, ID.yy, SCREEN_WIDTH-30, 100) placeholder:@"请输入企业简介（最多输入20个字符）"];
    [self.view addSubview:more];
    self.more = more;
    
    UIImageView * idPic = [[UIImageView alloc]initWithFrame:CGRectMake(15, more.yy + 25, 100, 100)];
    idPic.image = kImage(@"上传图片");
    idPic.tag = 1;
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seleckImage:)];
    ges.delegate = self;
    [idPic addGestureRecognizer:ges];
    idPic.userInteractionEnabled = YES;
    [self.view addSubview:idPic];
    self.idPic = idPic;
    
    UIImageView * backIdPic = [[UIImageView alloc]initWithFrame:CGRectMake(idPic.xx +  20 , more.yy + 25, 100, 100)];
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

@end
