//
//  GetMoneyVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/11.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "GetMoneyVC.h"
#import "RuleModel.h"
#import "CardModel.h"

@interface GetMoneyVC (){
    
    TLTextField * money;

   
}
@property (nonatomic,strong) NSMutableArray<RuleModel *> * RuleModels;
@property (nonatomic,strong) NSMutableArray<CardModel *> * CardModels;
@property (nonatomic,strong) UILabel * label3;
@property (nonatomic,strong) UILabel * Cardlabel;
@property (nonatomic,strong) NSArray * MoneyArray;
@property (nonatomic,strong) UILabel * label2;
@property (nonatomic,assign) float AllMoney;
@property (nonatomic,strong)TLTextField * pwd;
@property (nonatomic,strong) NSString * payCardNo;

@end

@implementation GetMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    [self createview1];
    [self createview2];
    [self createview3];
    [self refresh];
    // Do any additional setup after loading the view.
}
-(void)createview1{
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    
    UIImageView * logo = [[UIImageView alloc]initWithFrame:CGRectMake(15, 18.5, 18, 18)];
    logo.image = kImage(@"银行卡");
    [view1 addSubview:logo];
    
    self.Cardlabel = [UILabel labelWithFrame:CGRectMake(39, 0, SCREEN_WIDTH - 39 - 26, 55) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kBlackColor];
    self.Cardlabel.text = @"招商储蓄卡（8869）";
    [view1 addSubview:self.Cardlabel];
    
    self.Cardlabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SelectCard)];
    [self.Cardlabel addGestureRecognizer:ges];
    
    UIImageView * more = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 26.1, 22.45, 10.6, 10.6)];
    more.image = kImage(@"积分更多");
    [view1 addSubview:more];
    
    [self.view addSubview:view1];
    
    UIView * backview = [[UIView alloc]initWithFrame:CGRectMake(0, view1.yy, SCREEN_WIDTH, 10)];
    backview.backgroundColor = kLineColor;
    [self.view addSubview:backview];
}

-(void)createview2{
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, 139)];
    
    UILabel * label1 = [UILabel labelWithFrame:CGRectMake(15, 17, SCREEN_WIDTH - 30, 18.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kTextColor3];
    label1.text = @"提现金额（收取 0.1%服务费）";
    [view2 addSubview:label1];
    
    money = [[TLTextField alloc]initWithFrame:CGRectMake(15, label1.yy + 7.5, SCREEN_WIDTH - 30, 63.5) placeholder:@""];
    money.font = boldFont(32);
    money.keyboardType = UIKeyboardTypeNumberPad;
    [view2 addSubview:money];
    
    
    self.label2 = [UILabel labelWithFrame:CGRectMake(15, money.yy, SCREEN_WIDTH - 30 - 50, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
    self.label2.text = @"可用余额 2480.00元";
    [view2 addSubview:self.label2];
    
    UIButton * all = [UIButton buttonWithTitle:@"全部提取" titleColor:kTabbarColor backgroundColor:kClearColor titleFont:12];
    all.frame = CGRectMake(SCREEN_WIDTH - 15 - 48.5, money.yy + 12, 50, 16.5);
    [all addTarget:self action:@selector(CliclAll) forControlEvents:(UIControlEventTouchUpInside)];
    [view2 addSubview:all];
    
    
    [self.view addSubview:view2];
    
    UIView * backview = [[UIView alloc]initWithFrame:CGRectMake(0, view2.yy, SCREEN_WIDTH, 20)];
    backview.backgroundColor = kLineColor;
    [self.view addSubview:backview];
}
-(void)createview3{
    self.label3 = [UILabel labelWithFrame:CGRectMake(15, 228, SCREEN_WIDTH - 30, 72) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
    self.label3.numberOfLines = 0;
    self.label3.text = @"提取规则：\n1.每月最大提现次数100次；\n2.提现金额必须是5的倍数，单笔最高5000元；\n3.T+1到账";
    [self.view addSubview:self.label3];
    
    UIButton * button = [UIButton buttonWithTitle:@"提现" titleColor:[UIColor whiteColor] backgroundColor:kTabbarColor titleFont:16];
    button.frame = CGRectMake(15, self.label3.yy + 52, SCREEN_WIDTH - 30, 42);
    button.layer.cornerRadius = 4;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(getmoney) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
}

-(void)CliclAll{
    NSLog(@"%s",__func__);
    money.text = [NSString stringWithFormat:@"%.2f",self.AllMoney];
}
-(void)getmoney{
    NSLog(@"%s",__func__);
    RuleModel * model = self.RuleModels[3];
    int value = [model.cvalue intValue];
    if ([money.text intValue] % value == 0) {
        [money endEditing:YES];
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
    else{
        [TLAlert alertWithMsg:[NSString stringWithFormat:@"提现金额必须是 %d 的倍数",value]];
    }
    
    
    
    
}
-(void)cancel{
    [[UserModel user].cusPopView dismiss];
}
-(void)payBtn{
    NSLog(@"%s",__func__);
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"802350";
    http.parameters[@"applyUser"] = [TLUser user].userId;
    http.parameters[@"applyUserType"] = @"C";
    http.parameters[@"accountNumber"] = self.MoneyArray[2][@"accountNumber"];
    http.parameters[@"payCardInfo"] = @"中国银行";
    http.parameters[@"payCardNo"] = self.payCardNo;
    http.parameters[@"amount"] = [NSString stringWithFormat:@"%d",[money.text intValue] * 1000];
    http.parameters[@"bankName"] = @"";
    http.parameters[@"applyNote"] = @"";
    http.parameters[@"bankcardNumber"] = @"";
    http.parameters[@"tradePwd"] = self.pwd.text;
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"提现成功，等待后台审核"];
        [[UserModel user].cusPopView dismiss];
//        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        self.window.backgroundColor = [UIColor whiteColor];
//        [self.window makeKeyAndVisible];
        TLTabBarController *tabBarCtrl = [[TLTabBarController alloc] init];
        tabBarCtrl.selectedIndex = 2;
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarCtrl;
//        self.window.rootViewController = tabBarCtrl;
    } failure:^(NSError *error) {
        [[UserModel user].cusPopView dismiss];
//        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        self.window.backgroundColor = [UIColor whiteColor];
//        [self.window makeKeyAndVisible];
        TLTabBarController *tabBarCtrl = [[TLTabBarController alloc] init];
        tabBarCtrl.selectedIndex = 2;
//        self.window.rootViewController = tabBarCtrl;
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarCtrl;
    }];
}
-(void)SelectCard{
    NSLog(@"%s",__func__);
    CoinWeakSelf
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0;  i < self.CardModels.count; i ++) {
            [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@ (%@)",self.CardModels[i].bankName,[self.CardModels[i].bankcardNumber substringFromIndex:15]]]];
        }
        SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
        view.isSingle = YES;
        view.array = array;
        view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
            [LEEAlert closeWithCompletionBlock:^{
                SelectedListModel *model = array[0];
                NSLog(@"选中第%ld行" , model.sid);
                weakSelf.Cardlabel.text = model.title;
                self.payCardNo = self.CardModels[model.sid].bankcardNumber;
            }];
        };
        [LEEAlert alert].config
        .LeeTitle(@"")
        .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
        .LeeCustomView(view)
        .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        .LeeHeaderInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        .LeeClickBackgroundClose(YES)
        .LeeShow();

}
-(void)refresh{
    //提取规则
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630045";
    http.parameters[@"start"] = @(1);
    http.parameters[@"limit"] = @(10);
    http.parameters[@"type"] = @"WITH";
    [http postWithSuccess:^(id responseObject) {
        self.RuleModels = [RuleModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        NSMutableArray * arr = [NSMutableArray array];
        for (int i = 0; i < self.RuleModels.count; i++) {
            RuleModel * model = self.RuleModels[i];
            [arr addObject:[NSString stringWithFormat:@"%d.%@:%@",i+1,model.remark,model.cvalue]];
        }
        NSLog(@"NSMutableArray = %@",arr);
        self.label3.text = @"提取规则:\n";
        for (int i = 0; i < arr.count; i++) {
            NSString * str = arr[i];
            self.label3.text = [self.label3.text stringByAppendingString:str];
            self.label3.text = [self.label3.text stringByAppendingString:@"\n"];
        }
        [self.label3 sizeToFit];
        self.label3.frame = CGRectMake(15, 228, SCREEN_WIDTH - 30, self.label3.height);
    } failure:^(NSError *error) {
        
    }];
    
    //显示银行卡
    TLNetworking * http1 = [[TLNetworking alloc]init];
    http1.code = @"802026";
    http1.parameters[@"userId"] = [TLUser user].userId;
    http1.parameters[@"status"] = @(1);
    [http1 postWithSuccess:^(id responseObject) {
        self.CardModels = [CardModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (self.CardModels.count > 0) {
            CardModel * cardmodel = self.CardModels[0];
            self.Cardlabel.text = [NSString stringWithFormat:@"%@ (%@)",cardmodel.bankName,[cardmodel.bankcardNumber substringFromIndex:15]];
            self.payCardNo = cardmodel.bankcardNumber;
        }else{
            self.Cardlabel.text = @"请绑定银行卡";
        }
    } failure:^(NSError *error) {
        
    }];
    
    //显示余额
    TLNetworking * http2 = [[TLNetworking alloc]init];
    http2.code = @"802301";
    http2.parameters[@"userId"] = [TLUser user].userId;
    [http2 postWithSuccess:^(id responseObject) {
        self.MoneyArray = responseObject[@"data"];
        self.AllMoney = [self.MoneyArray[2][@"amount"] floatValue] / 1000;
        self.label2.text = [NSString stringWithFormat:@"可用余额 %.2f",self.AllMoney];
    } failure:^(NSError *error) {
        
    }];
    
}

@end
