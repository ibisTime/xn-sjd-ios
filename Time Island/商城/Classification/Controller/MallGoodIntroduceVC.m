//
//  MallGoodIntroduceVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallGoodIntroduceVC.h"
#import "PushSelectScrollView.h"
#import "MallGoodIntroduceVC.h"
#import "MallGoodDetailView.h"
#import "MallCommentTB.h"
@interface MallGoodIntroduceVC ()<RefreshDelegate>
@property (nonatomic , strong) PushSelectScrollView *selectSV;

@property (nonatomic,strong) NSArray * itemsTitles;

@property (nonatomic,strong) MallGoodDetailView * detailView;

@property (nonatomic,strong) MallCommentTB * commentTB;

@property (nonatomic,strong) UIScrollView * contentView;

@end

@implementation MallGoodIntroduceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDetailView];

    // Do any additional setup after loading the view.
}



- (void)initDetailView
{
    self.contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight)];
    [self.view addSubview:self.contentView];
    self.contentView.scrollEnabled = YES;
    self.detailView = [[MallGoodDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSuperViewHeight - kTabBarHeight-(kHeight(40+30+10)))];
    [self.contentView addSubview:self.detailView];
    self.commentTB = [[MallCommentTB alloc] initWithFrame:CGRectMake(0, self.detailView.yy, kScreenWidth, kScreenHeight)];
    [self.contentView addSubview:self.commentTB];
    self.commentTB.refreshDelegate = self;
    self.contentView.contentSize = CGSizeMake(0, self.commentTB.yy+100);
}

@end
