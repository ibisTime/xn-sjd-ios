//
//  PostMoneyVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/12.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "PostMoneyVC.h"

@interface PostMoneyVC ()<UITextFieldDelegate>{
    UIButton *selectBtn;
    NSString * payType;
}
@property (nonatomic,strong) NSString * Amount;
@property (nonatomic,strong) NSArray * MoneyArray;
@property (nonatomic,strong) UILabel * Amountlabel;
@property (nonatomic,strong) UITextField * moneytext;
@property (nonatomic,strong) TLTextField * pwd;
@property (nonatomic,strong) UILabel * paylabel;
@end

@implementation PostMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    [self refresh];
    
    UILabel * label = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 55) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kBlackColor];
    label.text = [NSString stringWithFormat:@"当前余额："];
    [self.view addSubview:label];
    self.Amountlabel = label;
    

    UIView * v1 = [self createviewwithframe:CGRectMake(15, 54, SCREEN_WIDTH - 30, 1)];
    [self.view addSubview:v1];
    
    UILabel * label1 = [UILabel labelWithFrame:CGRectMake(15, v1.yy + 17, SCREEN_WIDTH - 30, 18.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kTextColor3];
    label1.text = @"充值金额";
    [self.view addSubview:label1];
    
    UILabel * lab = [UILabel labelWithFrame:CGRectMake(15, label1.yy + 7.5, 14, 39) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(24) textColor:kHexColor(@"#323232")];
    lab.text = @"¥";
    [self.view addSubview:lab];
    
    UITextField * money = [[UITextField alloc]initWithFrame:CGRectMake(30, label1.yy + 7.5, SCREEN_WIDTH - 30, 39)];
    money.font = FONT(32);
    [money setTextColor:kHexColor(@"#323232")];
    money.text = @"100";
    money.delegate = self;
    [self.view addSubview:money];
    money.keyboardType = UIKeyboardTypeNumberPad;
    self.moneytext = money;
    
    UIView * v2 = [self createviewwithframe:CGRectMake(0, money.yy + 17, SCREEN_WIDTH, 10)];
    [self.view addSubview:v2];
    
    UILabel *namelbl = [UILabel labelWithFrame:CGRectMake(15, v2.yy + 25, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(15) textColor:kBlackColor];
    namelbl.text = @"支付方式";
    [self.view addSubview:namelbl];
    
    
    NSArray *array = @[@"微信",@"支付宝"];
    NSArray * imagearray = @[@"微信",@"支付宝"];
    for (int i = 0; i < 2; i ++) {
        UIButton *payButton = [UIButton buttonWithTitle:array[i] titleColor:kBlackColor backgroundColor:kClearColor titleFont:14];
        [payButton SG_imagePositionStyle:SGImagePositionStyleDefault spacing:8.5 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(imagearray[i]) forState:(UIControlStateNormal)];
        }];
        payButton.frame = CGRectMake(15, namelbl.yy + i % 3 * 60, SCREEN_WIDTH - 80, 60);
        payButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.view addSubview:payButton];
        
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
        [self.view addSubview:btn];
        
        UIView *paylineView = [[UIView alloc]initWithFrame:CGRectMake(15, payButton.yy , SCREEN_WIDTH - 30, 1)];
        paylineView.backgroundColor = kLineColor;
        [self.view addSubview:paylineView];
        
    }
    
    
    UILabel * paylabel1 = [UILabel labelWithFrame:CGRectMake(15, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH - 180, 45) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kBlackColor];
    paylabel1.text = [NSString stringWithFormat:@"金额 %.2f 元",[self.moneytext.text floatValue]];
    [self.view addSubview:paylabel1];
    self.paylabel = paylabel1;
    paylabel1.attributedText = [self stringwith:[self.moneytext.text floatValue]];;
    
    
    
    UIView *paylineView = [[UIView alloc]initWithFrame:CGRectMake(15, paylabel1.y + 2 , SCREEN_WIDTH - 30, 1)];
    paylineView.backgroundColor = kLineColor;
    [self.view addSubview:paylineView];
    
    UIButton *signBtn = [UIButton buttonWithTitle:@"支付" titleColor:[UIColor colorWithHexString:@"#FFFFFF"] backgroundColor:[UIColor colorWithHexString:@"#23AD8C"] titleFont:16.0 cornerRadius:4];
    signBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16.0];
    [signBtn addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
    signBtn.frame = CGRectMake(paylabel1.xx, paylineView.yy + 8.5, 150, 42);
    [self.view addSubview:signBtn];
    // Do any additional setup after loading the view.
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
-(UIView *)createviewwithframe:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kLineColor;
    return view;
//    [self.view addSubview:view];
}
-(void)refresh{
    TLNetworking * http2 = [[TLNetworking alloc]init];
    http2.code = @"802301";
    http2.parameters[@"userId"] = [TLUser user].userId;
    [http2 postWithSuccess:^(id responseObject) {
        self.MoneyArray = responseObject[@"data"];
        self.Amount = [NSString stringWithFormat:@"%.2f", [self.MoneyArray[2][@"amount"] floatValue] / 1000];
        self.Amountlabel.text = [NSString stringWithFormat:@"当前余额：%@",self.Amount];
    } failure:^(NSError *error) {
        
    }];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    self.paylabel.attributedText = [self stringwith:[textField.text floatValue]];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.paylabel.attributedText = [self stringwith:[textField.text floatValue]];
}

//富文本
-(NSMutableAttributedString *)stringwith:(float)money{
    NSString *poundage = [LangSwitcher switchLang:@"金额：" key:nil];
    NSString *poundagePrice = [NSString stringWithFormat:@"%.2f ",money];
    NSString * yuan = @"元";
    NSString *poundageAll = [NSString stringWithFormat:@"%@%@%@",poundage,poundagePrice,yuan];
    NSMutableAttributedString *poundageAttrStr = [[NSMutableAttributedString alloc] initWithString:poundageAll];
    [poundageAttrStr addAttribute:NSForegroundColorAttributeName value:kTabbarColor range:NSMakeRange(poundage.length,poundageAll.length - poundage.length - 1)];
    
    return poundageAttrStr;
}

@end
