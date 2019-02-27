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
@property (nonatomic,strong) NSString * str;
@end

@implementation NegotiateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"认养协议";
    // Do any additional setup after loading the view.
    [self refresh];
    self.web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 60)];
    self.web.delegate = self;
    [self.view addSubview:self.web];
    
    //登录
    UIButton *signBtn = [UIButton buttonWithTitle:@"我已阅读并签署" titleColor:[UIColor colorWithHexString:@"#FFFFFF"] backgroundColor:[UIColor colorWithHexString:@"#23AD8C"] titleFont:16.0 cornerRadius:4];
    signBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16.0];
    [signBtn addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
    signBtn.frame = CGRectMake(15, self.web.yy + 5, SCREEN_WIDTH - 30, 50);
    [self.view addSubview:signBtn];

    
    
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
    http.showView = self.view;
    http.parameters[@"userId"] = self.TreeModel.ownerInfo[@"userId"];
    [http postWithSuccess:^(id responseObject) {
        NSString * str = responseObject[@"data"][@"contractTemplate"];
        if (![USERXX isBlankString:responseObject[@"data"][@"name"]]) {
           str = [str stringByReplacingOccurrencesOfString:@"##甲方名称##" withString:responseObject[@"data"][@"name"]];
        }
        
        str = [str stringByReplacingOccurrencesOfString:@"##乙方名称##" withString:[TLUser user].realName];
        
        
        
        str = [str stringByReplacingOccurrencesOfString:@"##quantity##" withString:[NSString stringWithFormat:@" %d ",self.count]];
        
        str = [str stringByReplacingOccurrencesOfString:@"##y1##" withString:[NSString stringWithFormat:@" %@ ",[self.TreeModel.productSpecsList[self.TreeSize][@"startDatetime"] convertDateWithYear]]];
        
        str = [str stringByReplacingOccurrencesOfString:@"##m1##" withString:[NSString stringWithFormat:@" %@ ",[self.TreeModel.productSpecsList[self.TreeSize][@"startDatetime"] convertDateWithMonth]]];
        
        str = [str stringByReplacingOccurrencesOfString:@"##d1##" withString:[NSString stringWithFormat:@" %@ ",[self.TreeModel.productSpecsList[self.TreeSize][@"startDatetime"] convertDateWithDay]]];
        
        str = [str stringByReplacingOccurrencesOfString:@"##y2##" withString:[NSString stringWithFormat:@" %@ ",[self.TreeModel.productSpecsList[self.TreeSize][@"endDatetime"] convertDateWithYear]]];
        
        str = [str stringByReplacingOccurrencesOfString:@"##m2##" withString:[NSString stringWithFormat:@" %@ ",[self.TreeModel.productSpecsList[self.TreeSize][@"endDatetime"] convertDateWithMonth]]];
        
        str = [str stringByReplacingOccurrencesOfString:@"##d2##" withString:[NSString stringWithFormat:@" %@ ",[self.TreeModel.productSpecsList[self.TreeSize][@"endDatetime"] convertDateWithDay]]];
        
        str = [str stringByReplacingOccurrencesOfString:@"##price##" withString:[NSString stringWithFormat:@" %.2f ",self.count * [self.TreeModel.productSpecsList[self.TreeSize][@"price"] floatValue] / 1000.00]];
        
//
        
        str = [str stringByReplacingOccurrencesOfString:@"##cachet1##" withString:[NSString stringWithFormat:@"<img src = %@></img>",[responseObject[@"data"][@"commonSeal"] convertImageUrl]]];
        
        
        str = [str stringByReplacingOccurrencesOfString:@"##date1##" withString:[self getCurrentTimes]];
        str = [str stringByReplacingOccurrencesOfString:@"##date2##" withString:[self getCurrentTimes]];
        str = [str stringByReplacingOccurrencesOfString:@"##date3##" withString:[self getCurrentTimes]];
        self.str = str;
        
        
        TLNetworking * h = [[TLNetworking alloc]init];
        h.code = @"629677";
        h.parameters[@"province"] = self.TreeModel.province;
        h.parameters[@"city"] = self.TreeModel.city;
        h.parameters[@"area"] = self.TreeModel.area;
        [h postWithSuccess:^(id responseObject) {
            NSMutableArray * arr = responseObject[@"data"];
            if (arr.count > 0) {
               
                self.str = [self.str stringByReplacingOccurrencesOfString:@"##丙方名称##" withString:arr[0][@"department"]];
                self.str = [self.str stringByReplacingOccurrencesOfString:@"##cachet3##" withString:[NSString stringWithFormat:@"<img src = %@></img>",[arr[0][@"pic"] convertImageUrl]]];
            }
            else{
                self.str = [self.str stringByReplacingOccurrencesOfString:@"##丙方名称##" withString:@"    "];
                self.str = [self.str stringByReplacingOccurrencesOfString:@"##cachet3##" withString:@"    "];
            }
             [self.web loadHTMLString:self.str baseURL:nil];
        } failure:^(NSError *error) {
            
        }];
        
        
       
    } failure:^(NSError *error) {
    }];
    
}

-(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY.MM.dd"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
    
}
@end
