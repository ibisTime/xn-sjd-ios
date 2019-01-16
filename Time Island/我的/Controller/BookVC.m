//
//  BookVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BookVC.h"
#import "BookView.h"
@interface BookVC ()<RefreshDelegate>
@property (nonatomic,strong) BookView * bookview;
@end

@implementation BookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的的文章";
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    self.RightButton.font = FONT(16);
    [self.RightButton setFrame:CGRectMake(SCREEN_WIDTH-47.5, 30, 32.5, 45)];
    [self.RightButton setTitle:@"发布" forState:UIControlStateNormal];
    [self.RightButton addTarget:self action:@selector(myRecodeClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    
    
    self.view.backgroundColor = kWhiteColor;
    self.bookview = [[BookView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.bookview.backgroundColor = kWhiteColor;
    self.bookview.refreshDelegate = self;
    [self.view addSubview:self.bookview];
    // Do any additional setup after loading the view.
}

-(void)myRecodeClick{
    NSLog(@"%s",__func__);
}


@end
