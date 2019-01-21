//
//  QWCategoryDetailController.m
//  QW京东Demo
//
//  Created by mac on 16/1/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "QWCategoryDetailController.h"
#import "QWCategoryCommon.h"
#import "QWDetailCategoryCell.h"
#import "QWCollectionHeaderView.h"
#import "TLNavigationController.h"
#import "JHCollectionReusableView.h"
#import "QWCategoryDetail.h"
#import "MallGoodListViewController.h"
//#import "QWProductListController.h"

#import "UIImageView+WebCache.h"
#import "JHCollectionViewFlowLayout.h"
@interface QWCategoryDetailController ()<JHCollectionViewDelegateFlowLayout>

// 保存模型(SCCategoryDetail)
@property (nonatomic, strong) NSMutableArray *detailCategoryList;
//// 记录上一次的请求队列
//@property (nonatomic, strong) AFHTTPRequestOperation *headerOperation;
// 记录上一次的请求队列(AFHTTPRequestOperation)
@property (nonatomic, strong) NSMutableArray *detailOperations;

@property (nonatomic, assign) NSInteger inter; //左侧section索引

@end

@implementation QWCategoryDetailController

static NSString * const reuseIdentifierForCell = @"Cell";
static NSString * const reuseIdentifierForHeaderView = @"HeaderView";
static NSString * const reuseIdentifierImageCell = @"imageCell";

#pragma mark - 懒加载
- (NSMutableArray *)detailCategoryList {
    if (_detailCategoryList == nil) {
        _detailCategoryList = [NSMutableArray array];
    }
    return _detailCategoryList;
}

- (NSMutableArray *)detailOperations {
    if (_detailOperations == nil) {
        _detailOperations = [NSMutableArray array];
    }
    return _detailOperations;
}

#pragma mark - 初始化
- (instancetype)init {
    
    return [super initWithCollectionViewLayout:[self flowLayout]];
}

- (JHCollectionViewFlowLayout *)flowLayout {
    
    JHCollectionViewFlowLayout *flowLayout = [[JHCollectionViewFlowLayout alloc] init];
    
    // 设置cell的尺寸
    flowLayout.itemSize = CGSizeMake((kScreenWidth - kWidth(95)-60) / 3, 100);
    flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, kHeight(160));
    
    // 清空间距
//    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 0;
    
    flowLayout.minimumInteritemSpacing = 0;
    
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 0, 15);
    
    return flowLayout;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // 注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifierImageCell];
    // 注册cell
    [self.collectionView registerClass:[QWDetailCategoryCell class] forCellWithReuseIdentifier:reuseIdentifierForCell];
    // 注册headerView
    [self.collectionView registerClass:[JHCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierForHeaderView];
    
    // 不显示滚动条, 不允许下拉
    self.collectionView.bounces = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadHeaderCategoryData:)
                                                 name:QWDetailCategoryDataWillLoadNotification
                                               object:nil];
    
}

#pragma mark - 销毁时调用,移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 请求数据
#pragma mark 1. 取消上一次的请求
- (void)cancelLastRequest {
    // 停止上一次的请求
//    [_headerOperation pause];
//    if (self.detailOperations.count) {
//        for (AFHTTPRequestOperation *operation in self.detailOperations) {
//            [operation pause];
//        }
//        [self.detailOperations removeAllObjects];
//    }
    // 停止所有下载
    [[SDWebImageManager sharedManager] cancelAll];
    // 移除上一次的所有数据
    [self.detailCategoryList removeAllObjects];
}

#pragma mark 2. 请求二级分类数据(1.用于显示组的头标题2.用于请求详细分类数据)
- (void)loadHeaderCategoryData:(NSNotification *)notification {
    
   NSString *row = notification.object;
    NSInteger inter = [row integerValue];
    self.inter = inter;
    NSIndexPath *inde = [NSIndexPath indexPathForRow:0 inSection:0];
      [self.collectionView scrollToItemAtIndexPath:inde atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
//    [self.collectionView reloadData];
    return;
    // 取消上一次的请求
    [self cancelLastRequest];
    // 发起(新)请求
//    AFHTTPRequestOperation *headerOperation
//    = [QWCatelogListTool GETCatelogyListWithLevel:@"0" catelogyId:notification.object success:^(NSArray *catelogyList) {
//
//        // 遍历结果数组, 请求详细分类数据
//        [self requestDetailCategoryDataWithCatelogyList:catelogyList];
//
//    } failure:^(NSError *error) {
//        QWLog(@"请求header分类信息出错:%@", error);
//    }];

    // 保存当前请求操作
//    _headerOperation = headerOperation;
}

#pragma mark 3. 根据二级分类数据, 请求详细分类数据
- (void)requestDetailCategoryDataWithCatelogyList:(NSArray *)catelogyList {
    
    // 遍历结果数组, 请求详细分类数据
//    [catelogyList enumerateObjectsUsingBlock:
//     ^(QWCategory *headerCategory, NSUInteger idx, BOOL *stop) {
//
//         QWCategoryDetail *detailCategory = [[QWCategoryDetail alloc] init];
//         // 1. 获取返回的headerCategory
//         detailCategory.headerCategory = headerCategory;
//         // 2. 添加headerCategory至模型数组
//         [self.detailCategoryList addObject:detailCategory];
//
//         // 3. 获取headerCategory对应的详细分类列表
//         [self loadDetailCategoryDataWithCatelogId:headerCategory.cid forSection:idx];
//     }];
    
    // 注意：得到数据后，一定要刷新列表
    [self.collectionView reloadData];
}

#pragma mark 4. 请求三级分类数据
- (void)loadDetailCategoryDataWithCatelogId:(NSString *)catelogId forSection:(NSUInteger)index {
//    AFHTTPRequestOperation *detailOperation
//    = [QWCatelogListTool GETCatelogyListWithLevel:@"1" catelogyId:catelogId success:^(NSArray *catelogyList) {
//        if (self.detailCategoryList.count) {
//            QWCategoryDetail *detailCategory = self.detailCategoryList[index];
//            detailCategory.categories = catelogyList;
//        }
//        // 注意：得到数据后，一定要刷新列表
//        [self.collectionView reloadData];
//
//    } failure:^(NSError *error) {
//        QWLog(@"请求详细分类信息出错:%@", error);
//    }];
    [self.collectionView reloadData];
    // 保存当前请求操作
}

#pragma mark - <UICollectionViewDataSource>
#pragma mark 有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
//    return self.detailCategoryList.count;
    return 10;
}

#pragma mark 每组有多少个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    QWCategoryDetail *detailCategory = self.detailCategoryList[section];
//    return detailCategory.categories.count;
    return 20;
}
#pragma mark cell长什么样
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
  
//    if (indexPath.row == 0) {
//
//         UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierImageCell forIndexPath:indexPath];
//        UIImageView *detailImage = [[UIImageView alloc] init];
//        detailImage.frame = CGRectMake(15, 15, kScreenWidth-QWCategoryMenuWidth-30, kHeight(79));
//
//        detailImage.image = kImage(@"我的背景");
//        [cell addSubview:detailImage];
//        return cell;
//    }else{
        QWDetailCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierForCell forIndexPath:indexPath];
        // 取出模型数据
        //    QWCategoryDetail *detailCategory = self.detailCategoryList[indexPath.section];
        //    cell.category = detailCategory.categories[indexPath.row];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@""]
                          placeholderImage:[UIImage imageNamed:@"我的背景"]];
        
        // 添加文字
        cell.textLabel.text = [NSString stringWithFormat:@"分类年货"];
        return cell;

//        }
}
#pragma mark 附加控件长什么样
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    JHCollectionReusableView *reusableView = nil;
    NSString *identfier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
     [self.collectionView registerClass:[JHCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identfier];
    if (kind == UICollectionElementKindSectionHeader) {
        JHCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identfier forIndexPath:indexPath];
        
        reusableView = headerView;
    }
//    reusableView.layer.borderColor = kLineColor.CGColor;
//    reusableView.layer.borderWidth = 1;
//    reusableView.backgroundColor = [UIColor redColor];
    // 取出模型数据
//    QWCategoryDetail *detailCategory = self.detailCategoryList[indexPath.section];
    reusableView.headerTitle = [NSString stringWithFormat:@"分组%ld",indexPath.section];
    
    NSLog(@"%@",NSStringFromCGRect(collectionView.frame));
    return reusableView;
}

#pragma mark - <UICollectionViewDelegate>
#pragma mark 选中cell时做什么
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    // 取出模型数据
//    QWCategoryDetail *detailCategory = self.detailCategoryList[indexPath.section];
//    QWCategory *selectedCategory = detailCategory.categories[indexPath.row];
//
//    // 跳转
    MallGoodListViewController *productListVC = [MallGoodListViewController new];
    productListVC.title = @"商品列表";
    [self.navigationController pushViewController:productListVC animated:YES];
//
    
    
}
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout backgroundColorForSection:(NSInteger)section
{
    
    return [@[
              [UIColor redColor],
              [UIColor greenColor],
              [UIColor yellowColor],
              [UIColor redColor],
              [UIColor greenColor],
              [UIColor yellowColor],
              [UIColor redColor],
              [UIColor greenColor],
              [UIColor yellowColor],
              [UIColor redColor],
            
              ] objectAtIndex:section];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(kScreenWidth, kHeight(160));
    }else{
        return CGSizeMake(kScreenWidth, kHeight(30));
    }
}


#pragma mark 是否可点击

@end
