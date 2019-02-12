//
//  GetMoneyVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/11.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "GetMoneyVC.h"
#import "RuleModel.h"

@interface GetMoneyVC (){
    UILabel * Cardlabel;
    TLTextField * money;
    UILabel * label2;
   
}
@property (nonatomic,strong) NSMutableArray<RuleModel *> * RuleModels;
@property (nonatomic,strong) UILabel * label3;
@end

@implementation GetMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    Cardlabel = [UILabel labelWithFrame:CGRectMake(39, 0, SCREEN_WIDTH - 39 - 26, 55) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kBlackColor];
    Cardlabel.text = @"招商储蓄卡（8869）";
    [view1 addSubview:Cardlabel];
    
    Cardlabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SelectCard)];
    [Cardlabel addGestureRecognizer:ges];
    
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
    [view2 addSubview:money];
    
    
    label2 = [UILabel labelWithFrame:CGRectMake(15, money.yy, SCREEN_WIDTH - 30 - 50, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
    label2.text = @"可用余额 2480.00元";
    [view2 addSubview:label2];
    
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
}
-(void)getmoney{
    NSLog(@"%s",__func__);
}
-(void)SelectCard{
    NSLog(@"%s",__func__);
}
-(void)refresh{
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
//            self.label3.text = [NSString stringWithFormat:@"提取规则:\n%d.%@:%@",i+1,model.remark,model.cvalue];
            [arr addObject:[NSString stringWithFormat:@"%d.%@:%@",i+1,model.remark,model.cvalue]];
        }
        NSLog(@"NSMutableArray = %@",arr);
        self.label3.text = @"提取规则:\n";
        for (int i = 0; i < arr.count; i++) {
//            self.label3.text = [self.label3.text stringByAppendingString:@"%@\n",arr[0]];
        }
//        self.label3.text = [NSString stringWithFormat:@"提取规则:\n%@\n",arr[0]];
    } failure:^(NSError *error) {
        
    }];
}
@end
