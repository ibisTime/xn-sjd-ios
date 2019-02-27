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

#import "YiceSlidelipPickerMenu.h"
#import "YiceSlidelipPickPch.h"
#import "YiceSlidelipPickCommonModel.h"
@interface TreeListVC ()<UITextFieldDelegate,UISearchBarDelegate,UIScrollViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,MMComBoBoxViewDelegate,MMComBoBoxViewDataSource,YiceSlidelipPickerMenuDelegate,YiceSlidelipPickerMenuDataSource>
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
@property (nonatomic,strong) NSString * orderDir;
@property (nonatomic,strong) NSString * orderColumn;
@property (nonatomic,strong) NSString * area;
@property (nonatomic,strong) NSString * treeLevel;
@property (nonatomic,strong) NSString * adoptStatus;
@property (nonatomic,strong) NSString * variety;

@property (nonatomic, strong) NSArray *mainKindArray;
@property (nonatomic, strong) NSArray *subKindArray;
@property (nonatomic,strong) NSMutableArray * TreeTypeArray;
@property (nonatomic, strong) YiceSlidelipPickerMenu *pickMenu;
@end

@implementation TreeListVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
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

//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self.comBoBoxView dimissPopView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    self.treeArray = [NSMutableArray array];
    [self getType];
    [self initSearchBar];
    [self initComboBox];
    [self.view addSubview:self.collectionView];
    [self headRefresh];
//    [self datafromsearch];
    if ([self.state isEqualToString:@"search"]) {
        self.searchBar.text = self.SearchContent;
    }
    
    
    UIButton *screeningBtn = [UIButton buttonWithTitle:@"筛选" titleColor:kTextColor backgroundColor:kClearColor titleFont:12];
    screeningBtn.frame = CGRectMake(SCREEN_WIDTH * 3 / 4, 0, SCREEN_WIDTH / 4, 40);
    [screeningBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:5 imagePositionBlock:^(UIButton *button) {
        [screeningBtn setImage:kImage(@"下拉") forState:(UIControlStateNormal)];
    }];
    [screeningBtn addTarget:self action:@selector(screeningBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:screeningBtn];
}

-(void)screeningBtnClick:(UIButton *)sender
{
    self.pickMenu.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[[UIApplication sharedApplication].delegate window] addSubview:self.pickMenu];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.pickMenu cache:YES];
    [UIView setAnimationDuration:0.3];
    self.pickMenu.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [UIView commitAnimations];
    
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
        }
    }
}

- (void)menu:(YiceSlidelipPickerMenu *)menu submmitSelectedIndexPaths:(NSArray<NSIndexPath *> *)indexpaths{
    //同步数据
    if (indexpaths.count == 0) {
        self.treeLevel = @"";
        self.variety = @"";
    }else
    {
        NSIndexPath *inde;
        for (int i = 0; i < indexpaths.count; i ++) {
            inde = indexpaths[i];
            if (inde.section == 0) {
                YiceSlidelipPickCommonModel *model = [YiceSlidelipPickCommonModel new];
                model = self.subKindArray[inde.section][inde.row];
                if ([model.text isEqualToString:@"不可认养"]) {
                    self.adoptStatus = @"0";
                }
                else
                    self.adoptStatus = @"1";
//                self.treeLevel = model.text;
            }
            if (inde.section == 1) {
                YiceSlidelipPickCommonModel *model = [YiceSlidelipPickCommonModel new];
                model = self.subKindArray[inde.section][inde.row];
                self.variety = model.text;
//                [self refresh];
                //            self.variety = self.subKindArray[inde.section][inde.row];
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



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
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
//    cell.ProductStatusArray = self.ProductStatusArray;
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailsVc *detailVC = [GoodsDetailsVc new];
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
    self.comBoBoxView = [[MMComBoBoxView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth * 3 / 4, 40)];
    self.comBoBoxView.dataSource = self;
    self.comBoBoxView.delegate = self;
    [self.view addSubview:self.comBoBoxView];
    [self.comBoBoxView reload];
    
    [self.view addSubview:self.imageView];
    if (self.isMultiSelection == NO)
        [self.view addSubview:self.nextPageBtn];
    
}



//搜索框
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
                    [self headRefresh];
                    break;
                case 1:
                    if ([title isEqualToString:@"100年"]) {
                        self.treeLevel = @"THIRD";
                    }else if ([title isEqualToString:@"300年"]){
                        self.treeLevel = @"SECOND";
                    }
                    else{
                        self.treeLevel = @"FIRST";
                    }
                    
                    [self headRefresh];
                    break;
                case 2:{
                    if ([title isEqualToString:@"从小到大"]) {
                        self.orderColumn = @"age";
                        self.orderDir = @"asc";
                    }
                    else{
                        self.orderDir = @"desc";
                        self.orderColumn = @"age";
                    }
                    [self headRefresh];
                }
                    break;
                default:
                    break;
            }
//            [self.collectionView reloadData];
            
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
        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"从大到小"]]];
        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"从小到大"]]];
        
        
        //root 3
        MMMultiItem *rootItem3 = [MMMultiItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"树级"];
        
        rootItem3.displayType = MMPopupViewDisplayTypeMultilayer;
        NSArray *name = @[@"全部",@"一级",@"二级",@"三级"];
        NSArray *nameSub = @[@"全部",@"500年",@"300年",@"100年"];

        for (int i = 0; i < 4; i++){
            MMItem *item3_A = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"%@",name[i]] subtitleName:nameSub[i]];
            item3_A.isSelected = (i == 0);
            [rootItem3 addNode:item3_A];
            MMItem *item3_B = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"%@",nameSub[i]] subtitleName:nil];
            item3_B.isSelected = (i == 0);
            [item3_A addNode:item3_B];
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
//        [mutableArray addObject:rootItem4];


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


#pragma 获取数据
-(void)refresh{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629025";
    http.parameters[@"start"] = @(self.start);
    http.parameters[@"limit"] = @(10);
    
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
    if (self.orderColumn) {
        http.parameters[@"orderColumn"] = self.orderColumn;
    }
    if (self.orderDir) {
        http.parameters[@"orderDir"] = self.orderDir;
    }
    if ([self.state isEqualToString:@"search"]) {
        http.parameters[@"name"] = self.SearchContent;
    }else{
        http.parameters[@"name"]= @"";
    }
    [http postWithSuccess:^(id responseObject) {
        NSArray *array = responseObject[@"data"][@"list"];
        [self.treemMuArray addObjectsFromArray:array];
        self.models = [TreeModel mj_objectArrayWithKeyValuesArray:self.treemMuArray];
        
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

//筛选条件下树种
-(void)getType{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code= @"629210";
    [http postWithSuccess:^(id responseObject) {
        NSMutableArray * arr = [NSMutableArray array];
        arr = responseObject[@"data"];
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 0; i < arr.count; i ++) {
            [array addObject:[self creatPcikMenuItemModelWithString:arr[i][@"variety"]]];
        }
        self.TreeTypeArray = array;
        
        self.mainKindArray = @[@"树级",@"树种"];
        self.subKindArray = [NSMutableArray arrayWithArray:@[
                                                             [NSMutableArray arrayWithArray:@[
                                                                                              [self creatPcikMenuItemModelWithString:@"可认养"],
                                                                                              [self creatPcikMenuItemModelWithString:@"不可认养"]]],
                                                             [NSMutableArray arrayWithArray:self.TreeTypeArray]]];
        
        //        [self array];
        
        NSLog(@"%@",array);
    } failure:^(NSError *error) {
        
    }];
}
#pragma 搜索功能数据
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
-(void)datafromsearch{
    if ([self.state isEqualToString:@"search"]) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"629025";
        http.parameters[@"start"] = @(self.start);
        http.parameters[@"limit"] = @(10);
        http.parameters[@"type"]= @(1);
        
        http.parameters[@"name"] = self.SearchContent;
        http.parameters[@"userId"] = [TLUser user].userId;
        http.parameters[@"statusList"] = @[@"4",@"5",@"6"];
        [http postWithSuccess:^(id responseObject) {
            
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
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
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
@end
