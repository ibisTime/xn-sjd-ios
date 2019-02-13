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
@interface MallGoodListViewController ()<UISearchBarDelegate,MMComBoBoxViewDataSource,MMComBoBoxViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) NSArray *mutableArray;
@property (nonatomic, strong) MMComBoBoxView *comBoBoxView;
@property (nonatomic, strong) UIButton *nextPageBtn;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray <MallGoodsModel *>*TreeModels;
@property (nonatomic, assign) NSInteger start;

@end

@implementation MallGoodListViewController
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
- (void)viewDidLoad {
    [super viewDidLoad];
//    [UIBarButtonItem addLeftItemWithImageName:@"返回白色" frame:CGRectMake(-10, 0, 44, 40) vc:self action:@selector(backButtonClick)];
    [self initSearchBar];
    [self initComboBox];
    [self.view addSubview:self.collectionView];
    [self headRefresh];
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
    self.TreeModels = [NSMutableArray array];
    [self loadGoodList];
}

-(void)loadNewDataFooter
{
    self.start ++;
    [self loadGoodList];
}

- (void)loadGoodList
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"629706";
    http.parameters[@"start"] = [NSString stringWithFormat:@"%ld",self.start];
    http.parameters[@"limit"] = @"10";
    http.parameters[@"orderColumn"] = @"order_no";
    http.parameters[@"orderDir"] = @"asc";
    http.parameters[@"location"] = @"1";
    [http postWithSuccess:^(id responseObject) {
        self.TreeModels = [MallGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
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
- (void)initComboBox
{
    self.comBoBoxView = [[MMComBoBoxView alloc] initWithFrame:CGRectMake(0, self.searchBar.yy+10, kScreenWidth, 40)];
    self.comBoBoxView.dataSource = self;
    self.comBoBoxView.delegate = self;
    [self.view addSubview:self.comBoBoxView];
    [self.comBoBoxView reload];
    
    
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
    //    [self.backgroundimage addSubview:searchbar];
    [self.view addSubview:searchbar];
    //    [self.headview bringSubviewToFront:searchbar];
    self.searchBar = searchbar;
    
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
//- (void)backButtonClick {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

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
        MMSingleItem *rootItem2 = [MMSingleItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"销量"];
        
        rootItem2.selectedType = MMPopupViewMultilSeMultiSelection;
        

        
        
        //root 3
        MMSingleItem *rootItem3 = [MMSingleItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"价格"];
        
        rootItem3.selectedType = MMPopupViewMultilSeMultiSelection;
    
        [rootItem3 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"从高到低"]]];
        [rootItem3 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"从低到高"]]];
      
        
        //root 4
        MMCombinationItem *rootItem4 = [MMCombinationItem itemWithItemType:MMPopupViewDisplayTypeUnselected isSelected:NO titleName:@"筛选" subtitleName:nil];
        rootItem4.displayType = MMPopupViewDisplayTypeFilters;
        
        NSArray *arr = @[@{@"筛选1":@[@"价格",@"销量"]},
                         @{@"筛选2":@[@"地点",@"好评"]},
                         @{@"筛选3":@[@"推荐",@"热销"]} ];
        
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
         MMSingleItem *rootItem5 = [MMSingleItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"全部"];
        [rootItem5 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"分类1"]]];
        [rootItem5 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"分类2"]]];
//         [rootItem5 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@""]]];
        
        //      [mutableArray addObject:rootItem1];
        [mutableArray addObject:rootItem5];
        [mutableArray addObject:rootItem3];
        [mutableArray addObject:rootItem2];
        [mutableArray addObject:rootItem4];
        
        
        _mutableArray  = [mutableArray copy];
    }
    return _mutableArray;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark------CollectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.TreeModels.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MallListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MallListCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.TreeModels[indexPath.row];
//    if (indexPath.row % 2 == 0) {
//        cell.backView.frame = CGRectMake(12, 0, (SCREEN_WIDTH - 30)/2, kHeight(226));
//    }else
//    {
//        cell.backView.frame = CGRectMake(3, 0, (SCREEN_WIDTH - 30)/2, kHeight(226));
//    }
    [cell.shopping addTarget:self action:@selector(shoppButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)shoppButtonClick:(UIButton *)sender
{
    CGPoint point = sender.center;
    point = [self.collectionView convertPoint:point fromView:sender.superview];
    NSIndexPath* indexpath = [self.collectionView indexPathForItemAtPoint:point];
    MallGoodsModel *model = self.TreeModels[indexpath.row];
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




@end
