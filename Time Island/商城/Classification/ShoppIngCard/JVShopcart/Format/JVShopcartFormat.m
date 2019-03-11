//
//  JVShopcartFormat.m
//  JVShopcart
//
//  Created by AVGD-Jarvi on 17/3/23.
//  Copyright © 2017年 AVGD-Jarvi. All rights reserved.
//

#import "JVShopcartFormat.h"
#import "JVShopcartBrandModel.h"
#import "MJExtension.h"
#import <UIKit/UIKit.h>

@interface JVShopcartFormat ()

@property (nonatomic, strong) NSMutableArray *shopcartListArray;    /**< 购物车数据源 */

@end

@implementation JVShopcartFormat

- (void)requestShopcartProductList {
    //在这里请求数据 当然我直接用本地数据模拟的
//    NSString *plistPath = [[NSBundle mainBundxle] pathForResource:@"shopcart" ofType:@"plist"];
//    http.code = @"629715";
//    http.parameters[@"userId"] = [TLUser user].userId;
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629715";
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
//        self.shopcartListArray = [JVShopcartBrandModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.delegate shopcartFormatRequestProductListDidSuccessWithArray:self.shopcartListArray];
        
        self.shopcartListArray = [JVShopcartBrandModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        //成功之后回调
        [self.delegate shopcartFormatRequestProductListDidSuccessWithArray:self.shopcartListArray];
        
    } failure:^(NSError *error) {
        
    }];
    
//    NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
    
}

- (void)selectProductAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected {
    JVShopcartBrandModel *brandModel = self.shopcartListArray[indexPath.section];
    JVShopcartProductModel *productModel = brandModel.cartList[indexPath.row];
    productModel.isSelected = isSelected;
    
    BOOL isBrandSelected = YES;
    
    for (JVShopcartProductModel *aProductModel in brandModel.cartList) {
        if (aProductModel.isSelected == NO) {
            isBrandSelected = NO;
        }
    }
    
    brandModel.isSelected = isBrandSelected;
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}

- (void)selectBrandAtSection:(NSInteger)section isSelected:(BOOL)isSelected {
    JVShopcartBrandModel *brandModel = self.shopcartListArray[section];
    brandModel.isSelected = isSelected;
    
    for (JVShopcartProductModel *aProductModel in brandModel.cartList) {
        aProductModel.isSelected = brandModel.isSelected;
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}

- (void)changeCountAtIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count {
    JVShopcartBrandModel *brandModel = self.shopcartListArray[indexPath.section];
    JVShopcartProductModel *productModel = brandModel.cartList[indexPath.row];
    if (count <= 0) {
        count = 1;
    } else if (count > 1000) {
        count = [productModel.quantity integerValue];
    }
    
    //根据请求结果决定是否改变数据
    productModel.quantity = [NSString stringWithFormat:@"%ld",count];
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}

- (void)deleteProductAtIndexPath:(NSIndexPath *)indexPath {
    JVShopcartBrandModel *brandModel = self.shopcartListArray[indexPath.section];
    JVShopcartProductModel *productModel = brandModel.cartList[indexPath.row];
    
    //根据请求结果决定是否删除
    [brandModel.cartList removeObject:productModel];
    if (brandModel.cartList.count == 0) {
        [self.shopcartListArray removeObject:brandModel];
    } else {
        if (!brandModel.isSelected) {
            BOOL isBrandSelected = YES;
            for (JVShopcartProductModel *aProductModel in brandModel.cartList) {
                if (!aProductModel.isSelected) {
                    isBrandSelected = NO;
                    break;
                }
            }
            
            if (isBrandSelected) {
                brandModel.isSelected = YES;
            }
        }
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
    
    if (self.shopcartListArray.count == 0) {
        [self.delegate shopcartFormatHasDeleteAllProducts];
    }
}

- (void)beginToDeleteSelectedProducts {
    NSMutableArray *selectedArray = [[NSMutableArray alloc] init];
    for (JVShopcartBrandModel *brandModel in self.shopcartListArray) {
        for (JVShopcartProductModel *productModel in brandModel.cartList) {
            if (productModel.isSelected) {
                [selectedArray addObject:productModel.code];
            }
        }
    }
    
    [self.delegate shopcartFormatWillDeleteSelectedProducts:selectedArray];
}

- (void)deleteSelectedProducts:(NSArray *)selectedArray {
    //网络请求
    //根据请求结果决定是否批量删除
    NSMutableArray *emptyArray = [[NSMutableArray alloc] init];
    for (JVShopcartBrandModel *brandModel in self.shopcartListArray) {
        [brandModel.cartList removeObjectsInArray:selectedArray];
        
        if (brandModel.cartList.count == 0) {
            [emptyArray addObject:brandModel];
        }
    }
    
    if (emptyArray.count) {
        [self.shopcartListArray removeObjectsInArray:emptyArray];
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
    
    if (self.shopcartListArray.count == 0) {
        [self.delegate shopcartFormatHasDeleteAllProducts];
    }
}

- (void)starProductAtIndexPath:(NSIndexPath *)indexPath {
    //这里写收藏的网络请求
    
}

- (void)starSelectedProducts {
    //这里写批量收藏的网络请求
    
}

- (void)selectAllProductWithStatus:(BOOL)isSelected {
    for (JVShopcartBrandModel *brandModel in self.shopcartListArray) {
        brandModel.isSelected = isSelected;
        for (JVShopcartProductModel *productModel in brandModel.cartList) {
            productModel.isSelected = isSelected;
        }
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}

- (void)settleSelectedProducts {
    NSMutableArray *settleArray = [[NSMutableArray alloc] init];
    for (JVShopcartBrandModel *brandModel in self.shopcartListArray) {
        NSMutableArray *selectedArray = [[NSMutableArray alloc] init];
        for (JVShopcartProductModel *productModel in brandModel.cartList) {
            if (productModel.isSelected) {
                [selectedArray addObject:productModel];
            }
        }
    
        brandModel.selectedArray = selectedArray;
        
        if (selectedArray.count) {
            [settleArray addObject:brandModel];
        }
    }
    
    [self.delegate shopcartFormatSettleForSelectedProducts:settleArray];
}

#pragma mark private methods

- (float)accountTotalPrice {
    float totalPrice = 0.f;
    for (JVShopcartBrandModel *brandModel in self.shopcartListArray) {
        for (JVShopcartProductModel *productModel in brandModel.cartList) {
            if (productModel.isSelected) {
                totalPrice += [productModel.amount integerValue] * [productModel.quantity integerValue];
            }
        }
    }
    
    return totalPrice;
}

- (NSInteger)accountTotalCount {
    NSInteger totalCount = 0;
    
    for (JVShopcartBrandModel *brandModel in self.shopcartListArray) {
        for (JVShopcartProductModel *productModel in brandModel.cartList) {
            if (productModel.isSelected) {
                totalCount += [productModel.quantity integerValue];
            }
        }
    }
    
    return totalCount;
}

- (BOOL)isAllSelected {
    if (self.shopcartListArray.count == 0) return NO;
    
    BOOL isAllSelected = YES;
    
    for (JVShopcartBrandModel *brandModel in self.shopcartListArray) {
        if (brandModel.isSelected == NO) {
            isAllSelected = NO;
        }
    }
    
    return isAllSelected;
}

@end
