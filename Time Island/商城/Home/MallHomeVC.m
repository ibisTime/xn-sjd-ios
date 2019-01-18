//
//  MallHomeVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/18.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MallHomeVC.h"
#import "GoodsListVC.h"
#import "MallHomeHeadView.h"
@interface MallHomeVC ()
@property (nonatomic,strong) MallHomeHeadView * Classifyview;
@property (nonatomic,strong) UIView * headview;
@property (nonatomic,strong) TLTableView * table;
@property (nonatomic,strong) UIImageView * image;
@end

@implementation MallHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    self.headview = [[UIView alloc]init];
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
    backBtn.title = @"首页";
    self.navigationItem.backBarButtonItem = backBtn;
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.backBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.backBtn]];
    [self.backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.Classifyview = [[MallHomeHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    [self.headview addSubview:self.Classifyview];
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, self.Classifyview.yy, SCREEN_WIDTH, 10)];
    view.backgroundColor = kLineColor;
    [self.headview addSubview:view];
    
    
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 325, SCREEN_WIDTH - 30, 115)];
    image.image = kImage(@"邮政银行");
//    [self.view addSubview:image];
    [self.headview addSubview:image];
    self.image = image;
    
    [self SetupFootView];
    
    
    self.table = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT + 64)];
    [self.table addSubview:self.headview];
    [self.view addSubview:self.table];
}


-(void)SetupFootView{
    UILabel * RecommendLab = [UILabel labelWithFrame:CGRectMake(15, self.image.yy + 15, 75, 22.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(16) textColor:kHexColor(@"#333333")];
    RecommendLab.text = @"热门推荐";
    [self.headview addSubview:RecommendLab];
    
    UILabel * MoreLab = [UILabel labelWithFrame:CGRectMake(RecommendLab.xx + 221.5, self.image.yy + 18, 58.5, 16.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
    MoreLab.text = @"查看更多";
    [self.headview addSubview:MoreLab];
    
    
    
    UIView * v1 = [self CreateViewWithFrame:CGRectMake(15, RecommendLab.yy + 10, SCREEN_WIDTH / 2 - 30, 200) GoodsNameFrame:CGRectMake(0, 26, 172.5, 21) goodsname:@"杂物收纳盒" DescribeFrame:CGRectMake(0, 55, 172.5, 16.5) describe:@"辅助文字辅助文字" Imageframe:CGRectMake(26.5,55 + 16.5 + 1, 172.5 - 53, 200 - 55 - 16.5 - 1) ImageString:@"邮政银行"];
    [self.headview addSubview:v1];
    
    UIView * v2 = [self CreateViewWithFrame:CGRectMake(v1.xx, RecommendLab.yy + 10, SCREEN_WIDTH / 2 - 30, 100) GoodsNameFrame:CGRectMake(10, 30.5, 85, 20) goodsname:@"杂物收纳盒" DescribeFrame:CGRectMake(10, 55.5, 85, 16.5) describe:@"辅助文字" Imageframe:CGRectMake(105, 20.5, SCREEN_WIDTH / 2 - 30 - 105, 100 - 41) ImageString:@"邮政银行"];
    [self.headview addSubview:v2];
    
    UIView * v3 = [self CreateViewWithFrame:CGRectMake(v1.xx, v2.yy, SCREEN_WIDTH / 2 - 30, 100) GoodsNameFrame:CGRectMake(10, 30.5, 85, 20) goodsname:@"杂物收纳盒" DescribeFrame:CGRectMake(10, 55.5, 85, 16.5) describe:@"辅助文字" Imageframe:CGRectMake(105, 20.5, SCREEN_WIDTH / 2 - 30 - 105, 100 - 41) ImageString:@"邮政银行"];
    [self.headview addSubview:v3];
}

-(UIView * )CreateViewWithFrame : (CGRect)viewframe
                 GoodsNameFrame : (CGRect) goodsframe
                      goodsname : (NSString * )goodsname
                  DescribeFrame : (CGRect)describeframe
                       describe : (NSString * )describe
                     Imageframe : (CGRect)imageframe
                    ImageString : (NSString *)imagestring{
    
    UIView * view = [[UIView alloc]initWithFrame:viewframe];
    view.backgroundColor = kClearColor;
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = kLineColor.CGColor;
    
    UILabel * GoodsName = [UILabel labelWithFrame:goodsframe textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(15) textColor:[UIColor blackColor]];
    GoodsName.text = goodsname;
    [view addSubview:GoodsName];
    
    UILabel * DescribeLab = [UILabel labelWithFrame:describeframe textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(12) textColor:kTextColor];
    DescribeLab.text = describe;
    [view addSubview:DescribeLab];
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:imageframe];
    image.image = kImage(imagestring);
    [view addSubview:image];
    
    
    return view;
}

-(void)backBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
