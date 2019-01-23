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
//@property (nonatomic,strong) MallHomeHeadView * Classifyview;
@property (nonatomic,strong) UIView * headview;
@property (nonatomic,strong) TLTableView * table;
@property (nonatomic,strong) UIImageView * image;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic,strong) UIImageView * backgroundimage;
@end

@implementation MallHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    self.headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/750*370 + 140 +  (SCREEN_WIDTH - 30)/690*230 + 247.5)];
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
    backBtn.title = @"首页";
    self.navigationItem.backBarButtonItem = backBtn;
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.backBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.backBtn]];
    [self.backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.table = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - kTabBarHeight )];
//    [self.table addSubview:self.headview];
    self.table.tableHeaderView = self.headview;
    [self.view addSubview:self.table];
    
    
    [self setupImage];
    [self initSearchBar];
    [self SetupClassify];
    [self SetupFootView];
    [self createbackview];
    
//    self.headview.frame = CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH - 30)/690*230 + SCREEN_WIDTH/750*370 + 247.5);
    
}

-(void)SetupFootView{
    UILabel * RecommendLab = [UILabel labelWithFrame:CGRectMake(15, self.image.yy + 15, 75, 22.5) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(16) textColor:kHexColor(@"#333333")];
    RecommendLab.text = @"热门推荐";
    [self.headview addSubview:RecommendLab];
    
    UILabel * MoreLab = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 58.5 - 15, self.image.yy + 18, 58.5, 16.5) textAligment:NSTextAlignmentRight backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
    MoreLab.text = @"查看更多";
    [self.headview addSubview:MoreLab];
    
    
    UIView * v1 = [self CreateViewWithFrame:CGRectMake(15, RecommendLab.yy + 10, (SCREEN_WIDTH - 30) / 2 , 200) GoodsNameFrame:CGRectMake(0, 26, (SCREEN_WIDTH - 30) / 2, 21) goodsname:@"杂物收纳盒" DescribeFrame:CGRectMake(0, 55, (SCREEN_WIDTH - 30) / 2, 16.5) describe:@"辅助文字辅助文字" Imageframe:CGRectMake((SCREEN_WIDTH - 30) / 2/2 - 60,55 + 16.5 + 26.5, 120, 90) ImageString:@"树 跟背景"];
    [self.headview addSubview:v1];
    
    
    UIView * v2 = [self CreateViewWithFrame:CGRectMake(v1.xx, RecommendLab.yy + 10, (SCREEN_WIDTH - 30) / 2 , 100) GoodsNameFrame:CGRectMake(10, 30.5, 85, 20) goodsname:@"杂物收纳盒" DescribeFrame:CGRectMake(10, 55.5, 85, 16.5) describe:@"辅助文字" Imageframe:CGRectMake(105, 20.5, SCREEN_WIDTH / 2 - 30 - 105, 100 - 41) ImageString:@"树 跟背景"];
    [self.headview addSubview:v2];
    
    UIView * v3 = [self CreateViewWithFrame:CGRectMake(v1.xx, v2.yy, (SCREEN_WIDTH - 30) / 2 , 100) GoodsNameFrame:CGRectMake(10, 30.5, 85, 20) goodsname:@"杂物收纳盒" DescribeFrame:CGRectMake(10, 55.5, 85, 16.5) describe:@"辅助文字" Imageframe:CGRectMake(105, 20.5, SCREEN_WIDTH / 2 - 30 - 105, 100 - 41) ImageString:@"树 跟背景"];
    [self.headview addSubview:v3];
}


#pragma 顶部view
-(void)setupImage{
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/750*370)];
    image.image = kImage(@"树 跟背景");
//    [self.view addSubview:image];
    [self.headview addSubview:image];
    self.backgroundimage = image;
}
-(void)SetupClassify{

    NSArray * ClassifyName = @[@"分类一",@"分类二",@"分类三",@"分类四",@"分类五"];

    
    for (int i = 0; i < 5; i ++) {
        UIButton *iconBtn = [UIButton buttonWithTitle:ClassifyName[i] titleColor:kHexColor(@"#666666") backgroundColor:kClearColor titleFont:12];
        iconBtn.frame = CGRectMake(i % 5 * SCREEN_WIDTH/5, self.backgroundimage.yy + 22, SCREEN_WIDTH/5, 55 + 16.5);
        [iconBtn SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:10 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(ClassifyName[i]) forState:(UIControlStateNormal)];
        }];
        iconBtn.tag = i;
        [iconBtn addTarget:self action:@selector(ClassifyClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headview addSubview:iconBtn];
    }
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, self.backgroundimage.yy + 22 + 55 + 16.5 + 21.5, SCREEN_WIDTH, 10)];
    view.backgroundColor = kLineColor;
    [self.headview addSubview:view];
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(15, SCREEN_WIDTH/750*370 + 140, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)/690*230)];
    image.image = kImage(@"树 跟背景");
    //    [self.view addSubview:image];
    [self.headview addSubview:image];
    self.image = image;
}


- (void)initSearchBar {
    UISearchBar * searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(14.5, 12, kScreenWidth-30, 31.0f)];
    searchbar.layer.cornerRadius = 15.5;
    searchbar.clipsToBounds = YES;
    searchbar.delegate = self;
//    [searchbar setAccessibilityElementsHidden:YES];
    searchbar.alpha = 0.89;
    [searchbar setBackgroundColor:kWhiteColor];
    [searchbar setTintColor:[UIColor lightGrayColor]];
    [searchbar setPlaceholder:@"搜索商品"];
//    [self.backgroundimage addSubview:searchbar];
    [self.headview addSubview:searchbar];
//    [self.headview bringSubviewToFront:searchbar];
    self.searchBar = searchbar;
    
    UITextField *searchField = [searchbar valueForKey:@"searchField"];
    
    if (searchField) {
        [[[[searchbar.subviews objectAtIndex : 0 ] subviews ] objectAtIndex : 0 ] removeFromSuperview ];
        
        searchbar.backgroundColor = kWhiteColor;
        
        
        [searchField setBackgroundColor:[UIColor whiteColor]];
        [searchField setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
        
        searchField.layer.cornerRadius = 15.5;//设置圆角具体根据实际情况来设置
        searchField.font =FONT(11);
        
//        searchField.clipsToBounds = YES;
    }
}



-(void)createbackview{
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT - 63 - kTabBarHeight - kNavigationBarHeight, 40, 40)];
    [btn setBackgroundColor:kHexColor(@"#000000") forState:UIControlStateNormal];
    btn.alpha = 0.5;
    btn.layer.cornerRadius = 20;
    btn.layer.masksToBounds = YES;
    [btn setTitle:@"返回\n氧林 " forState:UIControlStateNormal];
//    btn.font = FONT(10);
    btn.titleLabel.font = FONT(10);
    btn.titleLabel.numberOfLines = 0;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
//    [self.headview addSubview:btn];
    [btn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
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
-(void)ClassifyClick : (UIButton * )btn{
//    NSLog(@"%d",(int)btn.tag);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
//{
//    [self.view endEditing:YES];
//
//    return NO;
//
//}
@end
