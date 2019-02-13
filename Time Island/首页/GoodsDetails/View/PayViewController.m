//
//  PayViewController.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/30.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "PayViewController.h"

@interface PayViewController ()
{
    UIButton *selectBtn;
    NSString * payType;
}
@property (nonatomic,strong)TLTextField * pwd;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
//    view.backgroundColor = [
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 80, 80)];
    image.layer.cornerRadius = 5;
    image.layer.masksToBounds = YES;
    [view addSubview:image];
//    image.image = kImage(@"树 跟背景");
    [image sd_setImageWithURL:[NSURL URLWithString: [self.TreeModel.listPic convertImageUrl]]];
    self.IconImg = image;
    
    UILabel * TreeName = [UILabel labelWithFrame:CGRectMake(image.xx + 10, image.y, SCREEN_WIDTH * 1.5 / 3, 27) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kBlackColor];
//    TreeName.text = @"古树名称";
    TreeName.text = self.TreeModel.name;
    [view addSubview:TreeName];
    self.TreeName = TreeName;
    
    UILabel * TreeAddress = [UILabel labelWithFrame:CGRectMake(image.xx + 10, TreeName.yy, SCREEN_WIDTH * 1.5 / 3, 27) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kTextColor3];
//    TreeAddress.text = @"地址";
    TreeAddress.text = self.TreeModel.originPlace;
    [view addSubview:TreeAddress];
    self.TreeAddress = TreeAddress;
//
    UILabel * TreeSize = [UILabel labelWithFrame:CGRectMake(image.xx + 10, TreeAddress.yy, SCREEN_WIDTH * 1.5 / 3, 27) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kTextColor3];
//    TreeSize.text = @"规格";
    TreeSize.text =[NSString stringWithFormat:@"规格: %@", self.TreeModel.productSpecsList[self.TreeSizeCount][@"name"]];
    [view addSubview:TreeSize];
    self.TreeSize = TreeSize;
//
    UILabel * TreeCount = [UILabel labelWithFrame:CGRectMake(TreeName.xx + 5, image.y, SCREEN_WIDTH - TreeName.xx -20, 27) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(15) textColor:kBlackColor];
//    TreeCount.text = @"x1";
    TreeCount.text = [NSString stringWithFormat:@"X %d", self.PayCount];
    [view addSubview:TreeCount];
    self.TreeCount = TreeCount;

    UILabel * TreeMoney = [UILabel labelWithFrame:CGRectMake(TreeAddress.xx + 5, TreeName.yy, SCREEN_WIDTH - TreeAddress.xx - 20, 27) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(13) textColor:kTextColor3];
//    TreeMoney.text = @"0.01";
    TreeMoney.text = [NSString stringWithFormat:@"¥ %.2f",[self.TreeModel.productSpecsList[self.TreeSizeCount][@"price"] floatValue]/ 1000.00];
    [view addSubview:TreeMoney];
    self.TreeMoney = TreeMoney;

    UILabel * PayMoney = [UILabel labelWithFrame:CGRectMake(TreeSize.xx + 5, TreeAddress.yy, SCREEN_WIDTH - TreeSize.xx - 20, 27) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(16) textColor:kBlackColor];
    PayMoney.text = [NSString stringWithFormat:@"¥ %.2f",[self.TreeModel.productSpecsList[self.TreeSizeCount][@"price"] floatValue]/ 1000.00 * self.PayCount];
    [view addSubview:PayMoney];
    self.PayMoney = PayMoney;
//
    [self.view addSubview:view];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 109, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = kLineColor;
    [view addSubview:lineView];
    
    UILabel *namelbl = [UILabel labelWithFrame:CGRectMake(15, 110, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(15) textColor:kBlackColor];
    namelbl.text = @"支付方式";
    [view addSubview:namelbl];
    
    
    NSArray *array = @[@"微信",@"支付宝",@"余额支付"];
    NSArray * imagearray = @[@"微信",@"支付宝",@"余额"];
    for (int i = 0; i < 3; i ++) {
        UIButton *payButton = [UIButton buttonWithTitle:array[i] titleColor:kBlackColor backgroundColor:kClearColor titleFont:14];
        payButton.frame = CGRectMake(15, namelbl.yy + i % 3 * 60, SCREEN_WIDTH - 80, 60);
        payButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [payButton SG_imagePositionStyle:SGImagePositionStyleDefault spacing:8.5 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(imagearray[i]) forState:(UIControlStateNormal)];
        }];
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
    
    
    
    
    UILabel * paylabel = [UILabel labelWithFrame:CGRectMake(15, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH - 180, 45) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kBlackColor];
    paylabel.text = [NSString stringWithFormat:@"金额 %.2f 元",[self.TreeModel.productSpecsList[self.TreeSizeCount][@"price"] floatValue]/ 1000.00 * self.PayCount];
    [self.view addSubview:paylabel];
    
    UIView *paylineView = [[UIView alloc]initWithFrame:CGRectMake(15, paylabel.y + 2 , SCREEN_WIDTH - 30, 1)];
    paylineView.backgroundColor = kLineColor;
    [self.view addSubview:paylineView];
    
    UIButton *signBtn = [UIButton buttonWithTitle:@"支付" titleColor:[UIColor colorWithHexString:@"#FFFFFF"] backgroundColor:[UIColor colorWithHexString:@"#23AD8C"] titleFont:16.0 cornerRadius:4];
    signBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16.0];
    [signBtn addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
    signBtn.frame = CGRectMake(paylabel.xx, SCREEN_HEIGHT - kNavigationBarHeight - 60, 150, 50);
    [self.view addSubview:signBtn];
    
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
    http.code = @"629042";
    http.parameters[@"code"] = self.Code;
    http.parameters[@"isJfDeduct"] = @"0";
    http.parameters[@"tradePwd"] = self.pwd.text;
    http.parameters[@"payType"] = payType;
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"支付成功"];
        [[UserModel user].cusPopView dismiss];
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
//-(void)setTreeModel:(TreeModel *)TreeModel{
//    _TreeModel = TreeModel;
//
//    [self.IconImg sd_setImageWithURL:[NSURL URLWithString: [self.TreeModel.listPic convertImageUrl]]];
//    self.TreeAddress.text = self.TreeModel.originPlace;
//    self.TreeSize.text = self.TreeModel.productSpecsList[self.TreeSizeCount][@"name"];
//    self.TreeCount.text = [NSString stringWithFormat:@"X %d", self.PayCount];
//    self.TreeMoney.text = [NSString stringWithFormat:@"%.2f",[self.TreeModel.productSpecsList[self.TreeSizeCount][@"price"] floatValue]/ 1000.00];
//
//}
@end
