//
//  QWCategory.m
//  QW京东Demo
//
//  Created by mac on 16/1/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "QWCategory.h"

@implementation QWCategory

// 解决属性名与服务器参数key不一致的问题
+ (NSDictionary *)replacedKeyFromPropertyName {
    
    // key是属性名, value是参数名
    return @{@"detail_description" : @"description"};
}



@end
