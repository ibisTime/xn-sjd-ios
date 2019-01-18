//
//  GoodsListVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/18.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "GoodsListVC.h"
#import "MallClassificationVC.h"
@interface GoodsListVC ()

@end

@implementation GoodsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"列表";
//    self.backStr = @"首页";
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"首页" style:UIBarButtonItemStylePlain target:nil action:nil];
    //    //设置backBarButtonItem即可
//    self.navigationItem.backBarButtonItem = backItem;
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
    backBtn.title = @"列表";
    self.navigationItem.backBarButtonItem = backBtn;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    MallClassificationVC *vc = [MallClassificationVC new];

    [self.navigationController pushViewController:vc animated:YES];
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
