//
//  CardVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "CardVC.h"
#import "CardVCCell.h"
#import "AddCardVC.h"
@interface CardVC ()
@property (nonatomic,strong) UICollectionView *cview;
@end

@implementation CardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    self.RightButton.font = FONT(16);
    [self.RightButton setFrame:CGRectMake(SCREEN_WIDTH-47.5, 30, 32.5, 45)];
    [self.RightButton setTitle:@"绑定" forState:UIControlStateNormal];
    [self.RightButton addTarget:self action:@selector(myRecodeClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH-30, 160);
    self.cview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    [self.cview registerClass:[CardVCCell class] forCellWithReuseIdentifier:@"cell"];
    self.cview.delegate = self;
    self.cview.backgroundColor = kWhiteColor;
    self.cview.dataSource = self;
    [self.view addSubview:self.cview];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CardVCCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell = [cell initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH-30, 160) imagestring:@"邮政银行" logostring:@"邮政logo" cardname:@"中国邮政储蓄银行" cardnum:@"1234567890098765432"];
    return cell;
}


-(void)myRecodeClick{
    AddCardVC * vc = [[AddCardVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
