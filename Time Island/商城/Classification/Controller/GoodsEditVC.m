//
//  GoodsEditVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "GoodsEditVC.h"
#import "AllCommentTB.h"
#import "GoodsEditModel.h"
@interface GoodsEditVC ()<RefreshDelegate>
@property (nonatomic ,strong) AllCommentTB *commentTb;

@property (nonatomic ,strong) NSMutableArray *models;

@end

@implementation GoodsEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.commentTb = [[AllCommentTB alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight-45)];
    [self.view addSubview:self.commentTb];
   
    self.models = [NSMutableArray array];
    self.commentTb.refreshDelegate = self;
    for (int i = 0; i <10; i++) {
      
        if (i == 1) {
            GoodsEditModel *model = [GoodsEditModel new];
            model.images = @[@"baner1"];
            model.Rowheight = 0;
            [self.models addObject:model];
        }else if (i == 3)
        {
            GoodsEditModel *model = [GoodsEditModel new];
            model.images = @[@"baner1",@"我的背景",@"baner2",@"我的背景",@"baner2"];
            model.Rowheight = 0;
            [self.models addObject:model];
        }else if (i == 5)
        {
            GoodsEditModel *model = [GoodsEditModel new];
            model.images = @[@"baner1",@"我的背景",@"baner2",@"我的背景",@"baner2",@"我的背景",@"baner2",@"我的背景",@"baner2"];
            model.Rowheight = 0;
            [self.models addObject:model];
        }else if (i == 7)
        {
            GoodsEditModel *model = [GoodsEditModel new];
            model.images = @[@"baner1",@"我的背景",@"baner2",@"我的背景",@"baner2",@"我的背景",@"baner2",@"我的背景"];
            model.Rowheight = 0;
            [self.models addObject:model];
        }else{
            GoodsEditModel *model = [GoodsEditModel new];
            model.images = @[@"baner1",@"我的背景",@"baner2"];
            model.Rowheight = 0;
            [self.models addObject:model];
        }
    }
    self.commentTb.models = self.models;
    [self.commentTb reloadData];
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
