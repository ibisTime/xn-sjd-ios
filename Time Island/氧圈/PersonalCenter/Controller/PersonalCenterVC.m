//
//  PersonalCenterVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/28.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "PersonalCenterVC.h"
#import "PersonalCenterHeadView.h"
#import "PersonalCenterTableVIew.h"
@interface PersonalCenterVC ()<RefreshDelegate>

@property (nonatomic , strong)PersonalCenterHeadView *headView;

@property (nonatomic , strong)PersonalCenterTableVIew *tableView;

@end

@implementation PersonalCenterVC


-(void)viewWillAppear:(BOOL)animated
{
    [self navigationTransparentClearColor];
    //    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self navigationSetDefault];
    
}

-(PersonalCenterHeadView *)headView
{
    if (!_headView) {
        _headView = [[PersonalCenterHeadView alloc]initWithFrame:CGRectMake(0, -kNavigationBarHeight, SCREEN_WIDTH, 180 - 65 + kNavigationBarHeight + 40)];
        
    }
    return _headView;
}

- (PersonalCenterTableVIew *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[PersonalCenterTableVIew alloc] initWithFrame:CGRectMake(0,  _headView.yy, SCREEN_WIDTH, SCREEN_HEIGHT - _headView.yy - kNavigationBarHeight) style:UITableViewStyleGrouped];
        
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kBackgroundColor;
        //        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
    [self tableViewTopView];
}

-(void)tableViewTopView
{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 62.5)];

    footView.backgroundColor = kWhiteColor;
    
    UIView *footlineView = [[UIView alloc]initWithFrame:CGRectMake(15, 21, 3, 15)];
    footlineView.backgroundColor = kHexColor(@"#23AD8C");
    kViewRadius(footlineView, 1.5);
    [footView addSubview:footlineView];
    
    UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(footlineView.xx + 6, 20, SCREEN_WIDTH - footlineView.xx - 21, 17) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(17) textColor:kTextBlack];
    nameLabel.text = [LangSwitcher switchLang:@"TA的动态" key:nil];
    [footView addSubview:nameLabel];
    
    self.tableView.tableHeaderView = footView;
}



@end
