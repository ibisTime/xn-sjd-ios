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

#import "CertifyVC.h"

#define titlearray @[@"我的碳泡泡",@"我的认养",@"我的订单",@"我的文章",@"我的收藏",@"邀请有礼",@"设置"]
#define imagearray @[@"泡泡",@"",@"",@"",@"",@"",@"设置"]
#define array1 @[@"余额",@"碳泡泡",@"积分"]
@interface MineVC ()
@property (nonatomic,retain) UIView * topview;
@property (nonatomic,strong) TLTableView *table1;
@property (nonatomic,strong) UILabel * name;
@property (nonatomic,strong) UIImageView * logoimage;
@property (nonatomic,strong) UILabel * nameLbl;

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
    
//    [[NSString alloc]convertImageUrl];
//    NSString * str = [[NSString alloc]init];
//    NSLog(@" convertImageUrl = %@",[str convertImageUrl]);
    
    
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
//    [_table1 beginRefreshing];
    [_table1 addRefreshAction:^{
        [self RefreshInfo];
        [self.table1 endRefreshHeader];
    }];
    [self.view addSubview:self.table1];
    
    
//    [self.navigationController pushViewController:tabbar animated:YES];
}

-(void)setupview{
    UIImageView *topiimage = [[UIImageView alloc]initWithFrame:self.topview.bounds];
    topiimage.image = kImage(@"我的背景");
    [self.topview addSubview:topiimage];
    
    UIView *headPortraitView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 171/2, 72.5 - 64 + kNavigationBarHeight, 171, 33)];
    headPortraitView.backgroundColor = kBackgroundColor;
    kViewRadius(headPortraitView, 33/2);
    headPortraitView.alpha = 0.3;
    
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(certify)];
    ges.delegate = self;
    [headPortraitView addGestureRecognizer:ges];

    
    UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 171/2 + 12, 72.5 - 64 + kNavigationBarHeight + 8, 15, 15)];
    headImg.image = kImage(@"支付完成");
    
    UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(headImg.xx + 4, 72.5 - 64 + kNavigationBarHeight + 8, SCREEN_WIDTH - headImg.xx - 5, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:[UIColor whiteColor]];
    nameLbl.text = @"未认证";
    self.nameLbl = nameLbl;
    
    //头像框
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 35, 170/2 - 64 + kNavigationBarHeight  , 70, 70)];
    img.image = [UIImage imageNamed:@"果树预售"];
    img.layer.cornerRadius = 35;
    img.layer.masksToBounds = YES;
    self.logoimage = img;
    
    
    //姓名
    UILabel * name = [[UILabel alloc]initWithFrame:CGRectMake(0, img.yy+14, SCREEN_WIDTH, 16)];
    name.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    name.textColor = [UIColor whiteColor];
    name.text = @"王大锤";
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
    
    for (int i = 0; i < 3; i ++) {
        
        UILabel *nameLbl = [self createlabelwithFrame:CGRectMake(SCREEN_WIDTH / 3 * i, sign.yy + 28, SCREEN_WIDTH / 3, 12) title1:array1[i] fontname:@"PingFangSC-Regular" textsize:12];
        [self.topview addSubview:nameLbl];
        
        UILabel *numberLbl = [self createlabelwithFrame:CGRectMake(SCREEN_WIDTH / 3 * i, nameLbl.yy + 7, SCREEN_WIDTH / 3, 15) title1:@"38930" fontname:@"PingFangSC-Bold" textsize:15];
        [self.topview addSubview:numberLbl];
    }
    
    [self.topview addSubview:[self createview:CGRectMake(SCREEN_WIDTH/3-1, sign.yy + 33, 1, 20)]];
    [self.topview addSubview:[self createview:CGRectMake(SCREEN_WIDTH * 2/3-1, sign.yy + 33, 1, 20)]];
    
    [self.topview addSubview:headPortraitView];
    [self.topview addSubview:headImg];
    [self.topview addSubview:nameLbl];
    [self.topview addSubview:img];
    [self.topview addSubview:name];
    [self.topview addSubview:sign];
    
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
    cell.selectionStyle = UIAccessibilityTraitNone;
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
            MyCarbonBubbleVC * vc = [MyCarbonBubbleVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            TLUserLoginVC * login = [[TLUserLoginVC alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
            break;
        case 2:
        {
            OrderVC * vc = [[OrderVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            BookVC * bookview = [[BookVC alloc]init];
            [self.navigationController pushViewController:bookview animated:YES];
        }
            break;
        case 4:
        {
            CollectVC * vc = [CollectVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            InviteVC * vc = [InviteVC alloc];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:{
            SettingVC * vc = [SettingVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;

        default:
            break;
}
}
//刷新s信息
-(void)RefreshInfo{
    
    
    [self.logoimage sd_setImageWithURL: [NSURL URLWithString:[[TLUser user].photo convertImageUrl]]];

    
    if ([TLUser user].idNo) {
        self.nameLbl.text = @"已认证";
    }
    else{
        self.nameLbl.text = @"未认证";
    }
    TLNetworking * http = [TLNetworking new];
    http.code = USER_INFO;
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        NSDictionary * dic = responseObject[@"data"];
        [[TLUser user]saveUserInfo:dic];
    } failure:^(NSError *error) {
        self.name.text = @"王大锤" ;
        self.logoimage.image =  [UIImage imageNamed:@"果树预售"];
    }];
}
-(void)certify{
    CertifyVC * vc = [CertifyVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
