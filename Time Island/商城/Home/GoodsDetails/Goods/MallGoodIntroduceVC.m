//
//  MallGoodIntroduceVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallGoodIntroduceVC.h"
#import "PushSelectScrollView.h"
#import "MallGoodIntroduceVC.h"
#import "MallGoodDetailView.h"
#import "MallCommentTB.h"
#import "ChoseGoodsTypeAlert.h"
#import "SizeAttributeModel.h"
#import "SubmitOrdersVC.h"
#import "JXUIKit.h"
#import "SLBannerView.h"
#import "MallGoodIntroduceTableView.h"
#import "EvaluationModel.h"
@interface MallGoodIntroduceVC ()<RefreshDelegate>
@property (nonatomic , strong) PushSelectScrollView *selectSV;

@property (nonatomic,strong) NSArray * itemsTitles;

@property (nonatomic,strong) MallGoodDetailView * detailView;

@property (nonatomic,strong) MallCommentTB * commentTB;

@property (nonatomic,strong) UIScrollView * contentView;

@property (nonatomic , strong)SLBannerView *banner;
@property (nonatomic , strong)MallGoodIntroduceTableView *tableView;
@property (nonatomic , strong)NSMutableArray <EvaluationModel *>*evaluationModel;

@end

@implementation MallGoodIntroduceVC

-(SLBannerView *)banner
{
    if (!_banner) {
        //        NSLog(@"%@",self.TreeModels[0].bannerPic);
        _banner = [SLBannerView bannerView];
        _banner.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH / 750 * 530);
        //工程图片
        _banner.slImages = _treeModel.bannerPics;

    }
    return _banner;
}

- (MallGoodIntroduceTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[MallGoodIntroduceTableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, kSuperViewHeight - kTabBarHeight - 45) style:UITableViewStyleGrouped];
        
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kBackgroundColor;
        _tableView.treeModel = self.treeModel;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initDetailView];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.banner;
    [self loadData];
    
    // Do any additional setup after loading the view.
}



//- (void)initDetailView{
//    self.contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight)];
//    [self.view addSubview:self.contentView];
//    self.contentView.scrollEnabled = YES;
//
//
//    self.detailView = [[MallGoodDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSuperViewHeight - kTabBarHeight-(kHeight(40+30+10)))];
//    self.detailView.treeModel  =  self.treeModel;
//    CoinWeakSelf;
//    self.detailView.CategoryBlock = ^{
//        [weakSelf clickShoppingCard];
//    };
//    [self.contentView addSubview:self.detailView];
//    self.commentTB = [[MallCommentTB alloc] initWithFrame:CGRectMake(0, self.detailView.yy, kScreenWidth, kScreenHeight)];
//    [self.contentView addSubview:self.commentTB];
//    self.commentTB.refreshDelegate = self;
//    self.contentView.contentSize = CGSizeMake(0, self.commentTB.yy+100);
//}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        ChoseGoodsTypeAlert *_alert = [[ChoseGoodsTypeAlert alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andHeight:kHeight(450)];
        _alert.alpha = 0;
        [[UIApplication sharedApplication].keyWindow addSubview:_alert];
        CoinWeakSelf;
//        _alert.selectSize = ^(SizeAttributeModel *sizeModel, NSInteger inter) {
//            //sizeModel 选择的属性模型
//            [JXUIKit showSuccessWithStatus:[NSString stringWithFormat:@"选择了：%@",sizeModel.goodsNo]];
//            [weakSelf sumbitOrderWithIndex:inter];
//        };
        _alert.selectSize = ^(SizeAttributeModel *sizeModel, NSInteger inter, NSInteger count,int selectnum) {
            [JXUIKit showSuccessWithStatus:[NSString stringWithFormat:@"选择了：%@",sizeModel.goodsNo]];
            [weakSelf sumbitOrderWithIndex:inter];
        };
        [_alert initData:self.model];
        [_alert showView];
    }
}

- (void)loadData{
    TLNetworking *http = [TLNetworking new];
    http.code = @"629755";
    http.parameters[@"start"] = @"1";
    http.parameters[@"limit"] = @"10";
    http.parameters[@"statusList"] = @[@"D",@"B"];
    http.parameters[@"commodityCode"] = self.treeModel.code;
//    http.parameters[@"code"] = self.code;
    [http postWithSuccess:^(id responseObject) {
        self.evaluationModel = [EvaluationModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        NSLog(@"%@",responseObject);
        self.tableView.evaluationModel = self.evaluationModel;
        [self.tableView reloadData];
    } failure:^(NSError *error) {

    }];

}

- (void)sumbitOrderWithIndex:(NSInteger)tag
{
    if (tag == 100) {
        //购物车
    }else{
        SubmitOrdersVC *orderVc = [SubmitOrdersVC new];
        orderVc.title = @"确认订单";
        [self.navigationController pushViewController:orderVc animated:YES];
    }
  
}



@end
