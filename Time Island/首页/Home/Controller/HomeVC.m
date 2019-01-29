//
//  HomeVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/2.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "HomeVC.h"
//#import "HomeHeaderView.h"
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
#import "TreeModel.h"
#import "introduceView.h"
#import "HomeHeadCell.h"
#import "MyNoticeDetailsVC.h"
#import "NoticeModel.h"
#import "GoodsDetailsVc.h"
#import "RankingVC.h"
@interface HomeVC ()<RefreshDelegate,RefreshCollectionViewDelegate,UIScrollViewDelegate,UITextFieldDelegate,UISearchBarDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

//@property (nonatomic, strong) HomeHeaderView *headerView;
@property (nonatomic,strong)HomeHeadCell *cell;
@property (nonatomic,strong) NSArray <HomeFindModel *>*findModels;
@property (nonatomic,strong) NSMutableArray <BannerModel *>*bannerRoom;
//@property (nonatomic, strong) HomeTbleView *tableView;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;


@property (nonatomic, assign) NSInteger start;//当前页数

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) TLTextField *searchTf;//当前页数

@property (nonatomic, strong) TitleView *Title;

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic , strong)NSMutableArray *treeArray;
@property (nonatomic,strong) NSMutableArray <TreeModel * > * Models;
@property (nonatomic,strong) NSMutableArray<NoticeModel * > * newsarray;
//存放公告
@property (nonatomic,strong)  NSArray *IntroduceArray;
@property (nonatomic,strong) NSArray * TuiwenArray;
//@property (nonatomic,strong) NSArray * newsarray;

//存放古树商品
@property (nonatomic,strong)  NSMutableArray *treemMuArray;

@property (nonatomic,strong) NSArray * SellTypeArray;
@property (nonatomic,strong) NSArray * ProductStatusArray;

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
        [_collectionView registerClass:[HomeHeadCell class] forCellWithReuseIdentifier:@"HomeHeadCell"];
        
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView1"];
    }
    return _collectionView;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.shadowImage = [UIImage new];

}



//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"首页";
    [self initSearchBar];
    self.treeArray = [NSMutableArray array];
    [self.view addSubview:self.collectionView];
    self.start = 1;
    [self headRefresh];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

#pragma mark------CollectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.Models.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        _cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeHeadCell" forIndexPath:indexPath];
        CoinWeakSelf;
        _cell.headerBlock = ^(HomeEventsType type, NSInteger index, HomeFindModel *find) {
            [weakSelf headerViewEventsWithType:type index:index model:find];
        };
        _cell.clickNoticeBlock = ^{
            //点击公告
            [weakSelf noticeClick];
        };
        _cell.clickBookBlock = ^{
            //点击情感推文
            [weakSelf bookVideoClick];
        };
        _cell.TreeClickBlock = ^{
            TreeListVC *tree = [TreeListVC new];
            [weakSelf.navigationController pushViewController:tree animated:YES];
        };
//        _cell.clicknewsBlock = ^{
//            //点击快报
//            [weakSelf detailsClick];
//
//        };
        _cell.clicknewsBlock = ^(NSInteger index) {
            [weakSelf detailsClick:index];
        };
        _cell.tapintroduce = ^{
            [weakSelf detailIntroduce];
        };
        _cell.clickTagBlock = ^(NSInteger index) {
            [weakSelf clickTagWithIndex:index];
        };
        return _cell;
    }
    
    
    GoodsListCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsListCollCell" forIndexPath:indexPath];
//    cell.model =
    TreeModel * model = self.Models[indexPath.row];
    cell.model = model;

    cell.SellTypeArray = self.SellTypeArray;
    cell.ProductStatusArray = self.ProductStatusArray;
    
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
    if (indexPath.section == 1) {
//        TreeListVC *tree = [TreeListVC new];
        GoodsDetailsVc * tree = [GoodsDetailsVc new];
        tree.TreeModel = self.Models[indexPath.row];
        [self.navigationController pushViewController:tree animated:YES];
    }
    
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
 
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 100 + (SCREEN_WIDTH - 30)/690*200 + 34 + 20 + 64 + SCREEN_WIDTH/750 * 300);
    }
    return CGSizeMake((SCREEN_WIDTH - 1)/2, (SCREEN_WIDTH - 30)/2 + 80);
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 0.001);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
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
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    _collectionView.mj_header = header;
    [_collectionView.mj_header beginRefreshing];
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataFooter)];
    footer.arrowView.hidden = YES;
    footer.stateLabel.hidden = YES;
    _collectionView.mj_footer = footer;
}

-(void)loadNewData
{
    self.treemMuArray = [NSMutableArray array];
    self.start = 1;
    [self requestBannerList];
    [self refresh];
}

-(void)loadNewDataFooter
{
    self.start ++;
    [self refresh];
}




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.searchTf resignFirstResponder];
}





-(void)detailIntroduce{
    introduceView * vc = [introduceView new];
    vc.web = self.IntroduceArray[0][@"content"];
    vc.IntroduceTitle = self.IntroduceArray[0][@"title"];
    vc.time = [self.IntroduceArray[0][@"createDatetime"] convertToDetailDate];
    [self.navigationController pushViewController:vc animated:YES];
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
-(void)detailsClick : (NSInteger)index{
    MyNoticeDetailsVC * vc = [MyNoticeDetailsVC new];
    vc.title = @"公告详情";
    vc.model = self.newsarray[index];
    [self.navigationController pushViewController:vc animated:YES];
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
        RankingVC *vc = [RankingVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)headerViewEventsWithType:(HomeEventsType)type index:(NSInteger)index  model:(HomeFindModel *)model
{
    NSString *url = [[self.bannerRoom objectAtIndex:index] url];
    if (url && url.length > 0) {
        HomeVC *webVC = [[HomeVC alloc] init];
        [self.navigationController pushViewController:webVC animated:YES];
    }
}
#pragma mark - Data


- (void)requestBannerList {
    
    TLNetworking *http = [TLNetworking new];
    //    http.showView = self.view;
    http.isUploadToken = NO;
    http.code = @"630506";
    http.parameters[@"type"] = @"2";
    
    [http postWithSuccess:^(id responseObject) {
        
        self.bannerRoom = [BannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (self.bannerRoom.count > 0) {
            self.cell.banners = self.bannerRoom;

        }
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
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
    } failure:^(NSError *error) {
    }];
    
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
-(void)refresh{
    //古树
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629025";
    http.parameters[@"start"] = @(self.start);
    http.parameters[@"limit"] = @(10);
    http.parameters[@"location"] = @"1";
    http.parameters[@"orderDir"] = @"asc";
    http.parameters[@"orderColumn"]= @"buyable";
    http.parameters[@"statusList"] = @[@"4",@"5",@"6"];
    [http postWithSuccess:^(id responseObject) {

        NSArray *array = responseObject[@"data"][@"list"];
        [self.treemMuArray addObjectsFromArray:array];
        self.Models = [TreeModel mj_objectArrayWithKeyValuesArray:self.treemMuArray];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
    
    
    //专属
    TLNetworking * http3 = [[TLNetworking alloc]init];
    http3.code = @"630036";
    http3.parameters[@"parentKey"] = @"sell_type";
    [http3 postWithSuccess:^(id responseObject) {
        NSDictionary * dic = (NSDictionary * )responseObject;
        self.SellTypeArray = dic[@"data"];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
    }];
    
    
    //状态
    TLNetworking * http4 = [[TLNetworking alloc]init];
    http4.code = @"630036";
    http4.parameters[@"parentKey"] = @"product_status";
    [http4 postWithSuccess:^(id responseObject) {
        NSDictionary * dic = (NSDictionary * )responseObject;
        self.ProductStatusArray = dic[@"data"];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
    }];
    
    
    
    //公告
    TLNetworking * http1 = [[TLNetworking alloc]init];
    http1.code = @"805305";
    http1.parameters[@"start"] = @(1);
    http1.parameters[@"limit"] = @(10);
    http1.parameters[@"status"] = @"1";
    http1.parameters[@"type"] = @"1";
    http1.parameters[@"object"] = @"C";
    [http1 postWithSuccess:^(id responseObject) {
        NSDictionary * dic = (NSDictionary * )responseObject;
        self.IntroduceArray = dic[@"data"][@"list"];
        if (self.IntroduceArray.count > 0) {
            self.cell.introduceLab.text = self.IntroduceArray[0][@"title"];
        }
        
    } failure:^(NSError *error) {
    }];
    
    //快报
    TLNetworking * http2 = [[TLNetworking alloc]init];
    http2.code = @"805305";
    http2.parameters[@"start"] = @(1);
    http2.parameters[@"limit"] = @(10);
    http2.parameters[@"status"] = @"1";
    http2.parameters[@"type"] = @"3";
    http2.parameters[@"object"] = @"C";
    [http2 postWithSuccess:^(id responseObject) {
        NSLog(@"%@",responseObject[@"data"]);
        NSDictionary * dic = (NSDictionary * )responseObject;
        NSArray * array = dic[@"data"][@"list"];
//        self.newsarray = array;
        self.newsarray = [NoticeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        NSLog(@"array = %@",array);
        NSMutableArray *array1 = [NSMutableArray array];
        for (int i = 0; i < array.count; i ++) {
            [array1 addObject:array[i][@"content"] ];
//            NSLog(@"%@",self.headerView.TextLoopArray);

        }
        self.cell.TextLoopArray = array1;
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
    }];
    
    
    //情感推文图片
    TLNetworking * http5 = [[TLNetworking alloc]init];
    http5.code = @"630045";
    http5.parameters[@"start"] = @(1);
    http5.parameters[@"limit"] = @(10);
    http5.parameters[@"type"] =@"SYS_TXT";
    http5.parameters[@"ckey"] = @"ARTICLE_PIC";
    [http5 postWithSuccess:^(id responseObject) {
        NSDictionary * dic = (NSDictionary * )responseObject;
        self.TuiwenArray = dic[@"data"][@"list"];
        if (self.TuiwenArray.count > 0) {
//            self.cell.ImageString
            [self.cell.tuiwenimage sd_setImageWithURL:[NSURL URLWithString:[self.TuiwenArray[0][@"cvalue"] convertImageUrl]]];
        }
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
    }];
}
@end
