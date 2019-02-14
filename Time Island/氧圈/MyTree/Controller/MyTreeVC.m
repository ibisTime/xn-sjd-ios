//
//  MyTreeVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/10.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MyTreeVC.h"
#import "MyTreeTableView.h"
#import "CertificateOfPlantView.h"
#import "ThePropsView.h"
#import "StrategyVC.h"
#import "GivingVC.h"
#import "FriendsTheTreeVC.h"
#import "MapViewController.h"
#import "MyTreeEnergyModel.h"
#import "MyArticleViC.h"
#import "BookVideoVC.h"
@interface MyTreeVC ()<RefreshDelegate>

@property (nonatomic , strong)MyTreeTableView *tableView;
@property (nonatomic , strong)CertificateOfPlantView *certificateView;
@property (nonatomic , strong)ThePropsView *propsView;

@property (nonatomic , strong)NSMutableArray <MyTreeEnergyModel *>*energyModels;

@end

@implementation MyTreeVC

-(void)viewWillAppear:(BOOL)animated
{
    [self navigationTransparentClearColor];
    //    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self navigationSetDefault];
    
}

- (MyTreeTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[MyTreeTableView alloc] initWithFrame:CGRectMake(0, -kNavigationBarHeight , SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kWhiteColor;
        //        [self.view addSubview:_tableView];
    }
    return _tableView;
}


//证书
-(CertificateOfPlantView *)certificateView
{
    if (!_certificateView) {
        _certificateView = [[CertificateOfPlantView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_certificateView.ShutDownBtn addTarget:self action:@selector(ShutDownBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _certificateView;
}



//关闭
-(void)ShutDownBtnClick
{
    [[UserModel user].cusPopView dismiss];
}

//
-(ThePropsView *)propsView
{
    if (!_propsView) {
        _propsView = [[ThePropsView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_propsView.deleteBtn addTarget:self action:@selector(ShutDownBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _propsView;
}



-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    
    if (index >= 100) {
        FriendsTheTreeVC *vc = [FriendsTheTreeVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    switch (index) {
        case 0:
        {
            //            证书
            [[UserModel user] showPopAnimationWithAnimationStyle:1 showView:_certificateView BGAlpha:0.5 isClickBGDismiss:YES];
            
        }
            break;
        case 1:
        {
            //            地图
            MapViewController *vc = [[MapViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            //            道具
            [[UserModel user] showPopAnimationWithAnimationStyle:3 showView:_propsView BGAlpha:0 isClickBGDismiss:YES];
        }
            break;
        case 3:
        {
            //            攻略
            StrategyVC *vc = [[StrategyVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            //            赠送
            GivingVC *vc = [[GivingVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            //            情感频道
            BookVideoVC * vc = [[BookVideoVC alloc]init];
            vc.state = @"tree";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        FriendsTheTreeVC *vc = [FriendsTheTreeVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.certificateView];
    [self.view addSubview:self.propsView];
    self.title = @"我的树";
    [self LoadData];
}

-(void)LoadData
{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629357";
    http.parameters[@"status"] = @"0";
//    http.parameters[@"limit"] = @(1);
//    http.parameters[@""] = []
    [http postWithSuccess:^(id responseObject) {
        
        //        [self.treeArray addObjectsFromArray:responseObject[@"data"][@"list"]];
        self.energyModels = [MyTreeEnergyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.tableView.energyModels = self.energyModels;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
