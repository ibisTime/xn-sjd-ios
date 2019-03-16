//
//  FriendsTheTreeVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "FriendsTheTreeVC.h"
#import "FriendsTheTreeTableView.h"
#import "DonationView.h"
#import "BarrageView.h"
#import "BarrageModel.h"
#import "MapViewController.h"
#import "PersonalCenterVC.h"
#import "RecordVC.h"
#import "HistroyUserVC.h"
#import "BookVideoVC.h"
@interface FriendsTheTreeVC ()<RefreshDelegate,BarrageViewDelegate,UITableViewDelegate>;

@property (nonatomic , strong)FriendsTheTreeTableView *tableView;


@property (nonatomic , strong)DonationView *donationView;

@property (nonatomic , strong)BarrageView *barrageView;

@property (nonatomic,strong) NSMutableArray<BarrageModel *> * BarrageModels;

@property (nonatomic,strong) NSString * state;
@end

@implementation FriendsTheTreeVC


-(void)viewWillAppear:(BOOL)animated
{
    [self navigationTransparentClearColor];
    //    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self navigationSetDefault];
    
}

- (FriendsTheTreeTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[FriendsTheTreeTableView alloc] initWithFrame:CGRectMake(0, -kNavigationBarHeight , SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kBackgroundColor;
        //        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(DonationView *)donationView
{
    if (!_donationView) {
        _donationView = [[DonationView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_donationView.ShutDownBtn addTarget:self action:@selector(ShutDownBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_donationView.confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _donationView;
}




-(BarrageView *)barrageView
{
    if (!_barrageView) {
        _barrageView = [[BarrageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_barrageView.ShutDownBtn addTarget:self action:@selector(ShutDownBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        _barrageView.delegate = self;
        //        [_donationView.confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _barrageView;
}

-(void)ShutDownBtnClick
{
    [[UserModel user].cusPopView dismiss];
}

-(void)BarrageViewSelectRow:(NSInteger)row
{
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.showView = self.view;
    http.code = @"629384";
    http.parameters[@"status"] = @(1);
    http.parameters[@"adoptTreeCode"] = self.model.code;
    http.parameters[@"code"] = self.BarrageModels[row].code;
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        [[UserModel user].cusPopView dismiss];
        self.tableView.barrageModel = self.BarrageModels[row];
//        self.tableView.model = self.model;
        
        [self.tableView reloadData];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.tableView.state = @"Barrage";
            self.tableView.model = self.model;
            [self.tableView reloadData];
        });
        
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)confirmBtnClick
{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.showView = self.view;
    http.code = @"629360";
    http.parameters[@"toUserId"] = self.model.user[@"userId"];
    http.parameters[@"adoptTreeCode"] = self.model.code;
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        [[UserModel user].cusPopView dismiss];
        self.tableView.donation = 100;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [[UserModel user].cusPopView dismiss];
    }];
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getbarrageData];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    self.tableView.model = self.model;
//    self.tableView.delegate = self;
    [self.view addSubview:self.donationView];
    [self.view addSubview:self.barrageView];
//    self.title = [NSString stringWithFormat:@"%@的树",self.model.user[@"nickname"]];
    self.title = @"TA的树";
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            MapViewController *vc = [[MapViewController alloc]init];
            vc.latitude = [self.model.tree[@"latitude"] floatValue];
            vc.longitude= [self.model.tree[@"longitude"] floatValue];
            vc.namestr = self.model.tree[@"treeNumber"];
            vc.address = [NSString stringWithFormat:@"%@ %@ %@",self.model.tree[@"province"],self.model.tree[@"city"],self.model.tree[@"area"]];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
//            弹幕
            [[UserModel user]showPopAnimationWithAnimationStyle:3 showView:self.barrageView BGAlpha:0 isClickBGDismiss:YES];
        }
            break;
        case 2:
        {
//            捐赠
            [[UserModel user]showPopAnimationWithAnimationStyle:3 showView:self.donationView BGAlpha:0.5 isClickBGDismiss:YES];
        }
            break;
        case 3:
        {
            //个人主页
            PersonalCenterVC *vc = [PersonalCenterVC new];
            vc.state = @"rank";
            vc.userid = self.model.user[@"userId"];;
            [self.navigationController pushViewController:vc animated:YES];
            self.state = nil;
        }
            break;
        case 5:{
            BookVideoVC * vc = [[BookVideoVC alloc]init];
            vc.state = @"tree";
            vc.model = self.model;
            [self.navigationController pushViewController:vc animated:YES];
            self.state = nil;
        }
            
            break;
            
        default:
            break;
    }
}


-(void)refreshTableView:(TLTableView *)refreshTableview scrollView:(UIScrollView *)scroll
{
    if (self.tableView.contentOffset.y>(kHeight(432)/3 * 2)) {
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[UIColor colorWithRed:86/255.0 green:171/255.0 blue:142/255.0 alpha:0.99]] forBarMetrics:UIBarMetricsDefault];
    }else
    {
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[UIColor colorWithRed:86/255.0 green:171/255.0 blue:142/255.0  alpha:self.tableView.contentOffset.y / (kHeight(432)/3 * 2)]] forBarMetrics:UIBarMetricsDefault];
    }
    
}

-(UIImage *)imageWithBgColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender state:(NSString *)state
{
    if ([state isEqualToString:@"点击"]) {
        if (sender.tag == 101) {
            self.state = @"认养人介绍";
        }
        else{
            self.state = nil;
        }
    }
    else if ([state isEqualToString:@"点击主页"]){
        PersonalCenterVC *vc = [PersonalCenterVC new];
        vc.state = @"rank";
        vc.userid = self.model.user[@"userId"];;
        [self.navigationController pushViewController:vc animated:YES];
        self.state = nil;
    }

}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        if ([self.state isEqualToString:@"认养人介绍"]) {
            PersonalCenterVC *vc = [PersonalCenterVC new];
            vc.state = @"rank";
            vc.userid = self.model.user[@"userId"];;
            [self.navigationController pushViewController:vc animated:YES];
            self.state = nil;
        }
        else{
            if (indexPath.row == 6) {
                NSLog(@"%s,%ld",__func__,indexPath.row);
                RecordVC * vc = [RecordVC new];
                vc.treeNumber = self.model.tree[@"treeNumber"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if (indexPath.row == 7){
                NSLog(@"%s%ld",__func__,indexPath.row);
                HistroyUserVC * vc = [HistroyUserVC new];
                vc.productCode = self.model.tree[@"productCode"];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        
    }
}
//弹幕
-(void)getbarrageData{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629387";
    http.parameters[@"status"] = @(1);
    http.parameters[@"orderColumn"] = @"order_no";
    http.parameters[@"orderDir"] = @"asc";
    [http postWithSuccess:^(id responseObject) {
        self.BarrageModels = [BarrageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.barrageView.BarrageModels = self.BarrageModels;
    } failure:^(NSError *error) {
        
    }];
}
@end
