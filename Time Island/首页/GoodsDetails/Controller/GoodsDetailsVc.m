//
//  GoodsDetailsVc.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/21.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "GoodsDetailsVc.h"
#import "GoodsDetailsTableView.h"
#import "YSActionSheetView.h"
#import "RenYangFieldView.h"
#import "RenYangFieldDeyailView.h"
#import "RealNameView.h"
@interface GoodsDetailsVc ()<SLBannerViewDelegate,RefreshDelegate,PlatformButtonClickDelegate>
@property (nonatomic, strong) UIButton *myButton;//推文
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *renYangButton;//价格
@property (nonatomic , strong)GoodsDetailsTableView *tableView;
@property (nonatomic , strong)SLBannerView *banner;
@property (nonatomic,strong)TreeModel  * TreeModels;
@property (nonatomic,strong) NSArray * BannerArray;
@property (nonatomic,strong) NSMutableArray * muarr;;
//@property (nonatomic , strong) RenYangFieldView *renYangFieldView;
@property (nonatomic , strong) RealNameView *realNameView;
@property (nonatomic , strong) RenYangFieldDeyailView *renYangFieldDeyailView;
@end

@implementation GoodsDetailsVc


-(void)viewWillAppear:(BOOL)animated
{
    [self navigationTransparentClearColor];
    [self refresh];
    //    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self navigationSetDefault];
    
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

- (GoodsDetailsTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[GoodsDetailsTableView alloc] initWithFrame:CGRectMake(0, -kNavigationBarHeight , SCREEN_WIDTH,SCREEN_HEIGHT - 45) style:UITableViewStylePlain];
        
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kWhiteColor;
    }
    return _tableView;
}

-(SLBannerView *)banner
{
    if (!_banner) {
//        NSLog(@"%@",self.TreeModels[0].bannerPic);
        _banner = [SLBannerView bannerView];
        _banner.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH);
        //工程图片
        _banner.slImages = @[@"树 跟背景", @"树 跟背景", @"树 跟背景", @"树 跟背景", @"树 跟背景"];
        _banner.delegate = self;
        [_banner.timer invalidate];
    }
    return _banner;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.banner;
    [self initcustomView];
    [self initcustomRenYang];
    
    self.realNameView = [[RealNameView alloc] initWithFrame:CGRectMake(20,150, kScreenWidth-40, 300)];
    kViewRadius(self.realNameView , 10);
}

- (void)initcustomRenYang
{
    CoinWeakSelf;
    self.renYangFieldDeyailView = [[RenYangFieldDeyailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SCREEN_HEIGHT)];
    self.renYangFieldDeyailView.sureBlock = ^{

        [[UserModel user].cusPopView dismiss];
        [[UserModel user]showPopAnimationWithAnimationStyle:3 showView:weakSelf.realNameView BGAlpha:0.5 isClickBGDismiss:YES];

    };
}



- (void)initcustomView
{
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kNavigationBarHeight - 45, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = kLineColor;
    [self.view addSubview:lineView];
    
    self.myButton = [UIButton buttonWithTitle:@"我的" titleColor:kTextBlack backgroundColor:[UIColor whiteColor] titleFont:14];
    self.myButton.frame = CGRectMake(0, SCREEN_HEIGHT - 44 - kNavigationBarHeight, kScreenWidth/4, 44);
    self.myButton.clipsToBounds = YES;
    self.myButton.tag = 100;
    [self.view addSubview:self.myButton];
    [self.myButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.shareButton = [UIButton buttonWithTitle:@"分享" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:14];
    self.shareButton.frame = CGRectMake(kScreenWidth/4, SCREEN_HEIGHT - 44 - kNavigationBarHeight, kScreenWidth/4, 44);
    self.shareButton.clipsToBounds = YES;
    [self.view addSubview:self.shareButton];
    self.shareButton.tag = 101;
    [self.shareButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.renYangButton = [UIButton buttonWithTitle:@"申请认养" titleColor:kWhiteColor backgroundColor:[UIColor redColor] titleFont:14];
    self.renYangButton.frame = CGRectMake(kScreenWidth/2, SCREEN_HEIGHT - 44 - kNavigationBarHeight, kScreenWidth/2, 44);
    self.renYangButton.clipsToBounds = YES;
    [self.view addSubview:self.renYangButton];
    self.renYangButton.tag = 102;
    [self.renYangButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)buttonClick:(UIButton *)sender
{
    switch (sender.tag - 100) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            YSActionSheetView * ysSheet=[[YSActionSheetView alloc]initNYSView];
            ysSheet.delegate=self;
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            [window addSubview:ysSheet];
        }
            break;
        case 2:
        {

            [[UserModel user]showPopAnimationWithAnimationStyle:3 showView:self.renYangFieldDeyailView BGAlpha:0.5 isClickBGDismiss:YES];
        }
            break;
            
        default:
            break;
    }
    
    
}




- (void) customActionSheetButtonClick:(YSActionSheetButton *) btn
{

    
    
}

- (void)bannerView:(SLBannerView *)banner didClickImagesAtIndex:(NSInteger)index
{
    NSLog(@"++++++++++songlei 点击了%ld ++++++++++", index);
}


-(void)refresh{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629026";
    http.parameters[@"code"] = self.treemodel.code;
    [http postWithSuccess:^(id responseObject) {
        NSDictionary * dic = (NSDictionary * )responseObject;
        self.TreeModels = [TreeModel mj_objectWithKeyValues:dic[@"data"]];
        NSString * string = [dic[@"data"][@"bannerPic"] stringByReplacingOccurrencesOfString:@"||" withString:@","];
        self.BannerArray = [string componentsSeparatedByString:@","];
        NSMutableArray *dateMutablearray = [@[] mutableCopy];
        for (int i = 0; i < self.BannerArray.count; i ++) {
            NSString * string = [self.BannerArray[i] convertImageUrl];
            [dateMutablearray addObject:string];
        }
        NSArray * arr = [NSArray arrayWithArray:dateMutablearray];
        self.banner.slImages = arr;
        self.tableView.TreeModel = self.TreeModels;
        
        self.renYangFieldDeyailView.slImages = arr;
        self.renYangFieldDeyailView.TreeModel = self.TreeModels;
        
        
        
        
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
    }];
}

@end
