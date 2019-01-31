//
//  BoolVideoDetailVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BoolVideoDetailVC.h"
#import "BookDetailHeadView.h"
#import "BookDetailContentView.h"
@interface BoolVideoDetailVC ()
@property (nonatomic , strong) BookDetailHeadView *headView;
@property (nonatomic,strong) BookDetailContentView * ContentView;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) UIButton * CollectBtn;
@property (nonatomic,strong) UIButton * ZanBtn;
@end

@implementation BoolVideoDetailVC
-(void)viewWillAppear:(BOOL)animated{
    [self check];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.headView = [[BookDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    self.headView.BookModel = self.BookModel;
    self.ContentView = [[BookDetailContentView alloc]initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, SCREEN_HEIGHT - 150 - 64 - 50)];
    self.ContentView.BookModel = self.BookModel;
    [self.view addSubview:self.headView];
    [self.view addSubview:self.ContentView];
    
    [self CreateFootView];
}
-(void)CreateFootView{
    [self CreateViewWithFrame:CGRectMake(15, self.ContentView.yy - 1, SCREEN_WIDTH - 30, 1)];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, self.ContentView.yy, SCREEN_WIDTH, 50)];
    
    
    UIButton * CollectBtn = [UIButton buttonWithTitle:@"" titleColor:kTextColor3 backgroundColor:kClearColor titleFont:12 cornerRadius:0];
    [CollectBtn setTitle: self.BookModel.collectCount forState:UIControlStateNormal];
    CollectBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH / 2, 50);
    [CollectBtn SG_imagePositionStyle:SGImagePositionStyleDefault spacing:4 imagePositionBlock:^(UIButton *button) {
        [button setImage: kImage(@"收藏（未点击）") forState:UIControlStateNormal];
        [button setImage:kImage(@"收藏（点击）") forState:UIControlStateSelected];
    }];
    [CollectBtn addTarget:self action:@selector(CollectBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:CollectBtn];
    self.CollectBtn = CollectBtn;
    
    
    [self CreateViewWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 1, self.ContentView.yy + 15, 1, 20)];
    
    UIButton * ZanBtn = [UIButton buttonWithTitle:@"" titleColor:kTextColor3 backgroundColor:kClearColor titleFont:12 cornerRadius:0];
    [ZanBtn setTitle: self.BookModel.pointCount forState:UIControlStateNormal];
    ZanBtn.frame = CGRectMake(SCREEN_WIDTH / 2 + 1, 0, SCREEN_WIDTH / 2, 50);
    [ZanBtn SG_imagePositionStyle:SGImagePositionStyleDefault spacing:4 imagePositionBlock:^(UIButton *button) {
        [button setImage: kImage(@"点赞（未点击）") forState:UIControlStateNormal];
        [button setImage:kImage(@"点赞（点击）") forState:UIControlStateSelected];
    }];
    [ZanBtn addTarget:self action:@selector(ZanBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:ZanBtn];
    self.ZanBtn = ZanBtn;
    

    [self.view addSubview:view];
    
    
    
    
    
    
    
}


-(void)CollectBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629811";
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"code"] = self.BookModel.code;
    self.count = [self.BookModel.collectCount integerValue];
    [http postWithSuccess:^(id responseObject) {
        
        if (sender.selected == YES) {
            self.count = self.count + 1;
            [sender setTitle: [NSString stringWithFormat:@"%d",(int)self.count] forState:(UIControlStateNormal)];
        }else
        {
            [sender setTitle: [NSString stringWithFormat:@"%d",(int)self.count] forState:(UIControlStateNormal)];
        }
        
    } failure:^(NSError *error) {
    }];
}
-(void)ZanBtnClick:(UIButton * )sender{
    sender.selected = !sender.selected;
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629810";
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"code"] = self.BookModel.code;
    self.count = [self.BookModel.collectCount integerValue];
    [http postWithSuccess:^(id responseObject) {
        
        if (sender.selected == YES) {
            self.count = self.count + 1;
            [sender setTitle: [NSString stringWithFormat:@"%d",(int)self.count] forState:(UIControlStateNormal)];
        }else
        {
            [sender setTitle: [NSString stringWithFormat:@"%d",(int)self.count] forState:(UIControlStateNormal)];
        }
        
    } failure:^(NSError *error) {
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)CreateViewWithFrame:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kLineColor;
    [self.view addSubview:view];
}
-(void)check{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629348";
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"code"] = self.BookModel.code;
    http.parameters[@"type"] = @(1);
    [http postWithSuccess:^(id responseObject) {
        if ([responseObject[@"data"][@"isPointCollect"] isEqualToString:@"1"]) {
            self.ZanBtn.selected = YES;
        }
    } failure:^(NSError *error) {
    }];
    
//    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629348";
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"code"] = self.BookModel.code;
    http.parameters[@"type"] = @(2);
    [http postWithSuccess:^(id responseObject) {
        if ([responseObject[@"data"][@"isPointCollect"] isEqualToString:@"1"]) {
            self.CollectBtn.selected = YES;
        }
    } failure:^(NSError *error) {
    }];
    
}
@end
