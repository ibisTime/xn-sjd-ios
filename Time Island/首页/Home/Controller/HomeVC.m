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
#import "MyNoticeVC.h"
#import "BookVideoVC.h"
#import "UIBarButtonItem+convience.h"
#import "CalendarCustomVC.h"
#import "MallTabBarController.h"
#import "MallTabbar.h"
#import "GoodsListCollCell.h"
@interface HomeVC ()<RefreshDelegate,RefreshCollectionViewDelegate,UIScrollViewDelegate,UITextFieldDelegate,UISearchBarDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) HomeHeaderView *headerView;
@property (nonatomic,strong) NSArray <HomeFindModel *>*findModels;
@property (nonatomic,strong) NSMutableArray <BannerModel *>*bannerRoom;
//@property (nonatomic, strong) HomeTbleView *tableView;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;


@property (nonatomic, assign) NSInteger page;//当前页数

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) TLTextField *searchTf;//当前页数

@property (nonatomic, strong) TitleView *Title;

@property (nonatomic,strong)UICollectionView *collectionView;


@end

@implementation HomeVC



-(UICollectionView *)collectionView{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *flowayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - kTabBarHeight) collectionViewLayout:flowayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = kWhiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[GoodsListCollCell class] forCellWithReuseIdentifier:@"GoodsListCollCell"];
//        [_collectionView registerClass:[ClassificationCollCell class] forCellWithReuseIdentifier:@"ClassificationCollCell"];
//        [_collectionView registerClass:[TheGameCollCell class] forCellWithReuseIdentifier:@"TheGameCollCell"];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView1"];
    }
    return _collectionView;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
//    NSMutableArray *array = [NSMutableArray array];
//    for (int i = 0;  i < 5; i ++) {
//        [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@",@"邮政银行"]]];
//    }
//
//    SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
//    view.isSingle = YES;
//    view.array = array;
//    view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
//        [LEEAlert closeWithCompletionBlock:^{
//            SelectedListModel *model = array[0];
//            NSLog(@"选中第%ld行" , model.sid);
//
//
//        }];
//    };
//    [LEEAlert alert].config
//    .LeeTitle(@"选择银行卡")
//    .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
//    .LeeCustomView(view)
//    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
//    .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
//    .LeeClickBackgroundClose(YES)
//    .LeeShow();
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
    
    [self.view addSubview:self.collectionView];
    
//    [self initTableView];
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.itemSize = CGSizeMake((kScreenWidth-45)/2, 250);
//    layout.minimumLineSpacing = 15.0; // 竖
//    layout.minimumInteritemSpacing = 15.0; // 横
//    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
//    TLTopCollectionView *topView = [[TLTopCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SCREEN_HEIGHT - kNavigationBarHeight) collectionViewLayout:layout withImage:@[@""]];
//    self.topView = topView;
//    topView.refreshDelegate = self;
//
//    [self.view addSubview:topView];
//    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,
}






-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark------CollectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GoodsListCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsListCollCell" forIndexPath:indexPath];

    if (indexPath.row % 2 == 0) {
        cell.backView.frame = CGRectMake(12, 0, (SCREEN_WIDTH - 30)/2, (SCREEN_WIDTH - 30)/2 + 80);
    }else
    {
        cell.backView.frame = CGRectMake(3, 0, (SCREEN_WIDTH - 30)/2, (SCREEN_WIDTH - 30)/2 + 80);
    }
    
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TreeListVC *tree = [TreeListVC new];
    [self.navigationController pushViewController:tree animated:YES];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0.01;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((SCREEN_WIDTH - 1)/2, (SCREEN_WIDTH - 30)/2 + 80);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 100 + (SCREEN_WIDTH - 30)/690*200 + 34 + 20 + 64 + SCREEN_WIDTH/750 * 300);
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    [headerView addSubview:self.headerView];

    return headerView;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 0.001);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.1, 0.1, 0.1, 0.1);
}


- (void)initSearchBar {
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationBarHeight)];
    content.backgroundColor = kAppCustomMainColor;
    
    UIButton *calendar = [UIButton buttonWithImageName:@"日历"];
    calendar.frame = CGRectMake(kScreenWidth-60, kStatusBarHeight, 60, 44);
    [calendar addTarget:self action:@selector(calendarClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:content];
    
    UIView *Title = [[UIView alloc] initWithFrame:CGRectMake(15, kStatusBarHeight+13/2, kScreenWidth-70, 31)];
    Title.backgroundColor = kWhiteColor;
    Title.layer.cornerRadius = 15.5;
    Title.clipsToBounds = YES;
    [content addSubview:Title];
    
    UISearchBar * searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 85, 31.0)];
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
        searchField.layer.cornerRadius = 15.5;
        searchField.font =FONT(11);
        searchField.clipsToBounds = YES;
    }
}

- (void)calendarClick{
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


-(void)headRefresh
{
    self.page = 1;
//    [self.contentScrollew.mj_header beginRefreshing];
    [self requestBannerList];

    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.searchTf resignFirstResponder];
}

-(void)footerRefresh
{
    self.page ++;
//    [self.contentScrollew.mj_footer beginRefreshing];
    [self requestBannerList];

}


- (void)loadMoreNews
{
    
    
}

- (HomeHeaderView *)headerView {
    
    if (!_headerView) {
        
        CoinWeakSelf;
        //头部
        _headerView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100 + (SCREEN_WIDTH - 30)/690*200 + 34 + 20 + 64 + SCREEN_WIDTH/750 * 300)];
//        _headerView.backgroundColor = [UIColor redColor];
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
    MyNoticeVC *notice = [MyNoticeVC new];
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
        MallTabbar *tabbar = [MallTabbar new];
        [self presentViewController:tabbar animated:YES completion:nil];
        
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
      
//        [self.contentScrollew.mj_header endRefreshing];
//        [self.contentScrollew.mj_footer endRefreshing];

        //获取官方钱包总量，已空投量
        //        [self.tableView endRefreshHeader];
        
    } failure:^(NSError *error) {
//        [self.contentScrollew.mj_header endRefreshing];
//        [self.contentScrollew.mj_footer endRefreshing];
//        [self.tableView endRefreshHeader];
        
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
//        [self.contentScrollew.mj_header endRefreshing];
//        [self.contentScrollew.mj_footer endRefreshing];
//        self.tableView.findModels = [HomeFindModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        [self.tableView endRefreshHeader];
//        [self.tableView reloadData];
//        if (self.findModels.count != self.tableView.findModels.count) {
//            [TableView AnimationKit showWithAnimationType:6 tableView:self.tableView];
//        }
        
        
//        self.findModels = [HomeFindModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
    } failure:^(NSError *error) {
//        [self.contentScrollew.mj_header endRefreshing];
//        [self.contentScrollew.mj_footer endRefreshing];
        
    }];
    
}

//-(void)refreshCollectionView:(BaseCollectionView *)refreshCollectionview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    TreeListVC *tree = [TreeListVC new];
//    [self.navigationController pushViewController:tree animated:YES];
//}

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
