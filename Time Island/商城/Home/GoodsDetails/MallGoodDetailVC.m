//
//  MallGoodDetailVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallGoodDetailVC.h"
#import "PushSelectScrollView.h"
#import "MallGoodIntroduceVC.h"
#import "MallGoodDetailView.h"
#import "MallCommentTB.h"
#import "GoodsDetailWebView.h"
#import "GoodsEditVC.h"
#import "GoodsBottomView.h"
#import "MallStoreListVC.h"
#import "ChoseGoodsTypeAlert.h"
#import "JXUIKit.h"
#import "GoodsModel.h"
#import "GoodsPriceModel.h"
#import "GoodsTypeModel.h"
#import "SubmitOrdersVC.h"
#import "ReceivingAddressVC.h"
@interface MallGoodDetailVC ()<RefreshDelegate>
{
    GoodsModel *model;
}
@property (nonatomic , strong) PushSelectScrollView *selectSV;

@property (nonatomic,strong) NSArray * itemsTitles;

@property (nonatomic,strong) MallGoodDetailView * detailView;

@property (nonatomic,strong) MallCommentTB * commentTB;

@property (nonatomic,strong) UIScrollView * contentView;

@property (nonatomic,strong) GoodsBottomView * bottomView;

@property (nonatomic,strong) MallStoreListVC * storeVc;


@property (nonatomic,strong) MallGoodIntroduceVC * bookVC;

@property (nonatomic,strong) GoodsDetailWebView * goodDetailVC;

@property (nonatomic,strong) GoodsEditVC * editVC;
@end

@implementation MallGoodDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    self.itemsTitles = @[@"商品",@"图文详情",@"评价"];
    
    self.selectSV = [[PushSelectScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSuperViewHeight - kTabBarHeight) itemTitles:self.itemsTitles];
    [self.view addSubview:self.selectSV];
    [self initBottomView];
    for (NSInteger index = 0; index < self.itemsTitles.count; index ++) {
        if (index == 0) {
            MallGoodIntroduceVC * bookview = [[MallGoodIntroduceVC alloc] init];
            bookview.treeModel = self.treeModel;

            bookview.title = self.itemsTitles[index];
            [self addChildViewController:bookview];
            self.bookVC = bookview;
            bookview.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            [self.selectSV.scrollView addSubview:bookview.view];
        }else if (index ==1)
        {
            GoodsDetailWebView * bookview = [[GoodsDetailWebView alloc] init];
            bookview.htmlStr = self.treeModel.Description;

            bookview.title = self.itemsTitles[index];
            [self addChildViewController:bookview];
            bookview.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            self.goodDetailVC = bookview;
            [self.selectSV.scrollView addSubview:bookview.view];
        }else{
            GoodsEditVC * bookview = [[GoodsEditVC alloc] init];
            bookview.title = self.itemsTitles[index];
            [self addChildViewController:bookview];
            bookview.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kSuperViewHeight  - kTabBarHeight);
            self.editVC = bookview;
            bookview.treeModel = self.treeModel;
            [self.selectSV.scrollView addSubview:bookview.view];
        }
    }
    [self initBottomView];
    [self initTestModel];
//    [self loadData];
    
}
//- (void)loadData{
//    TLNetworking *http = [TLNetworking new];
//    http.code = @"629707";
//    http.parameters[@"code"] = self.code;
//    [http postWithSuccess:^(id responseObject) {
//        self.treeModel = [MallTreeModel mj_objectWithKeyValues:responseObject[@"data"]];
//        NSLog(@"%@",responseObject);
//    } failure:^(NSError *error) {
//
//    }];
//
//}
- (void)initTestModel{
    model = [[GoodsModel alloc] init];
    model.imageId = [self.treeModel.bannerPic convertImageUrl];
    model.goodsNo = self.treeModel.name;
    model.title = @"商品标题";
    //价格信息
    model.price = [[GoodsPriceModel alloc] init];
    model.price.minPrice = self.treeModel.specsList[0][@"price"];
    //属性-应该从服务器获取属性列表
    GoodsTypeModel *type = [[GoodsTypeModel alloc] init];
    type.selectIndex = 0;
    type.typeName = @"规格分类";
    type.typeArray = [NSMutableArray array];
    for (int i = 0; i < self.treeModel.specsList.count; i++) {
        [type.typeArray addObject:self.treeModel.specsList[i][@"name"]];
    }
   
    model.itemsList = @[type];
    
    //属性组合数组-有时候不同的属性组合价格库存都会有差异，选择完之后要对应修改商品的价格、库存图片等信息，可能是获得商品信息时将属性数组一并返回，也可能属性选择后再请求服务器获得属性组合对应的商品信息，根据自己的实际情况调整
    model.sizeAttribute = [[NSMutableArray alloc] init];
    NSArray *valueArr = [type.typeArray copy];
    for (int i = 0; i<self.treeModel.specsList.count; i++) {
        SizeAttributeModel *type = [[SizeAttributeModel alloc] init];
        type.price = self.treeModel.specsList[i][@"price"];
        type.originalPrice = self.treeModel.specsList[i][@"price"];
        type.stock = [NSString stringWithFormat:@"%@", self.treeModel.specsList[i][@"inventory"]];
        type.goodsNo = self.treeModel.specsList[i][@"name"];
        type.code = self.treeModel.specsList[i][@"code"];
        type.id = self.treeModel.specsList[i][@"id"];
        type.inventory = self.treeModel.specsList[i][@"inventory"];
        type.commodityCode = self.treeModel.specsList[i][@"commodityCode"];

        type.imageId =[NSString stringWithFormat:@"%@",self.treeModel.bannerPic];
        [model.sizeAttribute addObject:type];
    }
    self.bookVC.model = model;
}
- (void)initDetailView
{
    self.detailView = [[MallGoodDetailView alloc] initWithFrame:CGRectMake(0, 45, kScreenWidth, SCREEN_HEIGHT - kTabBarHeight-kNavigationBarHeight)];
    [self.view addSubview:self.detailView];
    
    self.commentTB = [[MallCommentTB alloc] initWithFrame:CGRectMake(0, self.detailView.yy, kScreenWidth, kScreenHeight)];
    [self.view addSubview:self.commentTB];
    self.commentTB.refreshDelegate = self;
    CoinWeakSelf;
    self.commentTB.clickMoreBlock = ^{
        [weakSelf loadMoreComment];
    };
    
}

- (void)initBottomView
{
    self.bottomView = [[GoodsBottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight-kTabBarHeight-kNavigationBarHeight, kScreenWidth, kTabBarHeight)];
    [self.view addSubview:self.bottomView];
    CoinWeakSelf;
    self.bottomView.clickMoreBlock = ^(NSInteger inter) {
        [weakSelf clickWithTag:inter];
    };
    
}
- (void)clickWithTag:(NSInteger)inter
{
    switch (inter) {
        case 1:
            //点击店铺
            [self goToStoreListVC];
            break;
        case 2:
            //点击客服

            break;
        case 3:
            //点击加入购物车
            break;
        case 4:
            //点击加入购买
            [self clickShoppingCard];

            break;
        default:
            break;
    }
    
}

- (void)clickShoppingCard
{
    ChoseGoodsTypeAlert *_alert = [[ChoseGoodsTypeAlert alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andHeight:kHeight(450)];
    _alert.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:_alert];
    CoinWeakSelf;
    _alert.selectSize = ^(SizeAttributeModel *sizeModel, NSInteger inter) {
        //sizeModel 选择的属性模型
        [JXUIKit showSuccessWithStatus:[NSString stringWithFormat:@"选择了：%@",sizeModel.goodsNo]];
        [weakSelf sumbitOrderWithTag:inter];
    };
    [_alert initData:model];
    [_alert showView];
    
    
}

- (void)sumbitOrderWithTag:(NSInteger)tag
{
    if (tag ==100) {
        //购物车
    }else{
        SubmitOrdersVC *orderVc = [SubmitOrdersVC new];
        orderVc.title = @"确认订单";
        [self.navigationController pushViewController:orderVc animated:YES];
    }
   
}

- (void)goToStoreListVC
{
    MallStoreListVC *store = [MallStoreListVC new];
    store.title = @"商铺";
    store.treeModel = self.treeModel;
    [self.navigationController pushViewController:store animated:YES];
    
}
- (void)loadMoreComment
{
    
    
}

@end
