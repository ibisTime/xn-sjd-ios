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
@interface PersonalCenterVC ()<RefreshDelegate,MMComBoBoxViewDelegate,MMComBoBoxViewDataSource,AddFriendBtn>

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
@end

@implementation PersonalCenterVC


-(void)viewWillAppear:(BOOL)animated
{
    [self navigationTransparentClearColor];
    [self getType];
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
    [self.view addSubview:self.headView];
    self.tableView.state = self.state;
    [self.view addSubview:self.tableView];
   
    
    
//    _mutableArray = [NSMutableArray array];
    
    self.comBoBoxView = [[MMComBoBoxView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 200, 180 - 65, 200, 40)];
    self.comBoBoxView.dataSource = self;
    self.comBoBoxView.delegate = self;
    [self.view addSubview:self.comBoBoxView];
    [self.comBoBoxView reload];
    [self LoadData];

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
        http.parameters[@"area"] = self.area;
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
                //                NSMutableString *varietys = [NSMutableString string];
                for (MMSelectedPath *path in subArray) {
                    MMItem *firstItem = combineItem.childrenNodes[path.firstPath];
                    MMItem *secondItem = combineItem.childrenNodes[path.firstPath].childrenNodes[path.secondPath];
                    title = firstItem.title;
                    [subtitles appendString:[NSString stringWithFormat:@"%@",secondItem.title]];
                    //                    [varietys appendString:[NSString stringWithFormat:@"%@",secondItem.title]];
                }
                
                NSLog(@"当title为%@时，所选字段为 %@",title,subtitles);
                if ([title isEqualToString:@"树级"]) {
                    self.treeLevel = subtitles;
                }
                else{
                    self.variety = subtitles;
                }
            }];
            
            break;
            
        }
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
            [array addObject:arr[i][@"variety"]];
        }
        self.TreeTypeArray = array;
        [self array];
        NSLog(@"%@",array);
    } failure:^(NSError *error) {
        
    }];
}

-(void)array{
    NSMutableArray *mutableArray = [NSMutableArray array];
    //root 4
    MMCombinationItem *rootItem4 = [MMCombinationItem itemWithItemType:MMPopupViewDisplayTypeUnselected isSelected:NO titleName:@"筛选" subtitleName:nil];
    rootItem4.displayType = MMPopupViewDisplayTypeFilters;
    
    if (self.isMultiSelection)
        rootItem4.selectedType = MMPopupViewMultilSeMultiSelection;
    
    //        NSArray *arr = @[@{@"认养状态":@[@"可认养",@"不可认养"]},
    //                         @{@"认养模式":@[@"专属",@"定向",@"捐赠",@"集体"]},
    //                         @{@"树种":@[@"樟树",@"柏树"]} ];
    
    NSArray *arr = @[@{@"树级":@[@"一级",@"二级",@"三级"]},
//                     @{@"认养模式":self.TreeTypeArray},
                     @{@"树种":self.TreeTypeArray} ];
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
    [mutableArray addObject:rootItem4];
    
    
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
