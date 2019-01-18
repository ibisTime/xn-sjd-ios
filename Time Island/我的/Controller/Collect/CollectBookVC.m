//
//  CollectBookVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "CollectBookVC.h"
#import "BookView.h"
#import "CollectTreeView.h"
@interface CollectBookVC ()
@property (nonatomic,strong) BookView * bookview;

@end

@implementation CollectBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    self.bookview = [[BookView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabBarHeight - 40) style:UITableViewStyleGrouped];
    self.bookview.backgroundColor = kWhiteColor;
    self.bookview.refreshDelegate = self;
    [self.view addSubview:self.bookview];
//    self.bookview = [BookView alloc]
}



@end
