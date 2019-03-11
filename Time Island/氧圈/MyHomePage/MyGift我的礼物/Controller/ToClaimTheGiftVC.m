//
//  ToClaimTheGiftVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/15.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "ToClaimTheGiftVC.h"
#import "ToClaimTheGiftTableView.h"
#import "ToClaimTheGiftVC2.h"
#import "GiftModel.h"
@interface ToClaimTheGiftVC ()<RefreshDelegate,UIWebViewDelegate,UIScrollViewDelegate>

//@property (nonatomic , strong)ToClaimTheGiftTableView *tableView;
@property (nonatomic,strong) GiftModel * giftmodel;
@property (nonatomic,strong) UIView * headerview;
@property (nonatomic,strong) UILabel * namelab;
@property (nonatomic,strong) UILabel * pricelab;
@property (nonatomic,strong) UIImageView * image;
@property (nonatomic,strong) UIWebView * webview;

@end

@implementation ToClaimTheGiftVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getdata];
}
//- (ToClaimTheGiftTableView *)tableView {
//
//    if (!_tableView) {
//
//        _tableView = [[ToClaimTheGiftTableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH,SCREEN_HEIGHT -kNavigationBarHeight - kHeight(65)) style:UITableViewStyleGrouped];
//
//        _tableView.refreshDelegate = self;
//        _tableView.backgroundColor = kWhiteColor;
//        //        [self.view addSubview:_tableView];
//    }
//    return _tableView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.title = @"礼物详情";
//    [self.view addSubview:self.tableView];
//    [self BottomView];
    self.view.backgroundColor = kWhiteColor;
    
    
//    UIWebView * webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
//
//    webview.delegate = self;
//    webview.scrollView.delegate = self;
//    webview.scrollView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
//    webview.scrollView.contentOffset= CGPointMake(0, -150);
////    [webview.scrollView addSubview:self.headerview];
//    [self.view addSubview:webview];
//    self.webview = webview;
    
    
    
    
}
-(void)createheaderview{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, -240, SCREEN_WIDTH, 240)];
    view.backgroundColor = kWhiteColor;
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    [view addSubview:image];
    self.image = image;
    
    UILabel * name = [UILabel labelWithFrame:CGRectMake(15, 150, SCREEN_WIDTH / 2 - 15, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(17) textColor:kBlackColor];
    [view addSubview:name];
    self.namelab = name;
    
    UILabel * price = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH / 2, 150, SCREEN_WIDTH / 2 - 15, 50) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(17) textColor:kBlackColor];
    [view addSubview:price];
    self.pricelab = price;
    
    UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15, 200, SCREEN_WIDTH - 30, 1)];
    v1.backgroundColor = kLineColor;
    [view addSubview:v1];
    
    UIView * v2 = [[UIView alloc]initWithFrame:CGRectMake(15, 215, 3, 15)];
    v2.backgroundColor = kTabbarColor;
    [view addSubview:v2];
    
    UILabel * label = [UILabel labelWithFrame:CGRectMake(20, 215, SCREEN_WIDTH - 50, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(17) textColor:kBlackColor];
    label.text = @"图文详情";
    [view addSubview:label];
    
    
    
    self.headerview = view;
}

-(void)BottomView
{
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kNavigationBarHeight - kHeight(65), SCREEN_WIDTH, kHeight(65))];
    bottomView.backgroundColor = kWhiteColor;
    [self.view addSubview:bottomView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = kLineColor;
    [bottomView addSubview:lineView];
    
    
    UIButton *confirmBtn = [UIButton buttonWithTitle:@"认领礼物" titleColor:kWhiteColor backgroundColor:kHexColor(@"#23AD8C") titleFont:16];
    confirmBtn.frame = CGRectMake(kWidth(15),lineView.y + kHeight(10), SCREEN_WIDTH - kWidth(30), kHeight(45));
    kViewRadius(confirmBtn, 4);
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:confirmBtn];
}

-(void)confirmBtnClick
{
    ToClaimTheGiftVC2 *vc = [ToClaimTheGiftVC2 new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getdata{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629326";
    http.parameters[@"code"] = self.code;
    [http postWithSuccess:^(id responseObject) {
        self.giftmodel = [GiftModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self createheaderview];
        
        UIWebView * webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
        webview.delegate = self;
        webview.scrollView.delegate = self;
        webview.scrollView.contentInset = UIEdgeInsetsMake(240, 0, 0, 0);
        webview.scrollView.contentOffset= CGPointMake(0, -150);
        [webview.scrollView addSubview:self.headerview];
        [self.view addSubview:webview];
        self.webview = webview;
        
        self.namelab.text = self.giftmodel.name;
        self.pricelab.text = [NSString stringWithFormat:@"¥%.2f", [self.giftmodel.price floatValue]/1000];
        self.pricelab.textColor = kTabbarColor;
        [self.image sd_setImageWithURL:[NSURL URLWithString:[self.giftmodel.listPic convertImageUrl]]];
        NSLog(@"123%@",self.giftmodel.Description);
        [self.webview loadHTMLString:self.giftmodel.Description baseURL:nil];
    } failure:^(NSError *error) {
        
    }];
}

@end
