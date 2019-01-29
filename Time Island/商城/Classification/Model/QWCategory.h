//
//  QWCategory.h
//  QW京东Demo
//
//  Created by mac on 16/1/20.
//  Copyright © 2016年 mac. All rights reserved.
//  最高级分类目录

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface QWCategory : NSObject <MJKeyValue>
/**
 *  父级编号
 */
@property (nonatomic, copy) NSString *parentCode;
/**
 *  名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  顺序
 */
@property (nonatomic, copy) NSString *orderNo;
/**
 *  code
 */
@property (nonatomic, copy) NSString *code;
/**
 *  当前类的级别
 */
@property (nonatomic, copy) NSString *status;
/**
 *  图片
 */
@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *updater;

@property (nonatomic, copy) NSString *updateDatetime;

@property (nonatomic, copy) NSString *remark;

@end
