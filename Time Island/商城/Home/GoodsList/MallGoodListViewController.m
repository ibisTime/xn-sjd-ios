//
//  MallGoodListViewController.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/21.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallGoodListViewController.h"
#import "MMComBoBox.h"
#import "MallListCollectionViewCell.h"
#import "MallGoodDetailVC.h"
#import "MallGoodsModel.h"
#import <MJRefresh.h>


#import "YiceSlidelipPickerMenu.h"
#import "YiceSlidelipPickPch.h"
#import "YiceSlidelipPickCommonModel.h"
@interface MallGoodListViewController ()<UISearchBarDelegate,MMComBoBoxViewDataSource,MMComBoBoxViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,YiceSlidelipPickerMenuDelegate,YiceSlidelipPickerMenuDataSource>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) NSArray *mutableArray;
@property (nonatomic,strong) NSMutableArray * GoodsArray;
@property (nonatomic, strong) MMComBoBoxView *comBoBoxView;
@property (nonatomic, strong) UIButton *nextPageBtn;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray <MallGoodsModel *>*TreeModels;
//@property (nonatomic,strong) NSMutableArray <MallGoodsModel *>*models;
@property (nonatomic, assign) NSInteger start;
@property (nonatomic,strong) NSMutableArray * OriginalPlace;
@property (nonatomic,strong) NSMutableArray * DeliverPlace;

@property (nonatomic,strong) NSString * OriPlace;
@property (nonatomic,strong) NSString * DelPlace;

@property (nonatomic, strong) YiceSlidelipPickerMenu *pickMenu;
@property (nonatomic, strong) NSArray *mainKindArray;
@property (nonatomic, strong) NSArray *subKindArray;
@property (nonatomic,strong) NSString * orderColumn;
@property (nonatomic,strong) NSString * orderDir;
@end

@implementation MallGoodListViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.comBoBoxView dimissPopView];
}
-(UICollectionView *)collectionView{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *flowayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.comBoBoxView.yy, SCREEN_WIDTH, SCREEN_HEIGHT-self.comBoBoxView.yy-kNavigationBarHeight) collectionViewLayout:flowayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = kWhiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        [_collectionView registerClass:[MallListCollectionViewCell class] forCellWithReuseIdentifier:@"MallListCollectionViewCell"];
    }
    return _collectionView;
}
-(YiceSlidelipPickerMenu *)pickMenu
{
    if (_pickMenu==nil) {
        _pickMenu=[[YiceSlidelipPickerMenu alloc] init];
        _pickMenu.delegate = self;
        _pickMenu.datasource = self;
    }
    return _pickMenu;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [UIBarButtonItem addLeftItemWithImageName:@"返回白色" frame:CGRectMake(-10, 0, 44, 40) vc:self action:@selector(backButtonClick)];
    [self initSearchBar];
    [self initComboBox];
    [self.view addSubview:self.collectionView];
    [self headRefresh];
    [self getDeliverPlace];
    [self getOriginalPlace];
    UIButton *screeningBtn = [UIButton buttonWithTitle:@"全部" titleColor:kTextColor backgroundColor:kClearColor titleFont:12];
    screeningBtn.frame = CGRectMake(0, self.searchBar.yy+10, SCREEN_WIDTH / 4, 40);

    [screeningBtn addTarget:self action:@selector(loadmore) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:screeningBtn];
    
    
    UIButton *selectBtn = [UIButton buttonWithTitle:@"筛选" titleColor:kTextColor backgroundColor:kClearColor titleFont:12];
    selectBtn.frame = CGRectMake(SCREEN_WIDTH * 3 / 4, self.searchBar.yy+10, SCREEN_WIDTH / 4, 40);
        [screeningBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:5 imagePositionBlock:^(UIButton *button) {
            [selectBtn setImage:kImage(@"下拉") forState:(UIControlStateNormal)];
        }];
    [selectBtn addTarget:self action:@selector(screeningBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:selectBtn];
}
-(void)screeningBtnClick:(UIButton *)sender
{
    self.pickMenu.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, self.searchBar.yy - 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[[UIApplication sharedApplication].delegate window] addSubview:self.pickMenu];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.pickMenu cache:YES];
    [UIView setAnimationDuration:0.3];
    self.pickMenu.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [UIView commitAnimations];
    [self getType];
}
#pragma mark ---- pickdelegate
- (void)menu:(YiceSlidelipPickerMenu *)menu didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //选中
    NSMutableArray <YiceSlidelipPickCommonModel *> *arrayModel = self.subKindArray[indexPath.section];
    for (YiceSlidelipPickCommonModel *model in arrayModel) {
        model.isSelected = @"";
    }
    YiceSlidelipPickCommonModel *model = arrayModel[indexPath.row];
    model.isSelected = @"YES";
    
}

- (void)menu:(YiceSlidelipPickerMenu *)menu didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中
    YiceSlidelipPickCommonModel *model = self.subKindArray[indexPath.section][indexPath.row];
    model.isSelected = @"";
}

- (void)reloadDataWithMenu:(YiceSlidelipPickerMenu *)menu{
    //重置
    for (NSMutableArray <YiceSlidelipPickCommonModel*> *array in self.subKindArray) {
        for (YiceSlidelipPickCommonModel *model in array) {
            model.isSelected = @"";
            self.DelPlace = nil;
            self.OriPlace = nil;
        }
    }
//    [self headRefresh];
}

- (void)menu:(YiceSlidelipPickerMenu *)menu submmitSelectedIndexPaths:(NSArray<NSIndexPath *> *)indexpaths{
    //同步数据
    if (indexpaths.count == 0) {
    }else
    {
        NSIndexPath *inde;
        for (int i = 0; i < indexpaths.count; i ++) {
            inde = indexpaths[i];
            if (inde.section == 0) {
                YiceSlidelipPickCommonModel *model = [YiceSlidelipPickCommonModel new];
                model = self.subKindArray[inde.section][inde.row];
                self.DelPlace = model.text;
            }
            if (inde.section == 1) {
                YiceSlidelipPickCommonModel *model = [YiceSlidelipPickCommonModel new];
                model = self.subKindArray[inde.section][inde.row];
                
                self.OriPlace = model.text;
            }
        }
    }

    [self headRefresh];
}


-(YiceSlidelipPickCommonModel*)creatPcikMenuItemModelWithString:(NSString*)str{
    
    YiceSlidelipPickCommonModel*model = [YiceSlidelipPickCommonModel new];
    model.isSelected = @"";
    model.text = str;
    return model;
}

#pragma mark ---- pickDatasource
- (NSInteger)menu:(YiceSlidelipPickerMenu *)menu numberOfRowsInSection:(NSInteger)section{
    return ((NSArray*)(self.subKindArray[section])).count;
}


- (NSInteger)numberOfSectionsInMenu:(YiceSlidelipPickerMenu *)menu{
    return self.mainKindArray.count;
}


- (NSString *)menu:(YiceSlidelipPickerMenu *)menu titleForSection:(NSInteger)section{
    return self.mainKindArray[section];
}

- (YiceSlidelipPickCommonModel *)menu:(YiceSlidelipPickerMenu *)menu titleForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * arraySectionData = self.subKindArray[indexPath.section];
    return arraySectionData[indexPath.row];
}






-(void)headRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.automaticallyChangeAlpha = YES;
//    header.lastUpdatedTimeLabel.hidden = YES;
//    header.stateLabel.hidden = YES;
    _collectionView.mj_header = header;
    [_collectionView.mj_header beginRefreshing];
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataFooter)];
//    footer.arrowView.hidden = YES;
//    footer.stateLabel.hidden = YES;
    _collectionView.mj_footer = footer;
}

-(void)loadNewData
{
    self.start = 1;
//    self.TreeModels = [NSMutableArray array];
    self.GoodsArray = [NSMutableArray array];
    [self loadGoodList];
}

-(void)loadNewDataFooter
{
    self.start ++;
    [self loadGoodList];
}


- (void)initComboBox
{
    self.comBoBoxView = [[MMComBoBoxView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 4, self.searchBar.yy+10, SCREEN_WIDTH * 2 / 4, 40)];
    self.comBoBoxView.dataSource = self;
    self.comBoBoxView.delegate = self;
    [self.view addSubview:self.comBoBoxView];
    [self.comBoBoxView reload];
    if (self.isMultiSelection == NO)
        [self.view addSubview:self.nextPageBtn];
    
}
- (void)initSearchBar {
    UISearchBar * searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(14.5, 12, kScreenWidth-30, 31.0f)];
    searchbar.layer.cornerRadius = 15.5;
    searchbar.clipsToBounds = YES;
    searchbar.delegate = self;
    //    [searchbar setAccessibilityElementsHidden:YES];
    searchbar.alpha = 0.89;
    [searchbar setBackgroundColor:RGB(236, 236, 236)];
    [searchbar setTintColor:[UIColor lightGrayColor]];
    [searchbar setPlaceholder:@"搜索商品"];
    [self.view addSubview:searchbar];
    self.searchBar = searchbar;
    if ([self.state isEqualToString:@"search"]) {
        self.searchBar.text = self.SearchContent;
    }
    UITextField *searchField = [searchbar valueForKey:@"searchField"];
    
    if (searchField) {
        [[[[searchbar.subviews objectAtIndex : 0 ] subviews ] objectAtIndex : 0 ] removeFromSuperview ];
        
        searchbar.backgroundColor = RGB(236, 236, 236);
        
        
        [searchField setBackgroundColor:RGB(236, 236, 236)];
        [searchField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        
        searchField.layer.cornerRadius = 15.5;//设置圆角具体根据实际情况来设置
        searchField.font =FONT(14);
        
        //        searchField.clipsToBounds = YES;
    }
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
            switch (index) {
                case 0:{
                    if ([title isEqualToString:@"从高到低"]) {
                        self.orderColumn = @"min_price";
                        self.orderDir = @"desc";
                    }
                    else{
                        self.orderColumn = @"min_price";
                        self.orderDir = @"asc";
                    }
                }
                    break;
                case 1:{
                    if ([title isEqualToString:@"从大到小"]) {
                        self.orderColumn = @"month_sell_count";
                        self.orderDir = @"desc";
                    }
                    else{
                        self.orderColumn = @"month_sell_count";
                        self.orderDir = @"asc";
                    }
                }
                    break;
                default:
                    break;
            }
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
    [self headRefresh];
}



#pragma mark - Getter
- (NSArray *)mutableArray {
    if (_mutableArray == nil) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        //root 2
        
        MMSingleItem *rootItem2 = [MMSingleItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"销量"];
        
        if (self.isMultiSelection)
            rootItem2.selectedType = MMPopupViewMultilSeMultiSelection;
        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:YES titleName:[NSString stringWithFormat:@"从大到小"] subtitleName:nil code:nil]];
        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"从小到大"]]];

        
        
        //root 3
//        MMSingleItem *rootItem3 = [MMSingleItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"价格"];
//
//        rootItem3.selectedType = MMPopupViewMultilSeMultiSelection;
//
//        [rootItem3 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"从高到低"]]];
//        [rootItem3 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"从低到高"]]];
        
        MMSingleItem *rootItem3 = [MMSingleItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"价格"];
        
        if (self.isMultiSelection)
            rootItem3.selectedType = MMPopupViewMultilSeMultiSelection;
        
        [rootItem3 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:YES titleName:[NSString stringWithFormat:@"从高到低"] subtitleName:nil code:nil]];
        [rootItem3 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"从低到高"]]];
      
        
        [mutableArray addObject:rootItem3];
        [mutableArray addObject:rootItem2];
        
        _mutableArray  = [mutableArray copy];
    }
    return _mutableArray;
}





#pragma mark------CollectionView的代理方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.TreeModels.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MallListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MallListCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.TreeModels[indexPath.row];
    [cell.shopping addTarget:self action:@selector(shoppButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)shoppButtonClick:(UIButton *)sender
{
    CGPoint point = sender.center;
    point = [self.collectionView convertPoint:point fromView:sender.superview];
    NSIndexPath* indexpath = [self.collectionView indexPathForItemAtPoint:point];
    MallGoodsModel *model = self.TreeModels[indexpath.row];
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629710";
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"commodityCode"] = model.code;
    http.parameters[@"commodityName"] = model.name;
    http.parameters[@"specsId"] = model.specsList[0][@"id"];
    http.parameters[@"specsName"] = model.specsList[0][@"name"];
    http.parameters[@"quantity"] = @"1";
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"加入购物车成功"];
    } failure:^(NSError *error) {
        
    }];
    NSLog(@"%@",model);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MallGoodDetailVC *detail = [MallGoodDetailVC new];
    detail.MallGoodsModel = self.TreeModels[indexPath.row];
    detail.title = @"产品详情";
    [self.navigationController pushViewController:detail animated:YES];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((SCREEN_WIDTH - 45)/2, (SCREEN_WIDTH - 45)/2/330*230 + 111);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 0.001);
}





- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 0.001);
}
//定义每个Section的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 15, 15);//分别为上、左、下、右
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

#pragma mark - 获取数据
- (void)loadGoodList
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"629706";
    http.parameters[@"start"] = [NSString stringWithFormat:@"%ld",self.start];
    http.parameters[@"limit"] = @"8";
    http.parameters[@"status"] = @"4";
    if (self.orderColumn) {
        http.parameters[@"orderColumn"] = self.orderColumn;
        http.parameters[@"orderDir"] = self.orderDir;
        http.parameters[@"location"] = @(1);
    }
    else{
        http.parameters[@"orderColumn"] = self.orderColumn;
        http.parameters[@"orderDir"] = self.orderDir;
        http.parameters[@"location"] = @(1);
    }
    
    if (self.parentCategoryCode) {
        http.parameters[@"parentCategoryCode"] = self.parentCategoryCode;
    }
    else if (self.categoryCode) {
        http.parameters[@"categoryCode"] = self.categoryCode;
        
    }
    else{
        http.parameters[@"location"] = @"1";
    }
    if (self.shopCode){
        http.parameters[@"shopCode"] = self.shopCode;
    }
    if ([self.state isEqualToString:@"search"]) {
        http.parameters[@"name"] = self.SearchContent;
    }
    if (self.DelPlace) {
        http.parameters[@"deliverPlace"] = self.DelPlace;
    }
    if (self.OriPlace) {
        http.parameters[@"originPlace"] = self.OriPlace;
    }
    
    [http postWithSuccess:^(id responseObject) {
        NSMutableArray *array = responseObject[@"data"][@"list"];
        [self.GoodsArray addObjectsFromArray:array];
        self.TreeModels = [MallGoodsModel mj_objectArrayWithKeyValuesArray:self.GoodsArray];
        [self.collectionView reloadData];
        if ([responseObject[@"data"][@"totalPage"] intValue] <=1) {
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.collectionView.mj_header endRefreshing];
        }
    } failure:^(NSError *error) {
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];
    }];
}

-(void)loadmore{
    [self.GoodsArray removeAllObjects];
    TLNetworking *http = [TLNetworking new];
    http.code = @"629706";
    http.parameters[@"start"] = [NSString stringWithFormat:@"%ld",self.start];
    http.parameters[@"limit"] = @"8";
    http.parameters[@"orderColumn"] = @"order_no";
    http.parameters[@"orderDir"] = @"asc";
    http.parameters[@"status"] = @"4";
    if (self.parentCategoryCode) {
        http.parameters[@"parentCategoryCode"] = self.parentCategoryCode;
    }
    else if (self.categoryCode) {
        http.parameters[@"categoryCode"] = self.categoryCode;
        
    }
    else{
        http.parameters[@"location"] = @"1";
    }
    [http postWithSuccess:^(id responseObject) {
        NSMutableArray *array = responseObject[@"data"][@"list"];
        [self.GoodsArray addObjectsFromArray:array];
        self.TreeModels = [MallGoodsModel mj_objectArrayWithKeyValuesArray:self.GoodsArray];
        //        [self.TreeModels addObjectsFromArray:self.models];
        [self.collectionView reloadData];
        if ([responseObject[@"data"][@"totalPage"] intValue] <=1) {
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.collectionView.mj_header endRefreshing];
        }
    } failure:^(NSError *error) {
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];
    }];
}

-(void)getOriginalPlace{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629709";
    http.parameters[@"placeType"] = @"originalPlace";
    [http postWithSuccess:^(id responseObject) {
        
//        self.OriginalPlace = responseObject[@"data"][@"placeList"];
        NSMutableArray * arr = [NSMutableArray array];
        arr = responseObject[@"data"][@"placeList"];
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 0; i < arr.count; i ++) {
            [array addObject:[self creatPcikMenuItemModelWithString:arr[i]]];
        }
        self.OriginalPlace = array;
    } failure:^(NSError *error) {
    }];
}
-(void)getDeliverPlace{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629709";
    http.parameters[@"placeType"] = @"deliverPlace";
    [http postWithSuccess:^(id responseObject) {
//        self.DeliverPlace = responseObject[@"data"][@"placeList"];
        NSMutableArray * arr = [NSMutableArray array];
        arr = responseObject[@"data"][@"placeList"];
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 0; i < arr.count; i ++) {
            [array addObject:[self creatPcikMenuItemModelWithString:arr[i]]];
        }
        self.DeliverPlace = array;
    } failure:^(NSError *error) {
    }];
}

//筛选条件下树种
-(void)getType{
    self.mainKindArray = @[@"发货地",@"产地"];
    self.subKindArray = [NSMutableArray arrayWithArray:@[self.DeliverPlace,self.OriginalPlace]];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629706";
    http.parameters[@"start"] = @(self.start);
    http.parameters[@"limit"] = @(10);
    http.parameters[@"status"] = @(4);
    http.parameters[@"orderColumn"] = @"order_no";
    http.parameters[@"orderDir"] = @"asc";
    http.parameters[@"location"] = @(1);
    http.parameters[@"name"] = searchBar.text;
    [http postWithSuccess:^(id responseObject) {
        [self.GoodsArray removeAllObjects];
        NSMutableArray *array = responseObject[@"data"][@"list"];
        [self.GoodsArray addObjectsFromArray:array];
        self.TreeModels = [MallGoodsModel mj_objectArrayWithKeyValuesArray:self.GoodsArray];
        [self.collectionView reloadData];
        if ([responseObject[@"data"][@"totalPage"] intValue] <=1) {
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.collectionView.mj_header endRefreshing];
        }
    } failure:^(NSError *error) {
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];
    }];
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629706";
    http.parameters[@"start"] = @(self.start);
    http.parameters[@"limit"] = @(10);
    http.parameters[@"status"] = @(4);
    http.parameters[@"orderColumn"] = @"order_no";
    http.parameters[@"orderDir"] = @"asc";
    http.parameters[@"location"] = @(1);
    http.parameters[@"name"] = searchText;
    [http postWithSuccess:^(id responseObject) {
        [self.GoodsArray removeAllObjects];
        NSMutableArray *array = responseObject[@"data"][@"list"];
        [self.GoodsArray addObjectsFromArray:array];
        self.TreeModels = [MallGoodsModel mj_objectArrayWithKeyValuesArray:self.GoodsArray];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
}
@end
