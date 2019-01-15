//
//  BoolVideoDetailVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BoolVideoDetailVC.h"
#import "BookDetailHeadView.h"
@interface BoolVideoDetailVC ()
@property (nonatomic , strong) BookDetailHeadView*headView;
@end

@implementation BoolVideoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headView = [[BookDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    [self.view addSubview:self.headView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
