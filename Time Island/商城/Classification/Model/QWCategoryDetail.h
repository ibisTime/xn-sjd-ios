//
//  QWCategoryDetail.h
//  QW京东Demo
//
//  Created by mac on 16/1/20.
//  Copyright © 2016年 mac. All rights reserved.
//  详细分类（二三级分类）

#import <Foundation/Foundation.h>

#import "QWCategory.h"

@interface QWCategoryDetail : NSObject
/**
 *  头标题
 */
@property (nonatomic, strong) QWCategory *headerCategory;
/**
 *  第三级分类(SCCategory)
 */
@property (nonatomic, strong) NSArray *categories;

@end