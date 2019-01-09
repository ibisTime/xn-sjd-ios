//
//  HomeVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/2.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "HomeVC.h"
#import "HomeHeaderView.h"
#import "HomeFindModel.h"
#import "HomeTbleView.h"
#import "TLTopCollectionView.h"
#import "PlateMineModel.h"
#import "TLTextField.h"
@interface HomeVC ()<RefreshDelegate,RefreshCollectionViewDelegate,UIScrollViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) HomeHeaderView *headerView;
@property (nonatomic,strong) NSArray <HomeFindModel *>*findModels;
@property (nonatomic,strong) NSMutableArray <BannerModel *>*bannerRoom;
@property (nonatomic, strong) HomeTbleView *tableView;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) TLTopCollectionView *topView;

@property (nonatomic, strong) UIScrollView *contentScrollew;

@property (nonatomic, assign) NSInteger page;//当前页数

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) TLTextField *searchTf;//当前页数

@end

@implementation HomeVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去掉导航栏底部的黑线
    // self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self headRefresh];
}

-(void)viewDidAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"首页";
    [self initTableView];
    [self initSearchBar];
}

- (void)initSearchBar {
    
    [UINavigationBar appearance].barTintColor = kAppCustomMainColor;
    CGFloat height = 35;
    //搜索
    UIView *searchBgView = [[UIView alloc] init];
    //    UIView *searchBgView = [[UIView alloc] init];
    searchBgView.frame = CGRectMake(0,0,kScreenWidth-40,height);
    searchBgView.backgroundColor = kWhiteColor;
    searchBgView.userInteractionEnabled = YES;
    searchBgView.layer.cornerRadius = height/2.0;
    searchBgView.clipsToBounds = YES;
    
    self.navigationItem.titleView = searchBgView;
    
    
    //搜索输入框
    self.searchTf = [[TLTextField alloc] initWithFrame:CGRectZero
                                             leftTitle:@""
                                            titleWidth:0
                                           placeholder:@"请输入商品信息"];
    self.searchTf.delegate = self;
    self.searchTf.returnKeyType = UIReturnKeySearch;
    self.searchTf.frame = CGRectMake(0,0,kScreenWidth-40,35);
    [self.searchTf addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    [searchBgView addSubview:self.searchTf];
    
//    [self.searchTf setValue:[NSNumber numberWithInt:-15] forKey:@"paddingLeft"];
    self.searchTf.leftView.frame = CGRectMake(0, 0, 20, 0);
    self.searchTf.leftViewMode = UITextFieldViewModeAlways;
    

    [self.searchTf mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 13, 0, 0));
        
        make.width.mas_greaterThanOrEqualTo(kScreenWidth - 20 - 40 -  15 - 13-50);
    }];
    UIImageView *searImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 15, 15)];
    searImage.image = [UIImage imageNamed:@"位置"];
    [searchBgView addSubview:searImage];
    
}
    

- (void)initTableView {
    
    self.contentScrollew = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavigationBarHeight)];
    [self.view addSubview:self.contentScrollew];
    self.contentScrollew.delegate = self;
    self.contentScrollew.scrollEnabled = YES;
    self.contentScrollew.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
//    self.contentScrollew.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    self.contentScrollew.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    self.tableView = [[HomeTbleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-200) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.refreshDelegate = self;
    [self.contentScrollew addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    
//    [self.tableView addRefreshAction:^{
//        [weakSelf requestBannerList];
//
//
//    }];
    [self initCollection];
//    [self.tableView beginRefreshing];

}

-(void)headRefresh
{
    self.page = 1;
    [self.contentScrollew.mj_header beginRefreshing];
    [self requestBannerList];

    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.searchTf resignFirstResponder];
}

-(void)footerRefresh
{
    self.page ++;
    [self.contentScrollew.mj_footer beginRefreshing];

    [self requestBannerList];

    
}

- (void)initCollection
{
    
    
    UILabel *lable = [UILabel labelWithTitle:@"古树认养" frame:CGRectMake(10, self.headerView.yy, kScreenWidth -30, 30)];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.font = [UIFont boldSystemFontOfSize:16];
    

    [self.tableView addSubview:lable];
    lable.font = [UIFont systemFontOfSize:17.0];
    lable.textColor = kTextColor;
    
    UILabel *englishLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:12];
    englishLab.frame = CGRectMake((kScreenWidth-120), self.headerView.yy, 90, 30);
    englishLab.textAlignment = NSTextAlignmentRight;
    englishLab.text = @"查看更多";
    [self.tableView addSubview:englishLab];
    
    UIButton *button = [UIButton buttonWithImageName:@"" selectedImageName:@""];
    [button setImage:kImage(@"积分更多") forState:UIControlStateNormal];
    button.frame  = CGRectMake(kScreenWidth -30, self.headerView.yy, 14, 30);
    [button addTarget:self action:@selector(jumpArtcile) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:button];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((kScreenWidth-40)/2, 250);
    layout.minimumLineSpacing = 10.0; // 竖
    layout.minimumInteritemSpacing = 10.0; // 横
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
   
    
    TLTopCollectionView *topView = [[TLTopCollectionView alloc] initWithFrame:CGRectMake(0, self.tableView.yy+10, kScreenWidth, 550) collectionViewLayout:layout withImage:@[@""]];
    self.topView = topView;
    topView.refreshDelegate = self;
    [self.contentScrollew addSubview:topView];
//    topView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMoreNews)];
    
    UIView *lineView = [[UIView alloc] init];
    self.bottomLine = lineView;
    CGFloat f = CGRectGetMaxY(topView.frame);
    lineView.frame = CGRectMake(0, f, kScreenWidth, 10);
    [self.contentScrollew addSubview:lineView];
    lineView.backgroundColor = kHexColor(@"#F5F5F5");
    
    PlateMineModel *mineModel = [PlateMineModel new];
    mineModel.Description = @"描述描述";
    mineModel.avgChange = @"1000";
    mineModel.bestChange = @"2000";
    mineModel.worstChange = @"500";
    mineModel.name = @"产品1";
    PlateMineModel *mineModel1 = [PlateMineModel new];
    mineModel1.Description = @"描述描述2";
    mineModel1.avgChange = @"10000";
    mineModel1.bestChange = @"20000";
    mineModel1.worstChange = @"5000";
    mineModel1.name = @"产品2";
    PlateMineModel *mineModel2 = [PlateMineModel new];
    mineModel2.Description = @"描述描述";
    mineModel2.avgChange = @"100000";
    mineModel2.bestChange = @"200000";
    mineModel2.worstChange = @"50000";
    mineModel2.name = @"产品3";
    mineModel2.Description = @"描述描述3";
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:mineModel];
    [arr addObject:mineModel1];
    [arr addObject:mineModel2];
    self.topView.models = arr;
    [self.topView reloadData];
    self.contentScrollew.contentSize = CGSizeMake(0, self.topView.yy+100);
}

- (void)loadMoreNews
{
    
    
}
- (HomeHeaderView *)headerView {
    
    if (!_headerView) {
        
        CoinWeakSelf;
        //头部
        _headerView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10 + SCREEN_WIDTH/2+320 - 15-10)];
        
        _headerView.headerBlock = ^(HomeEventsType type, NSInteger index, HomeFindModel *find) {
            [weakSelf headerViewEventsWithType:type index:index model:find];
        };
        _headerView.scrollEnabled = NO;
    }
    return _headerView;
}
- (void)headerViewEventsWithType:(HomeEventsType)type index:(NSInteger)index  model:(HomeFindModel *)model
{
    NSString *url = [[self.bannerRoom objectAtIndex:index] url];
    if (url && url.length > 0) {
        HomeVC *webVC = [[HomeVC alloc] init];
//        webVC.url = url;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}
#pragma mark - Data


- (void)requestBannerList {
    
    TLNetworking *http = [TLNetworking new];
    //    http.showView = self.view;
    http.isUploadToken = NO;
    http.code = @"805806";
    http.parameters[@"location"] = @"app_home";
    
    [http postWithSuccess:^(id responseObject) {
        
        self.bannerRoom = [BannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (self.bannerRoom.count > 0) {
            self.headerView.banners = self.bannerRoom;
            [self reloadFindData];
        }
      
        [self.contentScrollew.mj_header endRefreshing];
        [self.contentScrollew.mj_footer endRefreshing];

        //获取官方钱包总量，已空投量
        //        [self.tableView endRefreshHeader];
        
    } failure:^(NSError *error) {
        [self.contentScrollew.mj_header endRefreshing];
        [self.contentScrollew.mj_footer endRefreshing];
        [self.tableView endRefreshHeader];
        
    }];
    
}
#pragma mark - 获取发现列表数据
- (void)reloadFindData
{
    
    

    TLNetworking *http = [TLNetworking new];
    
    http.code = @"625412";
    http.parameters[@"location"] = @"0";
    http.parameters[@"status"] = @"1"  ;
    
    [http postWithSuccess:^(id responseObject) {
        [self.contentScrollew.mj_header endRefreshing];
        [self.contentScrollew.mj_footer endRefreshing];
        self.tableView.findModels = [HomeFindModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        [self.tableView endRefreshHeader];
        [self.tableView reloadData];
//        if (self.findModels.count != self.tableView.findModels.count) {
//            [TableView AnimationKit showWithAnimationType:6 tableView:self.tableView];
//        }
        
        
        self.findModels = [HomeFindModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
    } failure:^(NSError *error) {
        [self.contentScrollew.mj_header endRefreshing];
        [self.contentScrollew.mj_footer endRefreshing];    }];
    
}

-(void)refreshCollectionView:(BaseCollectionView *)refreshCollectionview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    PlateMineModel *model = self.Plateforms[indexPath.row];
//    PlateDetailVC *detail = [PlateDetailVC new];
//    detail.code = model.code;
//    detail.title = model.name;
//    [self.navigationController pushViewController:detail animated:YES];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [self.searchTf resignFirstResponder];
}

- (void)textDidChange:(UITextField *)sender {
    
    
}

- (void)back {
    
    [self.searchTf resignFirstResponder];
    
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
