//
//  TreeListVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/9.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TreeListVC.h"
#import "TLTopCollectionView.h"
#import "TLTextField.h"
#import "MMComBoBox.h"
#import "TreeDetailVC.h"
@interface TreeListVC ()<UITextFieldDelegate,RefreshCollectionViewDelegate,UISearchBarDelegate,UIScrollViewDelegate,MMComBoBoxViewDataSource, MMComBoBoxViewDelegate>
@property (nonatomic, strong) TLTopCollectionView *topView;

@property (nonatomic, strong) UIScrollView *contentScrollew;

@property (nonatomic, assign) NSInteger page;//当前页数

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) TLTextField *searchTf;//当前页数

@property (nonatomic, strong) UIView *topLine;

@property (nonatomic, strong) NSMutableArray <PlateMineModel *>*models;//树models

@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) NSArray *mutableArray;
@property (nonatomic, strong) MMComBoBoxView *comBoBoxView;
@property (nonatomic, strong) UIButton *nextPageBtn;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation TreeListVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self headRefresh];
}

-(void)viewDidAppear:(BOOL)animated
{
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    [self initSearchBar];
    [self initCollection];
    [self initComboBox];

}
- (void)initComboBox
{
    self.comBoBoxView = [[MMComBoBoxView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    self.comBoBoxView.dataSource = self;
    self.comBoBoxView.delegate = self;
    [self.view addSubview:self.comBoBoxView];
    [self.comBoBoxView reload];
    
    [self.view addSubview:self.imageView];
    if (self.isMultiSelection == NO)
        [self.view addSubview:self.nextPageBtn];
    
}
- (void)initSearchBar {
    
    UIView *new = [UIView new];
    new.frame = CGRectMake(0, 0, kScreenWidth-60, 31);
    new.layer.cornerRadius = 15.5;
    new.backgroundColor = kWhiteColor;
    new.clipsToBounds = YES;
    UISearchBar * searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth-60, 31)];
//    searchbar.layer.cornerRadius = 15.5;
//    searchbar.clipsToBounds = YES;
    searchbar.delegate = self;
    [searchbar setTintColor:[UIColor lightGrayColor]];
    [searchbar setPlaceholder:@"搜索商品信息"];
    [new addSubview:searchbar];
    self.searchBar = searchbar;
    self.navigationItem.titleView = new;
    UITextField *searchField = [searchbar valueForKey:@"searchField"];
    
    if (searchField) {
        [searchField setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];

        [searchField setBackgroundColor:[UIColor whiteColor]];
        
        searchField.layer.cornerRadius = 15.5;//设置圆角具体根据实际情况来设置
        
//        searchField.layer.borderColor = [UIColor lightGrayColor].CGColor;//边框的颜色
//
//        searchField.layer.borderWidth = 1;//边框的宽
//
        searchField.layer.masksToBounds = YES;
        
    }
    
    
    
}

- (void)initCollection
{
//    self.contentScrollew = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight-kNavigationBarHeight)];
//    [self.view addSubview:self.contentScrollew];
//    self.contentScrollew.delegate = self;
//    self.contentScrollew.scrollEnabled = YES;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((kScreenWidth-45)/2, 250);
    layout.minimumLineSpacing = 15.0; // 竖
    layout.minimumInteritemSpacing = 15.0; // 横
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    
    
    
    TLTopCollectionView *topView = [[TLTopCollectionView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight) collectionViewLayout:layout withImage:@[@""]];
    self.topView = topView;
    topView.refreshDelegate = self;
    self.topView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    self.topView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    [self.view addSubview:topView];
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
    [arr addObject:mineModel];
    [arr addObject:mineModel2];
    [arr addObject:mineModel1];
    [arr addObject:mineModel2];
    [arr addObject:mineModel];
    [arr addObject:mineModel1];

    self.topView.models = arr;
    [self.topView reloadData];
}
-(void)headRefresh
{
    self.page = 1;
    [self.topView.mj_header beginRefreshing];
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
- (void)requestBannerList {
    
    TLNetworking *http = [TLNetworking new];
    //    http.showView = self.view;
    http.isUploadToken = NO;
    http.code = @"805806";
    http.parameters[@"location"] = @"app_home";
    
    [http postWithSuccess:^(id responseObject) {
        
//        self.bannerRoom = [BannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        if (self.bannerRoom.count > 0) {
//            self.headerView.banners = self.bannerRoom;
//            [self reloadFindData];
//        }
        
        [self.topView.mj_header endRefreshing];
        [self.topView.mj_footer endRefreshing];
        
        //        [self.tableView endRefreshHeader];
        
    } failure:^(NSError *error) {
        [self.topView.mj_header endRefreshing];
        [self.topView.mj_footer endRefreshing];
//        [self.tableView endRefreshHeader];
        
    }];
}


-(void)refreshCollectionView:(BaseCollectionView *)refreshCollectionview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TreeDetailVC *detailVC = [TreeDetailVC new];
    detailVC.title = @"古树详情";
    detailVC.mineModel = self.models[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

#pragma mark - MMComBoBoxViewDataSource
- (NSUInteger)numberOfColumnsIncomBoBoxView :(MMComBoBoxView *)comBoBoxView {
    return self.mutableArray.count;
}

- (MMItem *)comBoBoxView:(MMComBoBoxView *)comBoBoxView infomationForColumn:(NSUInteger)column {
    return self.mutableArray[column];
}

#pragma mark - MMComBoBoxViewDelegate
- (void)comBoBoxView:(MMComBoBoxView *)comBoBoxViewd didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSUInteger)index {
    MMItem *rootItem = self.mutableArray[index];
    switch (rootItem.displayType) {
        case MMPopupViewDisplayTypeNormal:
        case MMPopupViewDisplayTypeMultilayer:{
            //拼接选择项
            NSMutableString *title = [NSMutableString string];
            __block NSInteger firstPath;
            [array enumerateObjectsUsingBlock:^(MMSelectedPath * path, NSUInteger idx, BOOL * _Nonnull stop) {
                [title appendString:idx?[NSString stringWithFormat:@";%@",[rootItem findTitleBySelectedPath:path]]:[rootItem findTitleBySelectedPath:path]];
                if (idx == 0) {
                    firstPath = path.firstPath;
                }
            }];
            NSLog(@"当title为%@时，所选字段为 %@",rootItem.title ,title);
            break;}
        case MMPopupViewDisplayTypeFilters:{
            MMCombinationItem * combineItem = (MMCombinationItem *)rootItem;
            [array enumerateObjectsUsingBlock:^(NSMutableArray*  _Nonnull subArray, NSUInteger idx, BOOL * _Nonnull stop) {
                if (combineItem.isHasSwitch && idx == 0) {
                    for (MMSelectedPath *path in subArray) {
                        MMAlternativeItem *alternativeItem = combineItem.alternativeArray[path.firstPath];
                        NSLog(@"当title为: %@ 时，选中状态为: %d",alternativeItem.title,alternativeItem.isSelected);
                    }
                    return;
                }
                
                NSString *title;
                NSMutableString *subtitles = [NSMutableString string];
                for (MMSelectedPath *path in subArray) {
                    MMItem *firstItem = combineItem.childrenNodes[path.firstPath];
                    MMItem *secondItem = combineItem.childrenNodes[path.firstPath].childrenNodes[path.secondPath];
                    title = firstItem.title;
                    [subtitles appendString:[NSString stringWithFormat:@"  %@",secondItem.title]];
                }
                NSLog(@"当title为%@时，所选字段为 %@",title,subtitles);
            }];
            
            break;}
        default:
            break;
    }
}

#pragma mark - Getter
- (NSArray *)mutableArray {
    if (_mutableArray == nil) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        //root 1
        MMSingleItem *rootItem1 = [MMSingleItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:nil];
        
        NSMutableString *title = [NSMutableString string];
        [rootItem1 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:YES titleName:@"全部" subtitleName:[NSString stringWithFormat:@"%ld",random()%10000] code:nil]];
        [title appendString:@"全部"];
        for (int i = 0; i < 20; i ++) {
            MMItem *subItem = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"蛋糕系列%d",i] subtitleName:[NSString stringWithFormat:@"%ld",random()%10000] code:nil];
            [rootItem1 addNode:subItem];
        }
        rootItem1.title = title;
        
        //root 2
        MMSingleItem *rootItem2 = [MMSingleItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"树龄排序"];
        
        if (self.isMultiSelection)
            rootItem2.selectedType = MMPopupViewMultilSeMultiSelection;
        
        [rootItem2  addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:YES titleName:@"树龄排序" subtitleName:nil code:nil]];
        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"100年"]]];
        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"200年"]]];
        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"300年"]]];
        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"500年"]]];
        
        
        //root 3
        MMMultiItem *rootItem3 = [MMMultiItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"树级"];
        
        rootItem3.displayType = MMPopupViewDisplayTypeMultilayer;
        NSArray *name = @[@"全部",@"一级",@"二级",@"三级"];
        NSArray *nameSub = @[@"全部",@"500年以上",@"200年以上",@"100年以上"];

        for (int i = 0; i < 4; i++){
            MMItem *item3_A = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"%@",name[i]] subtitleName:nameSub[i]];
            item3_A.isSelected = (i == 0);
            [rootItem3 addNode:item3_A];
            MMItem *item3_B = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"%@",nameSub[i]] subtitleName:nil];
            item3_B.isSelected = (i == 0);
            [item3_A addNode:item3_B];
//            for (int j = 0; j < 2; j ++) {
//                MMItem *item3_B = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"%@",nameSub[i]] subtitleName:nil];
//                item3_B.isSelected = (i == 0 && j == 0);
//                [item3_A addNode:item3_B];
//            }
        }
        
        //root 4
        MMCombinationItem *rootItem4 = [MMCombinationItem itemWithItemType:MMPopupViewDisplayTypeUnselected isSelected:NO titleName:@"筛选" subtitleName:nil];
        rootItem4.displayType = MMPopupViewDisplayTypeFilters;
        
        if (self.isMultiSelection)
            rootItem4.selectedType = MMPopupViewMultilSeMultiSelection;
        
        NSArray *arr = @[@{@"认养状态":@[@"可认养",@"不可认养"]},
                         @{@"认养模式":@[@"专属",@"定向",@"捐赠",@"集体"]},
                         @{@"树种":@[@"樟树",@"柏树"]} ];
        
        for (NSDictionary *itemDic in arr) {
            MMItem *item4_A = [MMItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:[itemDic.allKeys lastObject]];
            [rootItem4 addNode:item4_A];
            for (int i = 0; i <  [[itemDic.allValues lastObject] count]; i++) {
                NSString *title = [itemDic.allValues lastObject][i];
                MMItem *item4_B = [MMItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:title];
                if (i == 0) {
                    item4_B.isSelected = YES;
                }
                [item4_A addNode:item4_B];
            }
        }
        
        //root 5
        MMMultiItem *rootItem5 = [MMMultiItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"所在地区"];
        
        rootItem5.displayType = MMPopupViewDisplayTypeMultilayer;
        rootItem5.numberOflayers = MMPopupViewThreelayers;
        for (int i = 0; i < MAX(5, random()%30); i++){
            MMItem *item5_A = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"市%d",i] subtitleName:nil];
            item5_A.isSelected = (i == 0);
            [rootItem5 addNode:item5_A];
            
            for (int j = 0; j < MAX(5, random()%30) ; j ++) {
                MMItem *item5_B = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"市%d县%d",i,j] subtitleName:[NSString stringWithFormat:@"%ld",random()%10000]];
                item5_B.isSelected = (i == 0 && j == 0);
                [item5_A addNode:item5_B];
                
                for (int k = 0; k < MAX(5, random()%30); k++) {
                    MMItem *item5_C = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"市%d县%d镇%d",i,j,k] subtitleName:[NSString stringWithFormat:@"%ld",random()%10000]];
                    item5_C.isSelected = (i == 0 && j == 0 && k == 0);
                    [item5_B addNode:item5_C];
                }
            }
        }
        
        
        //      [mutableArray addObject:rootItem1];
        [mutableArray addObject:rootItem5];
        [mutableArray addObject:rootItem3];
        [mutableArray addObject:rootItem2];
        [mutableArray addObject:rootItem4];


        _mutableArray  = [mutableArray copy];
    }
    return _mutableArray;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.comBoBoxView.bottom, self.view.width, self.view.height - 64)];
        _imageView.image = [UIImage imageNamed:@"7.jpg"];
    }
    return _imageView;
}

- (UIButton *)nextPageBtn {
    if (_nextPageBtn == nil) {
        _nextPageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextPageBtn.frame = CGRectMake(self.view.width - 80, kScreenHeigth - 60, 100, 30);
        [_nextPageBtn setTitle:@"多选" forState:UIControlStateNormal];
        [_nextPageBtn addTarget:self action:@selector(respondsToButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _nextPageBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
