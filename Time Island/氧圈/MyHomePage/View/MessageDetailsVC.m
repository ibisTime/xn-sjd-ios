//
//  MessageDetailsVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/13.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MessageDetailsVC.h"

@interface MessageDetailsVC ()
@property (nonatomic,strong) UILabel * titlelabel;
@property (nonatomic,strong) UILabel * timelabel;
@property (nonatomic,strong) UILabel * contentlabel;
@property (nonatomic,strong) NSDictionary * dic;

@end

@implementation MessageDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知详情";
    
    UILabel * l1 = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(25) textColor:kBlackColor];
    l1.text = @"标题";
    [self.view addSubview:l1];
    self.titlelabel = l1;
    
    UILabel * l2 = [UILabel labelWithFrame:CGRectMake(15, l1.yy + 10, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(15) textColor:kTextColor3];
    l2.text = @"2019-02-13 ";
    [self.view addSubview:l2];
    self.timelabel = l2;
    
    UILabel * l3 = [UILabel labelWithFrame:CGRectMake(15, l2.yy + 15, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(15) textColor:kBlackColor];
    l3.text = @"内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容";
    l3.numberOfLines = 0;
    l3.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:l3];
    self.contentlabel = l3;
    
    [self refresh];
}
-(void)refresh{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"805307";
    http.parameters[@"code"] = self.code;
    [http postWithSuccess:^(id responseObject) {
        self.dic = responseObject[@"data"];
        self.titlelabel.text = self.dic[@"title"];
        self.timelabel.text = [self.dic[@"createDatetime"] convertToDetailDate];
        self.contentlabel.text = self.dic[@"content"];
        [self.contentlabel sizeToFit];
        self.contentlabel.frame = CGRectMake(15, self.timelabel.yy + 15, SCREEN_WIDTH - 30, self.contentlabel.height);
    } failure:^(NSError *error) {
        
    }];
}


@end
