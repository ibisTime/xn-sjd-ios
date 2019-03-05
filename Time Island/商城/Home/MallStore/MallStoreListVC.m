//
//  MallStoreListVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/23.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallStoreListVC.h"
#import "MallListCollectionViewCell.h"
#import "MallGoodDetailVC.h"
#import "SLBannerView.h"
#import "QWCategory.h"
#import "MallGoodsModel.h"
#import "MallStoreHeadView.h"
#import "MallGoodListViewController.h"
@interface MallStoreListVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    
    
}
@property (nonatomic,strong) NSMutableArray <MallGoodsModel *>*MallGoodsModels;
@property (nonatomic,strong) NSMutableArray<QWCategory *> * QWCategorys;
@property (nonatomic,strong) SLBannerView *topImage;
@property (nonatomic,strong) UIImageView * headImage;
@property (nonatomic,strong) UILabel *nameLable;
@property (nonatomic,strong) UILabel *introduceLable;
@property (nonatomic,strong) UIView * headerView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray * imageArraay ;
@property (nonatomic,strong) NSString * introduce;
@end

@implementation MallStoreListVC
-(UICollectionView *)collectionView{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *flowayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) collectionViewLayout:flowayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = kWhiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
         [_collectionView registerClass:[MallStoreHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        [_collectionView registerClass:[MallListCollectionViewCell class] forCellWithReuseIdentifier:@"MallListCollectionViewCell"];
    }
    return _collectionView;
}
- (UIView *)headerView {
    
    if (!_headerView) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/750*300  + SCREEN_WIDTH/4 + 149)];
       
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//
    [self getClassify];
    [self loadGoodsData];
    [self.view addSubview:self.collectionView];
    [self loadData];
    [self topImageLoadData];
//    [self initTop];
}



- (void)initTop
{

    _topImage = [SLBannerView bannerView];
    _topImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/750*300);
    _topImage.durTimeInterval = 0.2;
    _topImage.imgStayTimeInterval = 2.5;
    //工程图片
    
    

    [self.headerView addSubview:_topImage];
    
    
    
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-80)/2, _topImage.yy-40, 80, 80)];
    _headImage.layer.cornerRadius = 40;
    _headImage.clipsToBounds = YES;
    _headImage.image = kImage(@"分类三");
    [self.headerView addSubview:_headImage];
    
    _nameLable = [UILabel labelWithFrame:CGRectMake(0, _headImage.yy+11, SCREEN_WIDTH, 22.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(16) textColor:kBlackColor];
    _nameLable.text = self.treeModel.shopName;
    [_nameLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [self.headerView addSubview:_nameLable];
    
    
    
    
    _introduceLable = [UILabel labelWithFrame:CGRectMake(15, _nameLable.yy+7, (kScreenWidth-30), 16.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
    _introduceLable.text = @"";
    [self.headerView addSubview:_introduceLable];
    
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _introduceLable.yy + 20, SCREEN_WIDTH, 10)];
    lineView.backgroundColor = kBackgroundColor;
    [self.headerView addSubview:lineView];
    
//    NSArray * ClassifyName = @[@"分类一",@"分类二",@"分类三",@"分类四"];
    
    NSMutableArray * namearr = [NSMutableArray array];
    NSMutableArray  *imagearr = [NSMutableArray array];
    for (int i = 0; i < self.QWCategorys.count; i++) {
        [namearr addObject:self.QWCategorys[i].name];
        [imagearr addObject:self.QWCategorys[i].pic];
    }

        for (int i = 0; i < self.QWCategorys.count; i ++) {
            UIButton *iconBtn = [UIButton buttonWithTitle:@"" titleColor:kHexColor(@"#666666") backgroundColor:kClearColor titleFont:12];
            iconBtn.frame = CGRectMake(i % 5 * SCREEN_WIDTH/5, lineView.yy, SCREEN_WIDTH/5, 55 + 16.5);
            iconBtn.tag = i;
            [iconBtn addTarget:self action:@selector(ClassifyClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.headerView addSubview:iconBtn];
            
            
            UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5/2 - 20,  7.5, 40, 40)];
            [iconImg sd_setImageWithURL:[NSURL URLWithString:[imagearr[i] convertImageUrl]]];
            [iconBtn addSubview:iconImg];
            
            UILabel *iconlLbl = [UILabel labelWithFrame:CGRectMake(0,  55, SCREEN_WIDTH/5, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#666666")];
            iconlLbl.text = namearr[i];
            
            [iconBtn addSubview:iconlLbl];

   
    
    }
    UILabel *hotLable = [UILabel labelWithFrame:CGRectMake(15, lineView.yy + SCREEN_WIDTH/4, SCREEN_WIDTH - 30, 22) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:HGboldfont(16) textColor:kBlackColor];
    hotLable.text = @"热销商品";
    ;
    [self.headerView addSubview:hotLable];
}




#pragma mark------CollectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.MallGoodsModels.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MallListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MallListCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.MallGoodsModels[indexPath.row];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MallGoodDetailVC *detail = [MallGoodDetailVC new];
    detail.title = @"产品详情";
    [self.navigationController pushViewController:detail animated:YES];
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
    
    return CGSizeMake((SCREEN_WIDTH - 45)/2, (SCREEN_WIDTH - 45)/2/330*230 + 111);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/750*300  + SCREEN_WIDTH/4 + 149);
    
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MallStoreHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
//    [headerView addSubview:self.headerView];
    headerView.imageArraay = self.imageArraay;
    headerView.str = self.introduce;
    headerView.QWCategorys = self.QWCategorys;
    headerView.treeModel = self.treeModel;
    
//    [headerView.iconBtn addTarget:self action:@selector(ClassifyClick:) forControlEvents:(UIControlEventTouchUpInside)];
    headerView.classifyclick = ^(UIButton * _Nonnull sender) {
        [self ClassifyClick:sender];
    };
    return headerView;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH,0.01);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}
#pragma mark - 分类点击事件
- (void)ClassifyClick:(UIButton *)sender
{
    NSLog(@"%ld",sender.tag);
//    MallGoodDetailVC *detail = [MallGoodDetailVC new];
//    detail.title = @"产品详情";
//    [self.navigationController pushViewController:detail animated:YES];
    
    MallGoodListViewController *list = [MallGoodListViewController new];
    list.parentCategoryCode = self.QWCategorys[sender.tag].code;
    list.shopCode = self.treeModel.shopCode;
    list.title = @"商品列表";
    [self.navigationController pushViewController:list animated:YES];
}
#pragma mark - 获取数据
-(void)getClassify{
    TLNetworking *http = [TLNetworking new];
    http.code = @"629005";
    http.showView = self.view;
    http.parameters[@"start"] = @"0";
    http.parameters[@"limit"] = @"10";
    http.parameters[@"level"] = @"1";
    http.parameters[@"type"] = @"2";
    http.parameters[@"status"] = @"1";
    http.parameters[@"orderColumn"] = @"order_no";
    http.parameters[@"orderDir"] = @"asc";
    [http postWithSuccess:^(id responseObject) {
        self.QWCategorys = [QWCategory mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
//        [self initTop];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)topImageLoadData
{
    CoinWeakSelf;
    TLNetworking *http = [TLNetworking new];
    http.code = @"630506";
    http.showView = self.view;
    http.parameters[@"shopCode"] = self.treeModel.shopCode;
    http.parameters[@"type"] = @"7";
    [http postWithSuccess:^(id responseObject) {
        
        NSArray *dataAry = responseObject[@"data"];
        if (dataAry.count > 0) {
            NSMutableArray *imageArraay = [NSMutableArray array];
            for (int i = 0; i < dataAry.count; i ++) {
                [imageArraay addObject:[dataAry[i][@"pic"] convertImageUrl]];
            }
            
            self.topImage.slImages = imageArraay;
            weakSelf.imageArraay = imageArraay;
            [self.collectionView reloadData];
        }
        
        
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)loadData
{
    
    CoinWeakSelf;
    TLNetworking *http = [TLNetworking new];
    http.code = @"630307";
    http.showView = self.view;
    http.parameters[@"code"] = self.treeModel.shopCode;
    [http postWithSuccess:^(id responseObject) {
        
        weakSelf.introduceLable.text = responseObject[@"data"][@"description"];
        weakSelf.introduce = responseObject[@"data"][@"description"];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)loadGoodsData{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629706";
    http.showView = self.view;
    http.parameters[@"start"] = @(1);
    http.parameters[@"limit"] = @(6);
    http.parameters[@"status"] = @(4);
    http.parameters[@"orderColumn"] = @"order_no";
    http.parameters[@"orderDir"] = @"asc";
    http.parameters[@"shopCode"] = self.treeModel.shopCode;
    [http postWithSuccess:^(id responseObject) {
        NSMutableArray *array = responseObject[@"data"][@"list"];
        self.MallGoodsModels = [MallGoodsModel mj_objectArrayWithKeyValuesArray:array];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
@end
