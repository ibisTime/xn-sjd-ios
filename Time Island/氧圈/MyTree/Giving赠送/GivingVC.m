//
//  GivingVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "GivingVC.h"

@interface GivingVC ()

@end

@implementation GivingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    self.title = @"赠送";
}

-(void)initView
{
    UIImageView *TopImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeight(200))];
    TopImg.image = kImage(@"树 跟背景");
    [self.view addSubview:TopImg];
    
    UILabel *promptLbl = [UILabel labelWithFrame:CGRectMake(0, TopImg.yy, SCREEN_WIDTH, 35) textAligment:(NSTextAlignmentLeft) backgroundColor:kHexColor(@"#FDF4D6") font:FONT(12) textColor:kHexColor(@"#666666")];
    promptLbl.text = @"   您想把这棵树转赠给谁的话，就填入TA的账号吧";
    [self.view addSubview:promptLbl];
    
    NSArray *nameArray = @[@"赠送对象",@"对方昵称",@"对方姓名"];
    NSArray *placArray = @[@"请输入对方氧林手机账号",@"请输入对方昵称",@"请输入对方姓名"];
    for (int i = 0; i < 3; i ++) {
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, promptLbl.yy + i % 3 * 55, 70, 55) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kHexColor(@"#333333")];
        nameLabel.text = nameArray[i];
        [self.view addSubview:nameLabel];
        
        UITextField *nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(nameLabel.xx + 15, promptLbl.yy + i % 3 * 55, SCREEN_WIDTH - nameLabel.xx - 45, 55)];
        nameTextField.placeholder = placArray[i];
        [nameTextField setValue:FONT(15) forKeyPath:@"_placeholderLabel.font"];
        nameTextField.font = FONT(15);
        [self.view addSubview:nameTextField];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, promptLbl.yy + i % 3 * 55 + 54, SCREEN_WIDTH - 30, 1)];
        lineView.backgroundColor = kLineColor;
        [self.view addSubview:lineView];
        
        
    }
    
    UIButton *givingBtn = [UIButton buttonWithTitle:@"确认赠送" titleColor:kWhiteColor backgroundColor:kHexColor(@"#23AD8C") titleFont:15];
    givingBtn.frame = CGRectMake(15, promptLbl.yy + 200, SCREEN_WIDTH - 30, 45);
    kViewRadius(givingBtn, 4);
    [self.view addSubview:givingBtn];
    
    
}


@end
