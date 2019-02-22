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
#import "GoodsListCollCell.h"
#import "GoodsDetailsVc.h"
#import "TreeModel.h"
@interface TreeListVC ()<UITextFieldDelegate,UISearchBarDelegate,UIScrollViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,MMComBoBoxViewDelegate,MMComBoBoxViewDataSource>
//@property (nonatomic, strong) TLTopCollectionView *topView;



@property (nonatomic , strong)NSMutableArray <TreeModel *>*models;
@property (nonatomic,strong)  NSMutableArray *treemMuArray;

@property (nonatomic , strong)NSMutableArray *treeArray;

@property (nonatomic, strong) UIScrollView *contentScrollew;

@property (nonatomic, assign) NSInteger start;//当前页数

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) TLTextField *searchTf;//当前页数

@property (nonatomic, strong) UIView *topLine;

//@property (nonatomic, strong) NSMutableArray <PlateMineModel *>*models;//树models

@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) NSArray *mutableArray;
@property (nonatomic, strong) MMComBoBoxView *comBoBoxView;
@property (nonatomic, strong) UIButton *nextPageBtn;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong) NSArray * SellTypeArray;
@property (nonatomic,strong) NSArray * ProductStatusArray;
//选择参数
@property (nonatomic,strong) NSString * area;
@property (nonatomic,strong) NSString * treeLevel;
@property (nonatomic,strong) NSString * adoptStatus;
@property (nonatomic,strong) NSString * variety;
@end

@implementation TreeListVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//    [self headRefresh];
}

//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self.comBoBoxView dimissPopView];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    self.treeArray = [NSMutableArray array];
    [self initSearchBar];
    [self initComboBox];
    [self.view addSubview:self.collectionView];
    [self headRefresh];
}


-(UICollectionView *)collectionView{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *flowayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 40) collectionViewLayout:flowayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = kWhiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[GoodsListCollCell class] forCellWithReuseIdentifier:@"GoodsListCollCell"];
    }
    return _collectionView;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark------CollectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.models.count;
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
    cell.model = self.models[indexPath.row];
    cell.SellTypeArray = self.SellTypeArray;
    cell.ProductStatusArray = self.ProductStatusArray;
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailsVc *detailVC = [GoodsDetailsVc new];
//    detailVC.title = @"古树详情";
//    detailVC.mineModel = self.models[indexPath.row];
    detailVC.treemodel = self.models[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
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
    return CGSizeMake(SCREEN_WIDTH, 0.001);
}

//- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
//    [headerView addSubview:self.headerView];
    
//    return nil;
//}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 0.001);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.1, 0.1, 0.1, 0.1);
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
    searchbar.delegate = self;
    [searchbar setTintColor:[UIColor lightGrayColor]];
    [searchbar setPlaceholder:@"搜索商品信息"];
    [new addSubview:searchbar];
    
    self.searchBar = searchbar;
    self.navigationItem.titleView = new;
    UITextField *searchField = [searchbar valueForKey:@"searchField"];
    
    if (searchField) {
        [searchField setValue:FONT(11) forKeyPath:@"_placeholderLabel.font"];
        searchField.font= FONT(11);
        [searchField setBackgroundColor:[UIColor whiteColor]];
        
        searchField.layer.cornerRadius = 15.5;//设置圆角具体根据实际情况来设置
        searchField.layer.masksToBounds = YES;
        
    }
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629025";
    http.parameters[@"start"] = @(self.start);
    http.parameters[@"limit"] = @(10);
    http.parameters[@"type"]= @(1);
    http.parameters[@"name"] = self.searchBar.text;
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"statusList"] = @[@"4",@"5",@"6"];
    [http postWithSuccess:^(id responseObject) {
//        NSArray *array = responseObject[@"data"][@"list"];
//        [self.treemMuArray addObjectsFromArray:array];
//        self.treeArray = array;
//        self.models = [TreeModel mj_objectArrayWithKeyValuesArray:self.treemMuArray];
        [self.models removeAllObjects];
        self.models = [TreeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"%s",__func__);
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    if ([searchBar.text isEqualToString:@""]) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"629025";
        http.parameters[@"start"] = @(self.start);
        http.parameters[@"limit"] = @(10);
        http.parameters[@"type"]= @(1);
        http.parameters[@"name"] = searchText;
        http.parameters[@"userId"] = [TLUser user].userId;
        http.parameters[@"statusList"] = @[@"4",@"5",@"6"];
        [http postWithSuccess:^(id responseObject) {
                    NSArray *array = responseObject[@"data"][@"list"];
                    [self.treemMuArray addObjectsFromArray:array];
            //        self.treeArray = array;
            //        self.models = [TreeModel mj_objectArrayWithKeyValuesArray:self.treemMuArray];
            [self.models removeAllObjects];
            self.models = [TreeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
        } failure:^(NSError *error) {
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
        }];
//    }
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


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.searchTf resignFirstResponder];
}

-(void)loadNewData
{
    self.start = 1;
    self.treemMuArray = [NSMutableArray array];
    [self refresh];
}

-(void)loadNewDataFooter
{
    self.start ++;
    [self refresh];
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
    NSLog(@"self.mutableArray[index] = %@",self.mutableArray[index]);
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
            switch (index) {
                case 0:
                    self.area = title;
                    [self refresh];
                    break;
                case 1:
                    self.treeLevel = title;
                    [self refresh];
                    break;
                default:
                    break;
            }
//            [self.collectionView reloadData];
            
            break;}
//        case MMPopupViewDisplayTypeFilters:{
//            MMCombinationItem * combineItem = (MMCombinationItem *)rootItem;
//            [array enumerateObjectsUsingBlock:^(NSMutableArray*  _Nonnull subArray, NSUInteger idx, BOOL * _Nonnull stop) {
//                if (combineItem.isHasSwitch && idx == 0) {
//                    for (MMSelectedPath *path in subArray) {
//                        MMAlternativeItem *alternativeItem = combineItem.alternativeArray[path.firstPath];
//                        NSLog(@"当title为: %@ 时，选中状态为: %d",alternativeItem.title,alternativeItem.isSelected);
//                    }
//                    return;
//                }
//                    NSString *title;
//                    NSMutableString *subtitles = [NSMutableString string];
//                    //                NSMutableString *varietys = [NSMutableString string];
//                    for (MMSelectedPath *path in subArray) {
//                        MMItem *firstItem = combineItem.childrenNodes[path.firstPath];
//                        MMItem *secondItem = combineItem.childrenNodes[path.firstPath].childrenNodes[path.secondPath];
//                        title = firstItem.title;
//                        [subtitles appendString:[NSString stringWithFormat:@"%@",secondItem.title]];
//                        //                    [varietys appendString:[NSString stringWithFormat:@"%@",secondItem.title]];
//                    }
//                    NSLog(@"当title为%@时，所选字段为 %@",title,subtitles);
//                    if (subtitles) {
//                        if ([subtitles isEqualToString:@"不可认养"]) {
//                            self.adoptStatus = @"0";
//                        }
//                        else if ([subtitles isEqualToString:@"可认养"]){
//                            self.adoptStatus = @"1";
//                        }
//                        else if ([subtitles isEqualToString:@"柏树"]){
//                            self.variety = @"柏树";
//                        }
//                        else if ([subtitles isEqualToString:@"樟树"]){
//                            self.variety = @"樟树";
//                        }
//
//                        [self refresh];
//                    }
//
//
//
//            }];
//
//            break;}
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
        NSArray *nameSub = @[@"全部",@"一级",@"二级",@"三级"];

        for (int i = 0; i < 4; i++){
            MMItem *item3_A = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"%@",name[i]] subtitleName:nameSub[i]];
            item3_A.isSelected = (i == 0);
            [rootItem3 addNode:item3_A];
            MMItem *item3_B = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"%@",nameSub[i]] subtitleName:nil];
            item3_B.isSelected = (i == 0);
            [item3_A addNode:item3_B];
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
                    item4_B.isSelected = NO;
                }
                [item4_A addNode:item4_B];
            }
        }
        
        MMMultiItem *rootItem5 = [MMMultiItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"所在地区"];
        rootItem5.numberOflayers = 1;
        rootItem5.displayType = MMPopupViewDisplayTypeMultilayer;
        rootItem5.numberOflayers = MMPopupViewThreelayers;
            NSArray *array  =[self JsonObject:@"SelectAddress.json"];
            NSLog(@"array = %d",(int)array.count);
            for (int count = 0; count < array.count; count++) {
                MMItem *item5_A = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:array[count][@"name"] subtitleName:nil];
//                item5_A.isSelected = (i == 0);
                [rootItem5 addNode:item5_A];
                
                NSArray *cityList = array[count][@"cityList"];
                for (int i = 0; i < cityList.count; i ++) {
                    MMItem * item5_B = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:cityList[i][@"name"] subtitleName:nil];
                    //                    item5_B.isSelected = (i == 0 && j == 0);
                    [item5_A addNode:item5_B];
                    
                    NSArray *areaList = cityList[i][@"areaList"];
                    for (int j = 0; j < areaList.count; j ++) {
                        MMItem *item5_C = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:areaList[j][@"name"] subtitleName:nil];
                        //                        item5_C.isSelected = (i == 0 && j == 0 && k == 0);
                        [item5_B addNode:item5_C];
                    }
                    
                }
        }
        
        [mutableArray addObject:rootItem5];
        [mutableArray addObject:rootItem3];
        [mutableArray addObject:rootItem2];
        [mutableArray addObject:rootItem4];


        _mutableArray  = [mutableArray copy];
    }
    return _mutableArray;
}




- (id)JsonObject:(NSString *)jsonStr{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:jsonStr ofType:nil];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:jsonPath];
    NSError *error;
    id JsonObject= [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    return JsonObject;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refresh{
    TLNetworking * http = [[TLNetworking alloc]init];
//    TLPageDataHelper * http = [[TLPageDataHelper alloc]init];
    http.code = @"629025";
    http.parameters[@"start"] = @(self.start);
    http.parameters[@"limit"] = @(10);
    http.parameters[@"name"]= @"";
    http.parameters[@"statusList"] = @[@"4",@"5",@"6"];
    if (self.area) {
        if ([self.area isEqualToString:@"全国"]) {
            http.parameters[@"area"] = @"";
        }
        else{
            http.parameters[@"area"] = self.area;
        }
    }
    if (self.treeLevel) {
        if ([self.area isEqualToString:@"全部"]) {
            http.parameters[@"treeLevel"] = @"";
        }
        else{
        http.parameters[@"treeLevel"] = self.treeLevel;
        }
    }
    if (self.adoptStatus) {
        http.parameters[@"adoptStatus"] = self.adoptStatus;
    }
    if (self.variety) {
        http.parameters[@"variety"] = self.variety;
    }
//    http.parameters[@"variety"] = @"樟树";
    [http postWithSuccess:^(id responseObject) {

//        NSArray *array = responseObject[@"data"][@"list"];
//        [self.treemMuArray addObjectsFromArray:array];
//        self.models = [TreeModel mj_objectArrayWithKeyValuesArray:self.treemMuArray];
        NSArray *array = responseObject[@"data"][@"list"];
        [self.treemMuArray addObjectsFromArray:array];
        
        [self.models removeAllObjects];
        self.models = [TreeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
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
}
@end
