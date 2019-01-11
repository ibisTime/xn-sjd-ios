//
//  FriendsTheTreeVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "FriendsTheTreeVC.h"
#import "FriendsTheTreeTableView.h"
@interface FriendsTheTreeVC ()<RefreshDelegate>

@property (nonatomic , strong)FriendsTheTreeTableView *tableView;

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
        _tableView.backgroundColor = kWhiteColor;
        //        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    self.title = @"ALEN的树";
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    
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
