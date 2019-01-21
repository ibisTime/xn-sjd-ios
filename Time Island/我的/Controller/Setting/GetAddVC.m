//
//  GetAddVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "GetAddVC.h"

@interface GetAddVC ()
@property (nonatomic,strong) TLTextField * Name;
@property (nonatomic,strong) TLTextField * Phone;
@property (nonatomic,strong) TLTextField * Address;
@property (nonatomic,strong) TLTextField * DoorNum;
@end

@implementation GetAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"新增收获地址";
//    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
//    backBtn.title = @"新增收货地址";
//    self.navigationItem.backBarButtonItem = backBtn;
    [self setup];
    // Do any additional setup after loading the view.
}

-(void)setup{
    CGFloat margin = 15;
    CGFloat height = 55;
    //姓名
    TLTextField * Name = [[TLTextField alloc]initWithFrame:CGRectMake(margin, 0, SCREEN_WIDTH-30, height) leftTitle:@"收货人" placeholder:@"您的姓名"];
    [self.view addSubview:Name];
    self.Name = Name;
    //电话
    TLTextField * Phone = [[TLTextField alloc]initWithFrame:CGRectMake(margin, Name.yy, SCREEN_WIDTH-30, height) leftTitle:@"收货人" placeholder:@"您的姓名"];
    [self.view addSubview:Phone];
    self.Phone = Phone;
    //地址
    TLTextField * Address = [[TLTextField alloc]initWithFrame:CGRectMake(margin, Phone.yy, SCREEN_WIDTH-30, height) leftTitle:@"地址" placeholder:@"所在地区"];
    [self.view addSubview:Address];
    self.Address = Address;
    //门牌号
    TLTextField * DoorNum = [[TLTextField alloc]initWithFrame:CGRectMake(margin, Address.yy, SCREEN_WIDTH-30, 80) leftTitle:@"门牌号" placeholder:@"10号楼5层501室"];
    [self.view addSubview:DoorNum];
    self.DoorNum = DoorNum;
//    UITextView * DoorNum = [[UITextView alloc]initWithFrame:CGRectMake(60, Address.yy, SCREEN_WIDTH-30, 80)];
//    DoorNum.backgroundColor = kWhiteColor;
//    DoorNum.font = [UIFont systemFontOfSize:15.0];
//    DoorNum.text = @"10号楼5层501室";
//    DoorNum.clearsOnInsertion = YES;
//    [self.view addSubview:DoorNum];
    
    
    UIButton *confirmBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"确认" key:nil] titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16.0 cornerRadius:5];
    confirmBtn.frame = CGRectMake(15, DoorNum.yy + 80, kScreenWidth - 30, 42);
    [self.view addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
}
-(void)confirm{
    NSLog(@"%s",__func__);
}

@end
