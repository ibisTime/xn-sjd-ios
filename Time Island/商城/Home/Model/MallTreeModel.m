//
//  MallTreeModel.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/28.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallTreeModel.h"
#import "SpecsListModel.h"
@implementation MallTreeModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Description": @"description"};
}
+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"courses" : [SpecsListModel class]};
}
@end
