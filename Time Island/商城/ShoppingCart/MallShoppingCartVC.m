//
//  MallShoppingCartVC.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/18.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MallShoppingCartVC.h"

@interface MallShoppingCartVC ()

@end

@implementation MallShoppingCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

-(void)backBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
