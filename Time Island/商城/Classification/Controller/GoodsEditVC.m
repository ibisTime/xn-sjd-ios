//
//  GoodsEditVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "GoodsEditVC.h"
#import "AllCommentTB.h"
@interface GoodsEditVC ()<RefreshDelegate>
@property (nonatomic ,strong) AllCommentTB *commentTb;
@end

@implementation GoodsEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.commentTb = [[AllCommentTB alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight-45)];
    [self.view addSubview:self.commentTb];
    self.commentTb.refreshDelegate = self;
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
