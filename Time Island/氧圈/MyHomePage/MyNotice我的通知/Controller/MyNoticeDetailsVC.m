//
//  MyNoticeDetailsVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/15.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MyNoticeDetailsVC.h"

@interface MyNoticeDetailsVC ()

@end

@implementation MyNoticeDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"公告详情";
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.directionalLockEnabled = YES;
    [self.view addSubview:scrollView];
    
    
    
    UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 25, SCREEN_WIDTH - 30, 33.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(24) textColor:kTextBlack];
    nameLabel.text = @"千岛湖时间岛";
    [scrollView addSubview:nameLabel];
    
    UILabel *timeLabel = [UILabel labelWithFrame:CGRectMake(15, nameLabel.yy + 11, SCREEN_WIDTH - 30, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
    timeLabel.text = @"2018.10.5 5:41";
    [scrollView addSubview:timeLabel];
    
    
    UILabel *contactLbl = [UILabel labelWithFrame:CGRectMake(15,timeLabel.yy + 20, SCREEN_WIDTH - 30, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#999999")];
    contactLbl.numberOfLines = 0;
    contactLbl.text = @"千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字";
    [contactLbl sizeToFit];
    [scrollView addSubview:contactLbl];
    
    scrollView.contentSize = CGSizeMake(0, contactLbl.yy + 50);
    
}



@end
