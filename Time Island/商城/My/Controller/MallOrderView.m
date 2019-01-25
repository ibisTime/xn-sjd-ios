//
//  MallOrderView.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/21.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallOrderView.h"
#import "MallOrderCell.h"
#import "MallOrderDetailVC.h"
@interface MallOrderView ()<MallOrderCellDelegrate>
@property (nonatomic,strong) TLTableView * table;

@end

@implementation MallOrderView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.table = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 40)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.refreshDelegate = self;
    [self.table registerClass:[MallOrderCell class] forCellReuseIdentifier:@"mallordercell"];
    [self.view addSubview:self.table];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MallOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mallordercell" forIndexPath:indexPath];
    cell.delagate = self;
    cell.ShopName.text = @"店铺名称商品名称";
    cell.GoodsMoney.text = @"¥2480.00";
    cell.GoodsTotal.text = @"合计1件商品";
    cell.GoodsDescribe.text = @"规格分类：10斤装";
    cell.GoodsName.text = @"商品名称商品名称商品名称商品名称";
    cell.GoodsCount.text = @"x1";
    cell.GoodsImage.image = kImage(@"树 跟背景");
    cell.OrderTime.text = @"2018-01-09";
    if (indexPath.section == 0) {
        cell.OrderState = 1;
    }
    else{
        cell.OrderState = 2;
    }

    //商店名称自适应
    [cell.ShopNameBtn setTitle:@"店铺名称商品名称店铺名称商品名称店铺名称商品名称店铺名称商品名称" forState:UIControlStateNormal];
    [cell.ShopNameBtn sizeToFit];
    if (cell.ShopNameBtn.width > SCREEN_WIDTH / 2 - 15 - 10.5) {
        cell.ShopNameBtn.frame = CGRectMake(15, 4.5, SCREEN_WIDTH / 2 - 15 - 10.5, 26.5);
    }
    else{
        cell.ShopNameBtn.frame = CGRectMake(15, 4.5, cell.ShopNameBtn.width + 15, 26.5);
    }

    [cell.ShopNameBtn SG_imagePositionStyle:SGImagePositionStyleRight spacing:3.5 imagePositionBlock:^(UIButton *button) {
        [button setImage:kImage(@"跳转") forState:UIControlStateNormal];
    }];
    
    
    //商品名称自适应
    [cell.GoodsName sizeToFit];
    if (cell.GoodsName.width > SCREEN_WIDTH - 100 - 100) {
        cell.GoodsName.frame = CGRectMake(cell.GoodsImage.xx + 10, cell.GoodsImage.y,SCREEN_WIDTH - 100 - 100, 21);
    }
    else
    {
        cell.GoodsName.frame = CGRectMake(cell.GoodsImage.xx + 10, cell.GoodsImage.y,cell.GoodsName.width, 21);
    }
    
    
    
    cell.selectionStyle = UIAccessibilityTraitNone;
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 185;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MallOrderDetailVC *detailVC  = [MallOrderDetailVC new];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
-(void)MallOrderCell:(MallOrderCell *)tableViewCell clickDeleteButton:(UIButton *)sender{
    NSLog(@"%d",(int)sender.tag);
}
@end
