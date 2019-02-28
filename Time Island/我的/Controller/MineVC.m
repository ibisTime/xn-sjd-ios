//
//  MineVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/2.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MineVC.h"
#import "TLUserLoginVC.h"
#import "MineVCCell.h"
#import "MyCarbonBubbleVC.h"
#import "UIViewController+CWLateralSlide.h"
#import "SettingVC.h"
#import "CollectVC.h"
#import "InviteVC.h"
#import "CollectBookVC.h"
#import "BookVC.h"
#import "OrderVC.h"
#import "MallTabbar.h"
#import "TLUploadManager.h"
#import "AppConfig.h"
#import "BalanceVC.h"
#import "CertifyVC.h"
#import "InviteGiftVC.h"
#import "InfoVC.h"
#import "CollectBookVC.h"
#import "PersonalCenterVC.h"
#define titlearray @[@"我的认养",@"我的认养订单",@"我的文章",@"我的收藏",@"邀请有礼",@"设置"]
#define imagearray @[@"泡泡",@"我的订单",@"我的文章",@"我的收藏",@"邀请有礼",@"设置"]
#define array1 @[@"余额",@"碳泡泡",@"积分"]
@interface MineVC (){
    
}
@property (nonatomic,retain) UIView * topview;
@property (nonatomic,strong) TLTableView *table1;
@property (nonatomic,strong) UILabel * name;
@property (nonatomic,strong) UIImageView * logoimage;
@property (nonatomic,strong) UILabel * nameLbl;
@property (nonatomic,strong) UILabel * sign;
@property (nonatomic,strong) NSArray * array;
@property (nonatomic,strong) UILabel *numberLbl1;
@property (nonatomic,strong) UILabel *numberLbl2;
@property (nonatomic,strong) UILabel *numberLbl3;
@property (nonatomic,strong)  UILabel *numLbl;
@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UIView *headPortraitView;
@end

@implementation MineVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self navigationTransparentClearColor];
    [self RefreshInfo];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self navigationSetDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.title = @"我的";
    [self RefreshInfo];
    if (![[TLUser user] checkLogin]) {
        TLUserLoginVC * login = [TLUserLoginVC new];
        [self.navigationController pushViewController:login animated:YES];
    }
    
    
    self.table1 = [TLTableView tableViewWithFrame:CGRectMake(0, -kNavigationBarHeight, kScreenWidth, kScreenHeight+55) delegate:self dataSource:self];
    self.topview = [[UIView alloc]initWithFrame:CGRectMake(0, -kNavigationBarHeight, kScreenWidth, 563/2 -64 + kNavigationBarHeight)];
    [self setupview];
    self.table1.tableHeaderView = self.topview;
    self.table1.refreshDelegate = self;
    CoinWeakSelf;
//    [_table1 beginRefreshing];
    [_table1 addRefreshAction:^{
        [weakSelf RefreshInfo];
        [weakSelf.table1 endRefreshHeader];
    }];
    [self.view addSubview:self.table1];
    
    

}

-(void)setupview{
    UIImageView *topiimage = [[UIImageView alloc]initWithFrame:self.topview.bounds];
    topiimage.image = kImage(@"我的背景");
    [self.topview addSubview:topiimage];
    
    self.headPortraitView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 171/2, 72.5 - 64 + kNavigationBarHeight, 171, 33)];
    self.headPortraitView.backgroundColor = kBackgroundColor;
    kViewRadius(self.headPortraitView, 33/2);
    self.headPortraitView.alpha = 0.3;
    
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(certify)];
    ges.delegate = self;
    [self.headPortraitView addGestureRecognizer:ges];

    
    self.headImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 171/2 + 12, 72.5 - 64 + kNavigationBarHeight + 8, 15, 15)];
    self.headImg.image = kImage(@"支付完成");
    
    UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(self.headImg.xx + 4, 72.5 - 64 + kNavigationBarHeight + 8, SCREEN_WIDTH - self.headImg.xx - 5, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:[UIColor whiteColor]];
    nameLbl.text = @"未认证";
    self.nameLbl = nameLbl;
    
    //头像框
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 35, 170/2 - 64 + kNavigationBarHeight  , 70, 70)];
    img.image = [UIImage imageNamed:@"头像"];
    img.layer.cornerRadius = 35;
    img.layer.masksToBounds = YES;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    img.userInteractionEnabled = YES;
    [img addGestureRecognizer:tap];
    
    self.logoimage = img;
    
    
    //姓名
    UILabel * name = [[UILabel alloc]initWithFrame:CGRectMake(0, img.yy+14, SCREEN_WIDTH, 16)];
    name.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    name.textColor = [UIColor whiteColor];
    name.text = @"未设置昵称";
    name.textAlignment = NSTextAlignmentCenter;
    name.adjustsFontSizeToFitWidth = YES;
    self.name = name;
    
    
    //签名
    UILabel * sign = [[UILabel alloc]initWithFrame:CGRectMake(0, name.yy+10, SCREEN_WIDTH, 12)];
    sign.text = @"此人很懒，没留下什么";
    sign.font = FONT(12);
    sign.textColor = [UIColor whiteColor];
    sign.textAlignment = NSTextAlignmentCenter;
    sign.adjustsFontSizeToFitWidth = YES;
    sign.numberOfLines = 0;
    self.sign = sign;
    
    for (int i = 0; i < 3; i ++) {

        UILabel *nameLbl0 = [self createlabelwithFrame:CGRectMake(SCREEN_WIDTH / 3 * i, sign.yy + 28, SCREEN_WIDTH / 3, 12) title1:array1[i] fontname:@"PingFangSC-Regular" textsize:12];
        [self.topview addSubview:nameLbl0];
        self.numLbl = nameLbl0;

        UILabel *numberLbl1 = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH / 3 * 0, nameLbl0.yy + 7, SCREEN_WIDTH / 3, 15) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(15) textColor:[UIColor whiteColor]];
//        numberLbl1.text = @"0.00";
        [self.topview addSubview:numberLbl1];
        self.numberLbl1 = numberLbl1;
        
        UILabel *numberLbl2 = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH / 3 * 1, nameLbl0.yy + 7, SCREEN_WIDTH / 3, 15) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(15) textColor:[UIColor whiteColor]];
//        numberLbl2.text = @"0.00";
        [self.topview addSubview:numberLbl2];
        self.numberLbl2 = numberLbl2;
        
        UILabel *numberLbl3 = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH / 3 * 2, nameLbl0.yy + 7, SCREEN_WIDTH / 3, 15) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(15) textColor:[UIColor whiteColor]];
//        numberLbl3.text = @"0.00";
        [self.topview addSubview:numberLbl3];
        self.numberLbl3 = numberLbl3;
        
        
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * i, sign.yy + 28, SCREEN_WIDTH / 3, 27) title:@"" backgroundColor:kClearColor];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.topview addSubview:btn];
        
    }
    
    [self.topview addSubview:[self createview:CGRectMake(SCREEN_WIDTH/3-1, sign.yy + 33, 1, 20)]];
    [self.topview addSubview:[self createview:CGRectMake(SCREEN_WIDTH * 2/3-1, sign.yy + 33, 1, 20)]];
    
    [self.topview addSubview:self.headPortraitView];
    [self.topview addSubview:self.headImg];
    [self.topview addSubview:nameLbl];
    [self.topview addSubview:img];
    [self.topview addSubview:name];
    [self.topview addSubview:sign];
    
}
-(void)tap{
    NSLog(@"%s",__func__);
    InfoVC * vc = [InfoVC new];
    [self.navigationController pushViewController: vc animated:YES];
    
}
-(void)btnclick : (UIButton * )sender{
    NSLog(@"%s",__func__);
    int a = (int)sender.tag - 100;
    switch (a) {
        case 0:{
            BalanceVC * vc = [BalanceVC new];
            vc.accountNumber = self.array[0][@"accountNumber"];
            vc.title = @"余额";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            
            
            MyCarbonBubbleVC * vc = [MyCarbonBubbleVC new];
            vc.accountNumber = self.array[2][@"accountNumber"];
            vc.state = 2;
            vc.title = @"我的碳泡泡";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            MyCarbonBubbleVC * vc = [MyCarbonBubbleVC new];
            vc.accountNumber = self.array[1][@"accountNumber"];
            vc.state = 1;
            vc.title = @"积分";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titlearray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineVCCell * cell = [[MineVCCell alloc]initWithfirstimage:imagearray[indexPath.row] title:titlearray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UILabel *)createlabelwithFrame:(CGRect)frame title1:(NSString * )title1 fontname : (NSString *)name textsize : (CGFloat)size{
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.text = title1;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:name size:size];
    
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

-(UIView*)createview:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kLineColor;
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            PersonalCenterVC * vc = [[PersonalCenterVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            OrderVC * vc = [[OrderVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            BookVC * bookview = [[BookVC alloc]init];
            [self.navigationController pushViewController:bookview animated:YES];
        }
            break;
        case 3:
        {
            CollectBookVC * vc = [CollectBookVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            InviteGiftVC * vc = [InviteGiftVC alloc];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:{
            SettingVC * vc = [SettingVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;

        default:
            break;
}
}
//刷新信息
-(void)RefreshInfo{
    
    [self.logoimage sd_setImageWithURL: [NSURL URLWithString:[[TLUser user].photo convertImageUrl]] placeholderImage:kImage(@"头像")];

    
    TLNetworking * http = [TLNetworking new];
    http.code = USER_INFO;
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        NSDictionary * dic = responseObject[@"data"];
        [[TLUser user]saveUserInfo:dic];
        [[TLUser user]setUserInfoWithDict:dic];
        
        
        NSLog(@"%@",[TLUser user].userExt[@"personAuthStatus"]);
        if ([[TLUser user].userExt[@"personAuthStatus"] isEqualToString:@"1"]) {
            self.nameLbl.text = @"已个人认证";
            [self.nameLbl sizeToFit];
            self.nameLbl.frame = CGRectMake(SCREEN_WIDTH - self.nameLbl.width - 5, 72.5 - 64 + kNavigationBarHeight + 8, self.nameLbl.width, 15);
            self.headImg.frame = CGRectMake(SCREEN_WIDTH - self.nameLbl.width - 15 - 15, 72.5 - 64 + kNavigationBarHeight + 8, 15, 15);
            self.headPortraitView.frame = CGRectMake(self.headImg.x - 5, 72.5 - 64 + kNavigationBarHeight,SCREEN_WIDTH - self.headImg.x + 30, 33);
        }
        else if([[TLUser user].userExt[@"companyAuthStatus"] isEqualToString:@"1"]){
            self.nameLbl.text = @"已企业认证";
            [self.nameLbl sizeToFit];
            self.nameLbl.frame = CGRectMake(SCREEN_WIDTH - self.nameLbl.width - 5, 72.5 - 64 + kNavigationBarHeight + 8, self.nameLbl.width, 15);
            self.headImg.frame = CGRectMake(SCREEN_WIDTH - self.nameLbl.width - 15 - 15, 72.5 - 64 + kNavigationBarHeight + 8, 15, 15);
            self.headPortraitView.frame = CGRectMake(self.headImg.x - 5, 72.5 - 64 + kNavigationBarHeight,SCREEN_WIDTH - self.headImg.x + 30, 33);
        }
        else{
            self.nameLbl.text = @"未认证";
        }
        
        if ([USERXX isBlankString:[TLUser user].nickname] == YES) {
            self.name.text = @"未设置昵称";
        }else
        {
            self.name.text = [TLUser user].nickname;
        }
        
        if ([USERXX isBlankString:[TLUser user].introduce] == YES) {
            self.sign.text = @"简介：此人很懒，没什么留言";
        }else
        {
            self.sign.text = [TLUser user].introduce;
        }
        
        
    } failure:^(NSError *error) {

        
        
    }];
    
    TLNetworking * http1 = [[TLNetworking alloc]init];
    http1.code = @"802300";
    http1.parameters[@"userId"] = [TLUser user].userId;
    http1.parameters[@"start"] = @(1);
    http1.parameters[@"limit"] = @(10);
    [http1 postWithSuccess:^(id responseObject) {
        self.array = responseObject[@"data"][@"list"];
//        for (int i = 0; i < 3; i ++) {
        if (self.array.count > 0) {
            float amount1 = [self.array[0][@"amount"] floatValue] / 1000;
            NSString * str1 = [NSString stringWithFormat:@"%.2f",amount1];
            self.numberLbl1.text = str1;
            
            float amount2 = [self.array[1][@"totalAmount"] floatValue] / 1000;
            NSString * str2 = [NSString stringWithFormat:@"%.2f",amount2];
            self.numberLbl3.text = str2;
            
            if (self.array[2][@"amount"]) {
                float amount3 = [self.array[2][@"amount"] floatValue] / 1000;
                NSString * str3 = [NSString stringWithFormat:@"%.2f",amount3];
                self.numberLbl2.text = str3;
            }
        }
        
//        }
        [self.table1 reloadData];
    } failure:^(NSError *error) {
        
        
    }];
    
    
}
-(void)certify{
    CertifyVC * vc = [CertifyVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
