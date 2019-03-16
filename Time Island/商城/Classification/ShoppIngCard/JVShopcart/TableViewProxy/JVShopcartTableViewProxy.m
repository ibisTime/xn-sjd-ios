//
//  JVShopcartTableViewProxy.m
//  JVShopcart
//
//  Created by AVGD-Jarvi on 17/3/23.
//  Copyright © 2017年 AVGD-Jarvi. All rights reserved.
//

#import "JVShopcartTableViewProxy.h"
#import "JVShopcartBrandModel.h"
#import "JVShopcartCell.h"
#import "JVShopcartHeaderView.h"

@implementation JVShopcartTableViewProxy

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    JVShopcartBrandModel *brandModel = self.dataArray[section];
    NSArray *productArray = brandModel.cartList;
    return productArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JVShopcartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JVShopcartCell"];
    JVShopcartBrandModel *brandModel = self.dataArray[indexPath.section];
    NSArray *productArray = brandModel.cartList;
  
    if (productArray.count > indexPath.row) {
        JVShopcartProductModel *productModel = productArray[indexPath.row];
//        NSString *productName = [NSString stringWithFormat:@"%@%@%@", brandModel.brandName, productModel.productStyle, productModel.productType];
//        NSString *productSize = productModel.commodityName;
        [cell configureShopcartCellWithProductURL:
         [productModel.commodityPhoto convertImageUrl]
         productName:productModel.commodityName
         productSize:productModel.specsName productPrice:[productModel.amount integerValue] productCount:[productModel.quantity integerValue] productStock:1000 productSelected:productModel.isSelected];
    }
    
    __weak __typeof(self) weakSelf = self;
    cell.shopcartCellBlock = ^(BOOL isSelected){
        if (weakSelf.shopcartProxyProductSelectBlock) {
            weakSelf.shopcartProxyProductSelectBlock(isSelected, indexPath);
        }
    };
    
    cell.shopcartCellEditBlock = ^(NSInteger count){
        if (weakSelf.shopcartProxyChangeCountBlock) {
            weakSelf.shopcartProxyChangeCountBlock(count, indexPath);
        }
    };
    
    return cell;
}

#pragma mark UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    JVShopcartHeaderView *shopcartHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"JVShopcartHeaderView"];
    if (self.dataArray.count > section) {
        JVShopcartBrandModel *brandModel = self.dataArray[section];
        [shopcartHeaderView configureShopcartHeaderViewWithBrandName:brandModel.shopName brandSelect:brandModel.isSelected];
    }
    
    __weak __typeof(self) weakSelf = self;
    shopcartHeaderView.shopcartHeaderViewBlock = ^(BOOL isSelected){
        if (weakSelf.shopcartProxyBrandSelectBlock) {
            weakSelf.shopcartProxyBrandSelectBlock(isSelected, section);
        }
    };
    return shopcartHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (self.shopcartProxyDeleteBlock) {
            self.shopcartProxyDeleteBlock(indexPath);
        }
    }];
    
    UITableViewRowAction *starAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (self.shopcartProxyStarBlock) {
            self.shopcartProxyStarBlock(indexPath);
        }
    }];
    
    return @[deleteAction, starAction];
}

@end
