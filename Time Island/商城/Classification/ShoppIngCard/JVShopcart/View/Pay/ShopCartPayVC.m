//
//  ShopCartPayVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/8.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "ShopCartPayVC.h"
#import "ShopCartPayTableview.h"
#import "ShopcartPayModel.h"
#import "MallOrderVC.h"
@interface ShopCartPayVC (){
    UIButton *selectBtn;
    NSString * payType;
}
@property (nonatomic,strong)TLTextField * pwd;
@property (nonatomic,strong) ShopCartPayTableview  * tableview;
@property (nonatomic,strong) NSMutableArray<ShopcartPayModel *> * ShopcartPayModels;
@property (nonatomic,strong) UIView * footview;
@end

@implementation ShopCartPayVC
-(ShopCartPayTableview *)tableview{
    if (!_tableview) {
        _tableview = [[ShopCartPayTableview alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 70)];
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付订单";
    self.view.backgroundColor = kWhiteColor;
    [self getData];
    [self.view addSubview:self.tableview];
    [self footerview];
    self.tableview.tableFooterView = self.footview;
    
    
    
    
    
    UILabel * paylabel = [UILabel labelWithFrame:CGRectMake(15, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH - 180, 55) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kBlackColor];
    paylabel.text = [NSString stringWithFormat:@"合计：%.2f",self.paycount];
    [self.view addSubview:paylabel];
    
    UIButton *signBtn = [UIButton buttonWithTitle:@"支付" titleColor:[UIColor colorWithHexString:@"#FFFFFF"] backgroundColor:[UIColor colorWithHexString:@"#23AD8C"] titleFont:16.0 cornerRadius:4];
    signBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16.0];
    [signBtn addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
    signBtn.frame = CGRectMake(paylabel.xx, SCREEN_HEIGHT - kNavigationBarHeight - 60, 150, 55);
    [self.view addSubview:signBtn];
    
    UIView *paylineView = [[UIView alloc]initWithFrame:CGRectMake(15, signBtn.y - 5 , SCREEN_WIDTH - 30, 1)];
    paylineView.backgroundColor = kLineColor;
    [self.view addSubview:paylineView];
}
-(void)footerview{
    self.footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
    self.footview.backgroundColor = kWhiteColor;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = kLineColor;
    [self.footview  addSubview:lineView];
    
    UILabel *namelbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(15) textColor:kBlackColor];
    namelbl.text = @"支付方式";
    [self.footview  addSubview:namelbl];
    
    
    NSArray *array = @[@"微信",@"支付宝",@"余额支付"];
    NSArray * imagearray = @[@"微信",@"支付宝",@"余额"];
    for (int i = 0; i < 3; i ++) {
        UIButton *payButton = [UIButton buttonWithTitle:array[i] titleColor:kBlackColor backgroundColor:kClearColor titleFont:14];
        payButton.frame = CGRectMake(15, namelbl.yy + i % 3 * 60, SCREEN_WIDTH - 80, 60);
        payButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [payButton SG_imagePositionStyle:SGImagePositionStyleDefault spacing:8.5 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(imagearray[i]) forState:(UIControlStateNormal)];
        }];
        [self.footview addSubview:payButton];
        
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.frame = CGRectMake(SCREEN_WIDTH - 45, namelbl.yy + i % 3 * 60, 30, 60);
        [btn setImage:kImage(@"未选中") forState:(UIControlStateNormal)];
        [btn setImage:kImage(@"选中") forState:(UIControlStateSelected)];
        
        if (i == 0) {
            btn.selected = YES;
            selectBtn = btn;
            payType = @"5";
        }
        [btn addTarget:self action:@selector(payBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        btn.tag = 100 + i;
        [self.footview  addSubview:btn];
        
        UIView *paylineView = [[UIView alloc]initWithFrame:CGRectMake(15, payButton.yy , SCREEN_WIDTH - 30, 1)];
        paylineView.backgroundColor = kLineColor;
        [self.footview addSubview:paylineView];
    }
}
-(void)goNext{
    UIView * pwdview = [[UIView alloc]initWithFrame:CGRectMake(50, SCREEN_HEIGHT / 2 - 50, SCREEN_WIDTH - 100, 150)];
    pwdview.backgroundColor = kWhiteColor;
    pwdview.layer.borderColor = kTextColor4.CGColor;
    pwdview.layer.borderWidth = 1;
    pwdview.layer.cornerRadius = 5;
    pwdview.layer.masksToBounds = YES;
    UILabel * title = [UILabel labelWithFrame:CGRectMake(0, 15, pwdview.width, 30) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(16) textColor:kTextColor4];
    title.text = @"支付密码";
    [pwdview addSubview:title];
    
    TLTextField * pwd = [[TLTextField alloc]initWithFrame:CGRectMake(15, title.yy + 10, pwdview.width - 30, 30) placeholder:@"请输入支付密码"];
    pwd.layer.borderColor = kTextColor4.CGColor;
    pwd.layer.borderWidth = 1;
    pwd.layer.cornerRadius = 3;
    pwd.layer.masksToBounds = YES;
    pwd.secureTextEntry = YES;
    [pwdview addSubview:pwd];
    self.pwd = pwd;
    
    
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, pwd.yy + 15 , SCREEN_WIDTH - 30, 1)];
    lineView.backgroundColor = kLineColor;
    [pwdview addSubview:lineView];
    
    UIButton * canclebtn = [UIButton buttonWithTitle:@"取消" titleColor:kTextBlack backgroundColor:kClearColor titleFont:16];
    canclebtn.frame = CGRectMake(0, lineView.yy, pwdview.width/2, 50);
    [canclebtn addTarget:self action:@selector(cancel) forControlEvents:(UIControlEventTouchUpInside)];
    [pwdview addSubview:canclebtn];
    
    UIView * lineview = [[UIView alloc]initWithFrame:CGRectMake(pwdview.width/2,lineView.yy,1, 50)];
    lineview.backgroundColor = kLineColor;
    [pwdview addSubview:lineview];
    
    UIButton * paybtn = [UIButton buttonWithTitle:@"确定" titleColor:kTabbarColor backgroundColor:kClearColor titleFont:16];
    paybtn.frame = CGRectMake(pwdview.width/2, lineView.yy, pwdview.width/2, 50);
    [paybtn addTarget:self action:@selector(payBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [pwdview addSubview:paybtn];
    
    [[UserModel user]showPopAnimationWithAnimationStyle:3 showView:pwdview BGAlpha:0.5 isClickBGDismiss:YES];
    
}
-(void)cancel{
    [[UserModel user].cusPopView dismiss];
}
-(void)payBtn{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629714";
    http.parameters[@"payGroup"] = self.code;
    http.parameters[@"isJfDeduct"] = @"0";
    http.parameters[@"tradePwd"] = self.pwd.text;
    http.parameters[@"payType"] = payType;
    http.parameters[@"updater"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"支付成功"];
        [[UserModel user].cusPopView dismiss];
        MallOrderVC * vc= [MallOrderVC new];
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {
        self.pwd.text = nil;
    }];
}
-(void)payBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    selectBtn.selected = !selectBtn.selected;
    selectBtn = sender;
    
    switch ((int)sender.tag - 100) {
        case 0:
            payType = @"5";
            break;
        case 1:
            payType = @"3";
            break;
        case 2:
            payType = @"1";
            break;
            
        default:
            break;
    }
    
}

-(void)getData{
    if (self.JVShopcartBrandModels) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"629802";
        http.parameters[@"payGroupCode"] = self.code;
        [http postWithSuccess:^(id responseObject) {
            self.ShopcartPayModels = [ShopcartPayModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            CGFloat height = self.ShopcartPayModels.count * 30;
            int count = 0;
            for (int i = 0; i < self.ShopcartPayModels.count; i ++) {
                for (int j = 0 ; j < self.ShopcartPayModels[i].commodityOrderDetails.count; j++) {
                    count ++;
                }
            }
            height += count * 110;
            self.tableview.ShopcartPayModels = self.ShopcartPayModels;
            [self.tableview reloadData];
        } failure:^(NSError *error) {
            
        }];
    }
    
}

@end
