//
//  MallMyVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/18.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MallMyVC.h"
#import "MineVCCell.h"
#import "ReceivingAddressVC.h"
#import "NewsVC.h"
#import "MallOrderVC.h"
#define titlearray @[@"我的购物车",@"我的商场订单",@"我的商场消息",@"我的收货地址",@"设置"]
#define imagearray @[@"商场购物车-未选中",@"",@"",@"",@"设置"]
@interface MallMyVC ()
@property (nonatomic,retain) UIView * topview;
@property (nonatomic,strong) TLTableView *table1;
@end

@implementation MallMyVC


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self navigationTransparentClearColor];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self navigationSetDefault];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.table1 = [TLTableView tableViewWithFrame:CGRectMake(0, -kNavigationBarHeight, kScreenWidth, kScreenHeight+55) delegate:self dataSource:self];
    self.topview = [[UIView alloc]initWithFrame:CGRectMake(0, -kNavigationBarHeight, kScreenWidth, 563/2 -64 + kNavigationBarHeight)];
    [self setupview];
    self.table1.tableHeaderView = self.topview;
    self.table1.refreshDelegate = self;
    //    [_table1 beginRefreshing];
    [_table1 addRefreshAction:^{
        [TLAlert alertWithInfo:@"网络连接失败！"];
        [self.table1 endRefreshHeader];
    }];
    [self.view addSubview:self.table1];
}
-(void)setupview{
    UIImageView *topiimage = [[UIImageView alloc]initWithFrame:self.topview.bounds];
    topiimage.image = kImage(@"我的背景");
    [self.topview addSubview:topiimage];
    

    
    //头像框
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 35, 170/2 - 64 + kNavigationBarHeight  , 70, 70)];
    img.image = [UIImage imageNamed:@"果树预售"];
    img.layer.cornerRadius = 35;
    img.layer.masksToBounds = YES;
    
    
    //姓名
    UILabel * name = [[UILabel alloc]initWithFrame:CGRectMake(0, img.yy+14, SCREEN_WIDTH, 16)];
    name.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    name.textColor = [UIColor whiteColor];
    name.text = @"王大锤";
    name.textAlignment = NSTextAlignmentCenter;
    name.adjustsFontSizeToFitWidth = YES;
    
    
    //签名
    UILabel * sign = [[UILabel alloc]initWithFrame:CGRectMake(0, name.yy+10, SCREEN_WIDTH, 12)];
    sign.text = @"此人很懒，没留下什么";
    sign.font = FONT(12);
    sign.textColor = [UIColor whiteColor];
    sign.textAlignment = NSTextAlignmentCenter;
    sign.adjustsFontSizeToFitWidth = YES;
    sign.numberOfLines = 0;
    

    [self.topview addSubview:img];
    [self.topview addSubview:name];
    [self.topview addSubview:sign];
    
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titlearray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineVCCell * cell = [[MineVCCell alloc]initWithfirstimage:imagearray[indexPath.row] title:titlearray[indexPath.row]];
    cell.selectionStyle = UIAccessibilityTraitNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 1:{
            MallOrderVC * vc = [MallOrderVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            NewsVC * vc = [[NewsVC alloc]init];
            UIBarButtonItem * item = [[UIBarButtonItem alloc]init];
            item.title = @"消息";
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:{
            ReceivingAddressVC * vc = [[ReceivingAddressVC alloc]init];
            vc.state = 2;
            UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
            backBtn.title = @"我的收货地址";
            vc.navigationItem.backBarButtonItem = backBtn;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(void)backBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
