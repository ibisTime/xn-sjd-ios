//
//  MallShoppingVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/17.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallShoppingVC.h"
#import "TLTabBarController.h"

@interface MallShoppingVC ()

@end

@implementation MallShoppingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    [UIBarButtonItem addLeftItemWithImageName:@"返回白色" frame:CGRectMake(-10, 0, 44, 40) vc:self action:@selector(backButtonClick)];
    // Do any additional setup after loading the view.
}
- (void)backButtonClick
{
    TLTabBarController *tab = [[TLTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tab;
    
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
