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
@interface FriendsTheTreeVC ()<RefreshDelegate>

@property (nonatomic , strong)FriendsTheTreeTableView *tableView;


@property (nonatomic , strong)DonationView *donationView;

@property (nonatomic , strong)BarrageView *barrageView;
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

-(void)ShutDownBtnClick
{
    [[UserModel user].cusPopView dismiss];
}


-(BarrageView *)barrageView
{
    if (!_barrageView) {
        _barrageView = [[BarrageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_barrageView.ShutDownBtn addTarget:self action:@selector(ShutDownBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        //        [_donationView.confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _barrageView;
}

-(void)confirmBtnClick
{
    [[UserModel user].cusPopView dismiss];
    self.tableView.donation = 100;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.donationView];
    [self.view addSubview:self.barrageView];
    self.title = @"ALEN的树";
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
