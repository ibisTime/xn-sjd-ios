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
@interface PersonalCenterVC ()<RefreshDelegate,MMComBoBoxViewDelegate,MMComBoBoxViewDataSource>

@property (nonatomic , strong)PersonalCenterHeadView *headView;

@property (nonatomic , strong)PersonalCenterTableVIew *tableView;

@property (nonatomic, strong) MMComBoBoxView *comBoBoxView;
@property (nonatomic, strong) NSArray *mutableArray;
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
    
}

-(PersonalCenterHeadView *)headView
{
    if (!_headView) {
        _headView = [[PersonalCenterHeadView alloc]initWithFrame:CGRectMake(0, -kNavigationBarHeight, SCREEN_WIDTH, 180 - 65 + kNavigationBarHeight + 40)];
        
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
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
    [self tableViewTopView];
    
    
//    _mutableArray = [NSMutableArray array];
    
    self.comBoBoxView = [[MMComBoBoxView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 200, 180 - 65, 200, 40)];
    self.comBoBoxView.dataSource = self;
    self.comBoBoxView.delegate = self;
    [self.view addSubview:self.comBoBoxView];
    [self.comBoBoxView reload];
    
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
//                    self.area = title;
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
//                if (subtitles) {
//                    if ([subtitles isEqualToString:@"不可认养"]) {
//                        self.adoptStatus = @"0";
//                    }
//                    else if ([subtitles isEqualToString:@"可认养"]){
//                        self.adoptStatus = @"1";
//                    }
//                    else if ([subtitles isEqualToString:@"柏树"]){
//                        self.variety = @"柏树";
//                    }
//                    else if ([subtitles isEqualToString:@"樟树"]){
//                        self.variety = @"樟树";
//                    }
//
//                    [self refresh];
//                }
                
                
                
            }];
            
            break;
            
        }
        default:
            break;
    }
}



#pragma mark - Getter
- (NSArray *)mutableArray {
    if (_mutableArray == nil) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        //root 1
//        MMSingleItem *rootItem1 = [MMSingleItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:nil];
//
//        NSMutableString *title = [NSMutableString string];
//        [rootItem1 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:YES titleName:@"全部" subtitleName:[NSString stringWithFormat:@"%ld",random()%10000] code:nil]];
//        [title appendString:@"全部"];
//        for (int i = 0; i < 20; i ++) {
//            MMItem *subItem = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"蛋糕系列%d",i] subtitleName:[NSString stringWithFormat:@"%ld",random()%10000] code:nil];
//            [rootItem1 addNode:subItem];
//        }
//        rootItem1.title = title;
        
        //root 2
//        MMSingleItem *rootItem2 = [MMSingleItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"树龄排序"];
//
//        if (self.isMultiSelection)
//            rootItem2.selectedType = MMPopupViewMultilSeMultiSelection;
//
//        [rootItem2  addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:YES titleName:@"树龄排序" subtitleName:nil code:nil]];
//        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"100年"]]];
//        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"200年"]]];
//        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"300年"]]];
//        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"500年"]]];
//
//
//        //root 3
//        MMMultiItem *rootItem3 = [MMMultiItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"树级"];
//
//        rootItem3.displayType = MMPopupViewDisplayTypeMultilayer;
//        NSArray *name = @[@"全部",@"一级",@"二级",@"三级"];
//        NSArray *nameSub = @[@"全部",@"一级",@"二级",@"三级"];
//
//        for (int i = 0; i < 4; i++){
//            MMItem *item3_A = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"%@",name[i]] subtitleName:nameSub[i]];
//            item3_A.isSelected = (i == 0);
//            [rootItem3 addNode:item3_A];
//            MMItem *item3_B = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"%@",nameSub[i]] subtitleName:nil];
//            item3_B.isSelected = (i == 0);
//            [item3_A addNode:item3_B];
//        }
        
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

-(void)tableViewTopView
{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 62.5)];

    footView.backgroundColor = kWhiteColor;
    
    UIView *footlineView = [[UIView alloc]initWithFrame:CGRectMake(15, 21, 3, 15)];
    footlineView.backgroundColor = kHexColor(@"#23AD8C");
    kViewRadius(footlineView, 1.5);
    [footView addSubview:footlineView];
    
    UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(footlineView.xx + 6, 20, SCREEN_WIDTH - footlineView.xx - 21, 17) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(17) textColor:kTextBlack];
    nameLabel.text = [LangSwitcher switchLang:@"TA的动态" key:nil];
    [footView addSubview:nameLabel];
    
    self.tableView.tableHeaderView = footView;
}



@end
