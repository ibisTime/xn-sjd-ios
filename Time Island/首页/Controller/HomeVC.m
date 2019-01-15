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
#import "TreeListVC.h"
#import "TitleView.h"
#import "NoticeVC.h"
#import "BookVideoVC.h"
#import "UIBarButtonItem+convience.h"
#import "CalendarCustomVC.h"
@interface HomeVC ()<RefreshDelegate,RefreshCollectionViewDelegate,UIScrollViewDelegate,UITextFieldDelegate,UISearchBarDelegate>
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

@property (nonatomic, strong) TitleView *Title;

@end

@implementation HomeVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self headRefresh];
}

//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"首页";
    [self initSearchBar];
    
    [self initTableView];
}

- (void)initSearchBar {
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationBarHeight)];
    content.backgroundColor = kAppCustomMainColor;
    
    UIButton *calendar = [UIButton buttonWithImageName:@"日历"];
    calendar.frame = CGRectMake(kScreenWidth-60, kStatusBarHeight, 60, 40);
    
    [calendar addTarget:self action:@selector(calendarClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:content];
    UIView *Title = [[UIView alloc] initWithFrame:CGRectMake(10, kStatusBarHeight+10, kScreenWidth-60, 31)];
    Title.backgroundColor = kWhiteColor;
    Title.layer.cornerRadius = 15.5;
    Title.clipsToBounds = YES;
    [content addSubview:Title];
    UISearchBar * searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-60, 31.0f)];
    searchbar.layer.cornerRadius = 15.5;
    searchbar.clipsToBounds = YES;
    searchbar.delegate = self;
    [searchbar setBackgroundColor:kWhiteColor];
//    [searchbar setTintColor:[UIColor lightGrayColor]];
    [searchbar setPlaceholder:@"搜索商品信息"];
    [Title addSubview:searchbar];
    self.searchBar = searchbar;
    [content addSubview:calendar];

    UITextField *searchField = [searchbar valueForKey:@"searchField"];
    
    if (searchField) {
        [[[[searchbar.subviews objectAtIndex : 0 ] subviews ] objectAtIndex : 0 ] removeFromSuperview ];
        
        searchbar.backgroundColor = kWhiteColor;
        
     
        [searchField setBackgroundColor:[UIColor whiteColor]];
        [searchField setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
       
        searchField.layer.cornerRadius = 15.5;//设置圆角具体根据实际情况来设置
        searchField.font =FONT(11);
        
//        searchField.layer.borderWidth = 1;//边框的宽
        
        searchField.clipsToBounds = YES;
        
        
    }
    
    
}

- (void)calendarClick
{
    CalendarCustomVC *calendar = [CalendarCustomVC new];
    [self.navigationController pushViewController:calendar animated:YES];
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];

    TreeListVC *tree = [TreeListVC new];
    [self.navigationController pushViewController:tree animated:YES];
    return NO;

}

- (void)initTableView {
    
    self.contentScrollew = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight-kNavigationBarHeight)];
    [self.view addSubview:self.contentScrollew];
    self.contentScrollew.delegate = self;
    self.contentScrollew.scrollEnabled = YES;
    self.contentScrollew.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
//    self.contentScrollew.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    self.contentScrollew.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    self.tableView = [[HomeTbleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-220) style:UITableViewStyleGrouped];
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
    
    UILabel *lable = [UILabel labelWithTitle:@"古树认养" frame:CGRectMake(15, self.headerView.yy, kScreenWidth -30, 20)];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.textColor = kBlackColor;
    [lable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [self.contentScrollew addSubview:lable];
    
    UILabel *englishLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:12];
    englishLab.userInteractionEnabled = YES;
    englishLab.frame = CGRectMake((kScreenWidth-130), self.headerView.yy, 90, 20);
    englishLab.textAlignment = NSTextAlignmentRight;
    englishLab.text = @"查看更多";
    [self.contentScrollew addSubview:englishLab];
    englishLab.centerY = lable.centerY;
    UITapGestureRecognizer *ta = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpTreeVC)];
    [englishLab addGestureRecognizer:ta];
    UIButton *button = [UIButton buttonWithImageName:@"" selectedImageName:@""];
    [button setImage:kImage(@"积分更多") forState:UIControlStateNormal];
    button.frame  = CGRectMake(kScreenWidth -30, self.headerView.yy, 14, 20);
    [button addTarget:self action:@selector(jumpTreeVC) forControlEvents:UIControlEventTouchUpInside];
    [self.contentScrollew addSubview:button];
    button.centerY = englishLab.centerY;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((kScreenWidth-45)/2, 250);
    layout.minimumLineSpacing = 15.0; // 竖
    layout.minimumInteritemSpacing = 15.0; // 横
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    
   
    
    TLTopCollectionView *topView = [[TLTopCollectionView alloc] initWithFrame:CGRectMake(0, self.headerView.yy+30, kScreenWidth, 550) collectionViewLayout:layout withImage:@[@""]];
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
        _headerView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight(10 + SCREEN_WIDTH/2+320 -110))];
        //点击banner
        _headerView.headerBlock = ^(HomeEventsType type, NSInteger index, HomeFindModel *find) {
            [weakSelf headerViewEventsWithType:type index:index model:find];
        };
        _headerView.clickNoticeBlock = ^{
            //点击公告
            [weakSelf noticeClick];
        };
        _headerView.clickBookBlock = ^{
            //点击情感推文
            [weakSelf bookVideoClick];
        };
        _headerView.clicknewsBlock = ^{
            //点击快报
            [weakSelf noticeClick];

        };
        _headerView.clickTagBlock = ^(NSInteger index) {
            [weakSelf clickTagWithIndex:index];
        };
        _headerView.scrollEnabled = NO;
    }
    return _headerView;
}

- (void)bookVideoClick
{
    BookVideoVC *notice = [BookVideoVC new];
    notice.title = @"情感频道";
    [self.navigationController pushViewController:notice animated:YES];
    
}

- (void)noticeClick
{
    NoticeVC *notice = [NoticeVC new];
    notice.title = @"公告";
    [self.navigationController pushViewController:notice animated:YES];
}
- (void)jumpTreeVC
{
    [self clickTagWithIndex:0];
}

- (void)clickTagWithIndex:(NSInteger)index
{
    if (index == 0) {
        TreeListVC *tree = [TreeListVC new];
        [self.navigationController pushViewController:tree animated:YES];
    }else if (index ==1)
    {
        
    }else{
        
    }
    
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
    TreeListVC *tree = [TreeListVC new];
    [self.navigationController pushViewController:tree animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [self.searchTf resignFirstResponder];
}

- (void)textDidChange:(UITextField *)sender {
    
    TreeListVC *tree = [TreeListVC new];
    [self.navigationController pushViewController:tree animated:YES];
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
