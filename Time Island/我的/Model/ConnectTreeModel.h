//
//  ConnectTreeModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/31.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConnectTreeModel : NSObject
@property (nonatomic,copy) NSString * amount;
@property (nonatomic,copy) NSString * categoryCode;
@property (nonatomic,copy) NSString * certificateTemplate;
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * createDatetime;
@property (nonatomic,copy) NSString * currentHolder;
@property (nonatomic,copy) NSString * endDatetime;
@property (nonatomic,copy) NSString * isShelter;
@property (nonatomic,copy) NSString * orderCode;
@property (nonatomic,copy) NSString * orderType;
@property (nonatomic,copy) NSString * ownerId;
@property (nonatomic,copy) NSString * parentCategoryCode;
@property (nonatomic,copy) NSString * productCode;
@property (nonatomic,copy) NSString * quantity;
@property (nonatomic,copy) NSString * specsName;
@property (nonatomic,copy) NSString * startDatetime;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * treeNumber;
@property (nonatomic,copy) NSDictionary * tree;
@property (nonatomic,copy) NSDictionary * user;
@end

NS_ASSUME_NONNULL_END
