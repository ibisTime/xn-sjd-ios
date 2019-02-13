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
@interface MallStoreListVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    
    
}

@property (nonatomic,strong) SLBannerView *topImage;
@property (nonatomic,strong) UIImageView * headImage;
@property (nonatomic,strong) UILabel *nameLable;
@property (nonatomic,strong) UILabel *introduceLable;
@property (nonatomic,strong) UIView * headerView;
@property (nonatomic,strong) UICollectionView *collectionView;
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
         [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
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
    [self initTop];
    [self.view addSubview:self.collectionView];
    [self loadData];
    [self topImageLoadData];
}




- (void)initTop
{
//    UIImageView * topImage;
//    UIImageView * headImage;
//    UILabel *nameLable;
//    UILabel *introduceLable;
    
    
    _topImage = [SLBannerView bannerView];
    _topImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/750*300);
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
    
    NSArray * ClassifyName = @[@"分类一",@"分类二",@"分类三",@"分类四"];
    
    
    for (int i = 0; i < 4; i ++) {
        UIButton *iconBtn = [UIButton buttonWithTitle:ClassifyName[i] titleColor:kHexColor(@"#666666") backgroundColor:kClearColor titleFont:12];
        iconBtn.frame = CGRectMake(i % 4 * SCREEN_WIDTH/4, lineView.yy, SCREEN_WIDTH/4, SCREEN_WIDTH/4);
        [iconBtn SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:10 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(ClassifyName[i]) forState:(UIControlStateNormal)];
        }];
        iconBtn.tag = i;
        [iconBtn addTarget:self action:@selector(ClassifyClick) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:iconBtn];
    }
    
    UILabel *hotLable = [UILabel labelWithFrame:CGRectMake(15, lineView.yy + SCREEN_WIDTH/4, SCREEN_WIDTH - 30, 22) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:HGboldfont(16) textColor:kBlackColor];
    hotLable.text = @"热销商品";
    ;
    [self.headerView addSubview:hotLable];
    
}

-(void)topImageLoadData
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"630506";
    http.parameters[@"shopCode"] = self.treeModel.shopCode;
    http.parameters[@"type"] = @"7";
    [http postWithSuccess:^(id responseObject) {
        
        NSArray *dataAry = responseObject[@"data"];
        NSMutableArray *imageArraay = [NSMutableArray array];
        for (int i = 0; i < dataAry.count; i ++) {
            [imageArraay addObject:[dataAry[i][@"pic"] convertImageUrl]];
        }
        
        self.topImage.slImages = imageArraay;
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)loadData
{
    
    
    TLNetworking *http = [TLNetworking new];
    http.code = @"630307";
    http.parameters[@"code"] = self.treeModel.shopCode;
    [http postWithSuccess:^(id responseObject) {
        
        _introduceLable.text = responseObject[@"data"][@"description"];
        
    } failure:^(NSError *error) {
       
    }];
}

- (void)ClassifyClick
{
    MallGoodDetailVC *detail = [MallGoodDetailVC new];
    detail.title = @"产品详情";
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark------CollectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MallListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MallListCollectionViewCell" forIndexPath:indexPath];
    
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
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    [headerView addSubview:self.headerView];
    
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
