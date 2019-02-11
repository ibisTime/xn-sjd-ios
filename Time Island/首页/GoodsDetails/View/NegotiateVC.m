//
//  NegotiateVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/30.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "NegotiateVC.h"
#import "PayVC.h"
#import "PayViewController.h"
@interface NegotiateVC ()<UIWebViewDelegate>

@end

@implementation NegotiateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refresh];
    self.web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 60)];
    self.web.delegate = self;
//    [self.web loadHTMLString:<#(nonnull NSString *)#> baseURL:<#(nullable NSURL *)#>];
    [self.view addSubview:self.web];
    
    //登录
    UIButton *signBtn = [UIButton buttonWithTitle:@"我已阅读并签署" titleColor:[UIColor colorWithHexString:@"#FFFFFF"] backgroundColor:[UIColor colorWithHexString:@"#23AD8C"] titleFont:16.0 cornerRadius:4];
    signBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16.0];
    [signBtn addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
    signBtn.frame = CGRectMake(15, self.web.yy + 5, SCREEN_WIDTH - 30, 50);
    [self.view addSubview:signBtn];
//    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(@(30));
//        make.height.equalTo(@(45));
//        make.right.equalTo(@(-30));
//        make.top.equalTo(self.web.mas_bottom).offset(40);
//
//    }];
    
    
}
-(void)goNext{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629040";
    http.parameters[@"specsCode"] = self.TreeModel.productSpecsList[0][@"code"];
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"quantity"] = @(self.count);
    [http postWithSuccess:^(id responseObject) {
        PayViewController * vc = [PayViewController new];
        vc.TreeSizeCount = self.TreeSize;
        vc.PayCount = self.count;
        vc.TreeModel = self.TreeModel;
        vc.Code = responseObject[@"data"][@"code"];
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {
    }];
}
-(void)refresh{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630068";
    http.parameters[@"userId"] = self.TreeModel.ownerInfo[@"userId"];
    [http postWithSuccess:^(id responseObject) {
        [self.web loadHTMLString:responseObject[@"data"][@"contractTemplate"] baseURL:nil];
    } failure:^(NSError *error) {
    }];
    
}


@end
