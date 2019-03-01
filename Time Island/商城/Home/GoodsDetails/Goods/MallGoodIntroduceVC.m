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
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) NSString * size;
@property (nonatomic,assign) int selectnum;
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
    CoinWeakSelf;
    weakSelf.tableView.more = ^{
        if (weakSelf.clickmore) {
            weakSelf.clickmore();
        }
    };
    [self loadData];
    
    // Do any additional setup after loading the view.
}





-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        ChoseGoodsTypeAlert *_alert = [[ChoseGoodsTypeAlert alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andHeight:kHeight(450)];
        _alert.alpha = 0;
        [[UIApplication sharedApplication].keyWindow addSubview:_alert];
        CoinWeakSelf;
        _alert.selectSize = ^(SizeAttributeModel *sizeModel, NSInteger inter, NSInteger count,int selectnum) {
            [JXUIKit showSuccessWithStatus:[NSString stringWithFormat:@"选择了：%@",sizeModel.goodsNo]];
            weakSelf.count = count;
            weakSelf.size = sizeModel.goodsNo;
            weakSelf.selectnum = selectnum;
            [weakSelf sumbitOrderWithIndex:inter];
        };
        [_alert initData:self.model];
        [_alert showView];
    }
}

- (void)loadData{
//    TLNetworking *http = [TLNetworking new];
//    http.code = @"629755";
//    http.parameters[@"start"] = @"1";
//    http.parameters[@"limit"] = @"10";
//    http.parameters[@"statusList"] = @[@"D",@"B"];
//    http.parameters[@"commodityCode"] = self.treeModel.code;
////    http.parameters[@"code"] = self.code;
//    [http postWithSuccess:^(id responseObject) {
//        self.evaluationModel = [EvaluationModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
//        NSLog(@"%@",responseObject);
//        self.tableView.evaluationModel = self.evaluationModel;
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//
//    }];
    CoinWeakSelf;
    TLPageDataHelper * http = [TLPageDataHelper new];
    http.code = @"629755";
    http.parameters[@"statusList"] = @[@"D",@"B"];
    http.parameters[@"commodityCode"] = self.treeModel.code;
    [http modelClass:[EvaluationModel class]];
    http.showView = self.view;
    http.tableView = self.tableView;
    http.isCurrency = YES;
    [self.tableView addRefreshAction:^{
        [http refresh:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.tableView.evaluationModel = objs;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView endRefreshHeader];
        } failure:^(NSError *error) {
            [weakSelf.tableView endRefreshHeader];
        }];
    }];
    [self.tableView addLoadMoreAction:^{
        [http loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.tableView.evaluationModel = objs;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView endRefreshFooter];
        } failure:^(NSError *error) {
            [weakSelf.tableView endRefreshFooter];
        }];
    }];
    [self.tableView beginRefreshing];
    

}

- (void)sumbitOrderWithIndex:(NSInteger)tag
{
//    if (tag == 100) {
//        //购物车
//    }else{
//        SubmitOrdersVC *orderVc = [SubmitOrdersVC new];
//        orderVc.title = @"确认订单";
//        [self.navigationController pushViewController:orderVc animated:YES];
//    }
    if (tag ==100) {
        //购物车
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"629710";
        http.parameters[@"userId"] = [TLUser user].userId;
        http.parameters[@"commodityCode"] = self.treeModel.code;
        http.parameters[@"commodityName"] = self.treeModel.name;
        http.parameters[@"specsId"] = self.treeModel.specsList[self.selectnum][@"id"];
        http.parameters[@"specsName"] = self.treeModel.specsList[self.selectnum][@"name"];
        http.parameters[@"quantity"] = @(self.count);
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"加入购物车成功"];
        } failure:^(NSError *error) {
            
        }];
    }else{
        SubmitOrdersVC *orderVc = [SubmitOrdersVC new];
        orderVc.MallGoodsModel = self.treeModel;
        orderVc.count = self.count;
        orderVc.size = self.size;
        orderVc.selectnum = self.selectnum;
        [self.navigationController pushViewController:orderVc animated:YES];
    }
  
}



@end
