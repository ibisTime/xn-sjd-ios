//
//  PersonalCenterVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/28.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "PersonalCenterVC.h"
#import "PersonalCenterHeadView.h"
#import "PersonalCenterTableVIew.h"
#import "MMComBoBoxView.h"
#import "MMComBoBox.h"
#import "PersonalCenterModel.h"
#import "MyTreeVC.h"
#import "FriendInfoModel.h"
#import "FriendsTheTreeVC.h"
#import "YiceSlidelipPickerMenu.h"
#import "YiceSlidelipPickPch.h"
#import "YiceSlidelipPickCommonModel.h"
@interface PersonalCenterVC ()<RefreshDelegate,MMComBoBoxViewDelegate,MMComBoBoxViewDataSource,AddFriendBtn,YiceSlidelipPickerMenuDelegate,YiceSlidelipPickerMenuDataSource>

@property (nonatomic , strong)PersonalCenterHeadView *headView;

@property (nonatomic , strong)PersonalCenterTableVIew *tableView;

@property (nonatomic, strong) MMComBoBoxView *comBoBoxView;
@property (nonatomic, strong) NSArray *mutableArray;

@property (nonatomic , strong)NSMutableArray <PersonalCenterModel *>*models;
@property (nonatomic , strong)NSMutableArray <DynamicModel *>*dynamicModel;
@property (nonatomic,strong) FriendInfoModel * FriendInfoModel;
@property (nonatomic,strong) NSMutableArray * TreeTypeArray;

@property (nonatomic,strong) NSString * area;
@property (nonatomic,strong) NSString * treeLevel;
@property (nonatomic,strong) NSString * variety;


@property (nonatomic, strong) NSArray *mainKindArray;
@property (nonatomic, strong) NSArray *subKindArray;
@property (nonatomic, strong) YiceSlidelipPickerMenu *pickMenu;

@end

@implementation PersonalCenterVC



-(void)viewWillAppear:(BOOL)animated
{
    [self navigationTransparentClearColor];
    
    //    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self navigationSetDefault];
    [self.comBoBoxView dimissPopView];
    
}

-(PersonalCenterHeadView *)headView
{
    if (!_headView) {
        _headView = [[PersonalCenterHeadView alloc]initWithFrame:CGRectMake(0, -kNavigationBarHeight, SCREEN_WIDTH, 180 - 65 + kNavigationBarHeight + 40)];

        _headView.delegate = self;
    }
    return _headView;
}

- (PersonalCenterTableVIew *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[PersonalCenterTableVIew alloc] initWithFrame:CGRectMake(0,  _headView.yy, SCREEN_WIDTH, SCREEN_HEIGHT - _headView.yy - kNavigationBarHeight) style:UITableViewStyleGrouped];
        
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kBackgroundColor;
        //        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getInfo];
    [self getType];
    [self.view addSubview:self.headView];
    self.tableView.state = self.state;
    [self.view addSubview:self.tableView];
   
    NSArray *screeningAry = @[@"所在地区",@"筛选"];
    
    UIButton *screeningBtn = [UIButton buttonWithTitle:@"筛选" titleColor:kTextColor backgroundColor:kClearColor titleFont:12];
    screeningBtn.frame = CGRectMake(SCREEN_WIDTH - 100, 180 - 65, 100, 40);
    [screeningBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:5 imagePositionBlock:^(UIButton *button) {
        [screeningBtn setImage:kImage(@"下拉") forState:(UIControlStateNormal)];
    }];
    [screeningBtn addTarget:self action:@selector(screeningBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];

    [self.view addSubview:screeningBtn];
    
    _mutableArray = [NSMutableArray array];
    
    self.comBoBoxView = [[MMComBoBoxView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 200, 180 - 65, 100, 40)];
    self.comBoBoxView.dataSource = self;
    self.comBoBoxView.delegate = self;
    [self.view addSubview:self.comBoBoxView];
    [self.comBoBoxView reload];
    [self LoadData];
    
    [self array];

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



-(YiceSlidelipPickerMenu *)pickMenu
{
    if (_pickMenu==nil) {
        _pickMenu=[[YiceSlidelipPickerMenu alloc] init];
        _pickMenu.delegate = self;
        _pickMenu.datasource = self;
    }
    return _pickMenu;
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
                self.treeLevel = model.text;
            }
            if (inde.section == 1) {
                YiceSlidelipPickCommonModel *model = [YiceSlidelipPickCommonModel new];
                model = self.subKindArray[inde.section][inde.row];
                self.variety = model.text;
                //            self.variety = self.subKindArray[inde.section][inde.row];
            }
        }
    }
    
    [self myTreeLoadData];
}


-(YiceSlidelipPickCommonModel*)creatPcikMenuItemModelWithString:(NSString*)str{
    
    YiceSlidelipPickCommonModel*model = [YiceSlidelipPickCommonModel new];
    model.isSelected = @"";
    model.text = str;
    return model;
}



-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (self.models.count > 0) {
            if ([self.state isEqualToString:@"rank"] || [self.state isEqualToString:@"friend"]) {
                if ([self.FriendInfoModel.userId isEqualToString:[TLUser user].userId]) {
                    MyTreeVC *vc = [MyTreeVC new];
                    vc.model = self.models[indexPath.row];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else{
                    FriendsTheTreeVC * vc = [FriendsTheTreeVC new];
                    vc.model = self.models[indexPath.row];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
            else{
                MyTreeVC *vc = [MyTreeVC new];
                vc.model = self.models[indexPath.row];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
        
        
    }
}

-(void)LoadData
{
    CoinWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    
    helper.code = @"629305";
    if ([self.state isEqualToString:@"rank"]) {
        helper.parameters[@"queryUserId"] = self.RankModel.userId;
    }
    else if ([self.state isEqualToString:@"friend"]){
        helper.parameters[@"queryUserId"] = self.FriendsModel.toUserInfo[@"userId"];
    }
    else
        helper.parameters[@"queryUserId"] = [TLUser user].userId;
   

    
    [helper modelClass:[DynamicModel class]];
    
    [self.tableView addRefreshAction:^{
        [weakSelf myTreeLoadData];
        [weakSelf TheLog];
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            
            if (weakSelf.tl_placeholderView.superview != nil) {
                
                [weakSelf removePlaceholderView];
            }
            

            
            weakSelf.tableView.dynamicArray = [PersonalCenterVC filterMaxItemsArray:objs filterKey:@"time"];
            
            [weakSelf.tableView endRefreshHeader];
            [weakSelf.tableView reloadData_tl];
        } failure:^(NSError *error) {
            
            [weakSelf addPlaceholderView];
            [weakSelf.tableView endRefreshHeader];
        }];
    }];
    
    [self.tableView beginRefreshing];
    
    [self.tableView addLoadMoreAction:^{
        
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            
            if (weakSelf.tl_placeholderView.superview != nil) {
                
                [weakSelf removePlaceholderView];
            }
            
            
            weakSelf.tableView.dynamicArray = [PersonalCenterVC filterMaxItemsArray:objs filterKey:@"time"];
            [weakSelf.tableView endRefreshHeader];
        } failure:^(NSError *error) {
            [weakSelf.tableView endRefreshHeader];
            [weakSelf addPlaceholderView];
            
        }];
        
    }];
    
    [self.tableView endRefreshingWithNoMoreData_tl];
    
    
    
    
}



+ (NSMutableArray *)filterMaxItemsArray:(NSArray *)array filterKey:(NSString *)key {
    NSMutableArray *origArray = [NSMutableArray arrayWithArray:array];
    NSMutableArray *filerArray = [NSMutableArray array];
//    key = [key convertDate];
    while (origArray.count > 0) {
        id obj = origArray.firstObject;
        NSPredicate *predic = nil;
        
        id value = [obj valueForKey:key];
        predic = [NSPredicate predicateWithFormat:@"self.%@ == %@",key,value];
        
        NSArray *pArray = [origArray filteredArrayUsingPredicate:predic];
        [filerArray addObject:pArray];
        [origArray removeObjectsInArray:pArray];
    }
    return filerArray;
}


//我认养的树
-(void)myTreeLoadData
{
//    CoinWeakSelf;
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.isUploadToken = NO;
    http.code = @"629207";
    
    if ([self.state isEqualToString:@"rank"]) {
        http.parameters[@"currentHolder"] = self.RankModel.userId;
    }
    else if ([self.state isEqualToString:@"friend"]){
        http.parameters[@"currentHolder"] = self.FriendsModel.toUserInfo[@"userId"];
    }
    else
        http.parameters[@"currentHolder"] = [TLUser user].userId;
    
    http.parameters[@"statusList"] = @[@"1",@"2",@"3"];
    
    if ([self.area isEqualToString:@"全国"]) {
        http.parameters[@"area"] = @"";
    }else
    {
        http.parameters[@"area"] = self.area;
    }
    
    http.parameters[@"treeLevel"] = self.treeLevel;
    http.parameters[@"variety"] = self.variety;
    
    
    [http postWithSuccess:^(id responseObject) {
        self.models = [PersonalCenterModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.tableView.models = self.models;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {

    }];
    
    
}


-(void)TheLog
{
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.isUploadToken = NO;
    http.code = @"629305";
    http.parameters[@"start"] = @"1";
    http.parameters[@"limit"] = @"100";
    [http postWithSuccess:^(id responseObject) {

        [self.tableView reloadData];
    } failure:^(NSError *error) {

    }];
}

-(void)getInfo{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = USER_INFO;
    if ([self.state isEqualToString:@"rank"]) {
        http.parameters[@"userId"] = self.RankModel.userId;
        
    }
    else if ([self.state isEqualToString:@"friend"]){
        http.parameters[@"userId"] = self.FriendsModel.toUserInfo[@"userId"];
    }
    else
        http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        self.FriendInfoModel = [FriendInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.headView.state = self.state;
        self.headView.FriendInfoModel = self.FriendInfoModel;
        
    } failure:^(NSError *error) {
        
    }];
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
//                    [self refresh];
                    break;
                case 1:
//                    self.treeLevel = title;
//                    [self refresh];
                    break;
                default:
                    break;
            }
            //            [self.collectionView reloadData];
            
            break;
            
        }
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
//                NSString *title;
//                NSMutableString *subtitles = [NSMutableString string];
//                //                NSMutableString *varietys = [NSMutableString string];
//                for (MMSelectedPath *path in subArray) {
//                    MMItem *firstItem = combineItem.childrenNodes[path.firstPath];
//                    MMItem *secondItem = combineItem.childrenNodes[path.firstPath].childrenNodes[path.secondPath];
//                    title = firstItem.title;
//                    [subtitles appendString:[NSString stringWithFormat:@"%@",secondItem.title]];
//                    //                    [varietys appendString:[NSString stringWithFormat:@"%@",secondItem.title]];
//                }
//
//                NSLog(@"当title为%@时，所选字段为 %@",title,subtitles);
//                if ([title isEqualToString:@"树级"]) {
//                    self.treeLevel = subtitles;
//                }
//                else{
//                    self.variety = subtitles;
//                }
//            }];
//
//            break;
//
//        }
        default:
            break;
    }
    [self myTreeLoadData];
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
                        [self creatPcikMenuItemModelWithString:@"一级"],
                        [self creatPcikMenuItemModelWithString:@"二级"],
                        [self creatPcikMenuItemModelWithString:@"三级"]]],
                    [NSMutableArray arrayWithArray:self.TreeTypeArray]]];
        
//        [self array];
        
        NSLog(@"%@",array);
    } failure:^(NSError *error) {
        
    }];
}

-(void)array{
    NSMutableArray *mutableArray = [NSMutableArray array];
    
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
    
    
    _mutableArray  = mutableArray;
    [self.comBoBoxView reload];
}
- (id)JsonObject:(NSString *)jsonStr{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:jsonStr ofType:nil];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:jsonPath];
    NSError *error;
    id JsonObject= [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    return JsonObject;
}



-(void)AddFriend:(NSString *)toUser{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"805150";
    http.parameters[@"toUser"] = toUser;
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"type"] = @(2);
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"申请成功，等待验证通过"];
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        
    }];
}

@end
