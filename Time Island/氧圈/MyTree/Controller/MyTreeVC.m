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
#import "PersonalCenterVC.h"
#import "ThePropsDetailsView.h"
#import "BuyPropsView.h"
#import "HistroyUserVC.h"
#import "RecordVC.h"
@interface MyTreeVC ()<RefreshDelegate,ClickDelegate,ClickConvertDelegrate,BuyPropsdelegate>

@property (nonatomic , strong)MyTreeTableView *tableView;
@property (nonatomic , strong)CertificateOfPlantView *certificateView;
@property (nonatomic , strong)ThePropsView *propsView;
@property (nonatomic,strong) ThePropsDetailsView * ThePropsDetails;
@property (nonatomic,strong) BuyPropsView * BuyProps;
@property (nonatomic , strong)NSMutableArray <MyTreeEnergyModel *>*energyModels;

@property (nonatomic,strong) NSString * state;
@property (nonatomic,strong) NSString * tag;

@property (nonatomic,strong) NSMutableArray * propArray;

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
        _tableView.model = self.model;
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kWhiteColor;
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

//道具列表
-(ThePropsView *)propsView
{
    if (!_propsView) {
        _propsView = [[ThePropsView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _propsView.delegate = self;
        [_propsView.deleteBtn addTarget:self action:@selector(ShutDownBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _propsView;
}


//道具详情界面
-(ThePropsDetailsView *)ThePropsDetails{
    if (!_ThePropsDetails) {
        _ThePropsDetails = [[ThePropsDetailsView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _ThePropsDetails.delegate = self;
        [_ThePropsDetails.ShutDownBtn addTarget:self action:@selector(ShutDownBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _ThePropsDetails;
}

//道具购买揭秘呐
-(BuyPropsView *)BuyProps{
    if (!_BuyProps) {
        _BuyProps = [[BuyPropsView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _BuyProps.delegate = self;
        [_BuyProps.ShutDownBtn addTarget:self action:@selector(ShutDownBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _BuyProps;
}
//关闭
-(void)ShutDownBtnClick
{
    [[UserModel user].cusPopView dismiss];
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
            self.certificateView.model = self.model;
            [[UserModel user] showPopAnimationWithAnimationStyle:1 showView:_certificateView BGAlpha:0.5 isClickBGDismiss:YES];
            
        }
            break;
        case 1:
        {
            //            地图
            MapViewController *vc = [[MapViewController alloc]init];
            vc.latitude = [self.model.tree[@"latitude"] floatValue];
            vc.longitude= [self.model.tree[@"longitude"] floatValue];
            vc.namestr = self.model.tree[@"treeNumber"];
            vc.address = [NSString stringWithFormat:@"%@ %@ %@",self.model.tree[@"province"],self.model.tree[@"city"],self.model.tree[@"area"]];
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
            vc.model = self.model;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if ([self.state isEqualToString:@"认养人介绍"]) {
            PersonalCenterVC *vc = [PersonalCenterVC new];
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.certificateView];
    [self.view addSubview:self.propsView];
//    [self.view addSubview:self.ThePropsDetails];
    self.title = @"我的树";
    [self LoadData];
}


//
-(void)LoadData{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629357";
    http.parameters[@"status"] = @"0";
    [http postWithSuccess:^(id responseObject) {
        
        self.energyModels = [MyTreeEnergyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];

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

//点击积分按钮
-(void)ClickButton:(NSMutableArray *)array{
    [[UserModel user].cusPopView dismiss];
    if ([array[0][@"isBuy"] isEqualToString:@"1"]) {
        self.BuyProps.array = array;
        [[UserModel user]showPopAnimationWithAnimationStyle:1 showView:self.BuyProps BGAlpha:0.5 isClickBGDismiss:YES];
    }
    else{
        self.ThePropsDetails.array = array;
        [[UserModel user] showPopAnimationWithAnimationStyle:1 showView:self.ThePropsDetails BGAlpha:0.5 isClickBGDismiss:YES];
    }
    
    
}

//点击确定兑换按钮
-(void)ClickConvertBtn:(NSMutableArray *)array{
    NSLog(@"%s",__func__);
//    [[UserModel user].cusPopView dismiss];
//    self.BuyProps.array = array;
//    [[UserModel user]showPopAnimationWithAnimationStyle:1 showView:self.BuyProps BGAlpha:0.5 isClickBGDismiss:YES];
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629510";
    http.parameters[@"toolCode"] = array[0][@"code"];
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        [[UserModel user].cusPopView dismiss];
        self.BuyProps.array = array;
        [[UserModel user]showPopAnimationWithAnimationStyle:1 showView:self.BuyProps BGAlpha:0.5 isClickBGDismiss:YES];
    } failure:^(NSError *error) {
        
    }];
    
}
//立即使用按钮
-(void)UsedBtn:(NSString *)code{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629515";
    http.parameters[@"toolCode"] = code;
    http.parameters[@"start"] = @(1);
    http.parameters[@"limit"] = @(10);
    http.parameters[@"status"] = @(0);
    [http postWithSuccess:^(id responseObject) {
        NSLog(@"%@",responseObject);
        TLNetworking * http1 = [[TLNetworking alloc]init];
        http1.code = @"629511";
        http1.parameters[@"toolOrderCode"] = responseObject[@"data"][@"list"][0][@"code"];
        http1.parameters[@"adoptTreeCode"] = self.model.code;
        http1.parameters[@"userId"] = [TLUser user].userId;
        [http1 postWithSuccess:^(id responseObject) {
            [[UserModel user].cusPopView dismiss];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            
        }];
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
