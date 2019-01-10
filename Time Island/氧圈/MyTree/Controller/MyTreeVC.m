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
@interface MyTreeVC ()<RefreshDelegate>

@property (nonatomic , strong)MyTreeTableView *tableView;
@property (nonatomic , strong)CertificateOfPlantView *certificateView;
@end

@implementation MyTreeVC

-(void)viewWillAppear:(BOOL)animated
{
    [self navigationTransparentClearColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
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

-(CertificateOfPlantView *)certificateView
{
    if (!_certificateView) {
        _certificateView = [[CertificateOfPlantView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
    }
    return _certificateView;
}


-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
//            证书
            [[UserModel user] showPopAnimationWithAnimationStyle:1 showView:_certificateView];
            
        }
            break;
        case 1:
        {
//            地图
        }
            break;
        case 2:
        {
//            攻略
            
        }
            break;
        case 3:
        {
//            赠送
            
        }
            break;
        case 4:
        {
//            情感故事
            
        }
            break;
            
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.certificateView];
    self.title = @"我的树";
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
