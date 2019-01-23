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
@interface MallStoreListVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UIView * headerView;
@property (nonatomic,strong) UIImageView * image;
@property (nonatomic,strong) UIImageView * backgroundimage;
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
        
        CoinWeakSelf;
        //头部
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/750*370 + 140 +  (SCREEN_WIDTH - 30)/690*230 + 247.5)];
       
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupImage];
    [self SetupClassify];
    [self initTop];
    [self.view addSubview:self.collectionView];
    
}

- (void)initTop
{
    UILabel *titltLab = [UILabel labelWithFrame:CGRectMake((kScreenWidth-130)/2, self.image.yy+10, kWidth(130), 22) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(16) textColor:kBlackColor];
    titltLab.text = @"商铺名称";
    [titltLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [self.headerView addSubview:titltLab];
    UILabel *introduceLab = [UILabel labelWithFrame:CGRectMake(kWidth(130)/2, titltLab.yy+5, (kScreenWidth-130), 22) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
    introduceLab.text = @"十年老店十年老店十年老店十年老店十年老店";
    [self.headerView addSubview:introduceLab];
    introduceLab.centerX = titltLab.centerX;
}
-(void)setupImage{
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/750*kHeight(150))];
    image.image = kImage(@"树 跟背景");
    //    [self.view addSubview:image];
    [self.headerView addSubview:image];
    self.backgroundimage = image;
    UIImageView * image1 = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-80)/2, self.backgroundimage.yy-40, 80, 80)];
    image1.layer.cornerRadius = 40;
    image1.clipsToBounds = YES;
    image1.image = kImage(@"我的背景");
    //    [self.view addSubview:image];
    [self.headerView addSubview:image1];
    self.image = image1;
}
-(void)SetupClassify{
    
    NSArray * ClassifyName = @[@"分类一",@"分类二",@"分类三",@"分类四"];
    
    
    for (int i = 0; i < 4; i ++) {
        UIButton *iconBtn = [UIButton buttonWithTitle:ClassifyName[i] titleColor:kHexColor(@"#666666") backgroundColor:kClearColor titleFont:12];
        iconBtn.frame = CGRectMake(i % 4 * SCREEN_WIDTH/4, self.image.yy + kHeight(100), SCREEN_WIDTH/4, 55 + 16.5);
        [iconBtn SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:10 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(ClassifyName[i]) forState:(UIControlStateNormal)];
        }];
        iconBtn.tag = i;
        [iconBtn addTarget:self action:@selector(ClassifyClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:iconBtn];
    }
    
    UILabel *hotLable = [UILabel labelWithFrame:CGRectMake(15, self.image.yy + kHeight(100)+kHeight(55 + 16.5)+5, kWidth(130), 22) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(16) textColor:kBlackColor];
    hotLable.text = @"热销商品";
    [hotLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [self.headerView addSubview:hotLable];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, self.backgroundimage.yy + 22 + 55 + 16.5 + 21.5, SCREEN_WIDTH, 10)];
    view.backgroundColor = kLineColor;
    [self.headerView addSubview:view];
    
    
}

#pragma mark------CollectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MallListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MallListCollectionViewCell" forIndexPath:indexPath];
    
    if (indexPath.row % 2 == 0) {
        cell.backView.frame = CGRectMake(12, 0, (SCREEN_WIDTH - 30)/2, kHeight(226));
    }else
    {
        cell.backView.frame = CGRectMake(3, 0, (SCREEN_WIDTH - 30)/2, kHeight(226));
    }
    
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MallGoodDetailVC *detail = [MallGoodDetailVC new];
    detail.title = @"产品详情";
    [self.navigationController pushViewController:detail animated:YES];
    //    GoodsDetailsVc *detailVC = [GoodsDetailsVc new];
    //    //    detailVC.title = @"古树详情";
    //    //    detailVC.mineModel = self.models[indexPath.row];
    //    [self.navigationController pushViewController:detailVC animated:YES];
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
    
    return CGSizeMake((SCREEN_WIDTH - 1)/2, kHeight(226));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/750*370+(SCREEN_WIDTH - 30)/690*230);
    
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
    return UIEdgeInsetsMake(0.1, 0.1, 0.1, 0.1);
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
