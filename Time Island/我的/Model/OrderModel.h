//
//  OrderModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/31.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderModel : NSObject
@property (nonatomic,copy) NSString * adoptYear;
@property (nonatomic,copy) NSString * amount;
@property (nonatomic,copy) NSString * applyDatetime;
@property (nonatomic,copy) NSString * applyUser;
@property (nonatomic,copy) NSString * applyUserName;
@property (nonatomic,copy) NSString * backJfAmount;
@property (nonatomic,copy) NSString * cnyDeductAmount;
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * endDatetime;
@property (nonatomic,copy) NSString * jfDeductAmount;
@property (nonatomic,copy) NSString * payAmount;
@property (nonatomic,copy) NSString * payDatetime;
@property (nonatomic,copy) NSString * payType;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * startDatetime;
@property (nonatomic,copy) NSString * settleStatus;
@property (nonatomic,copy) NSString * remark;
@property (nonatomic,copy) NSString * quantity;
@property (nonatomic,copy) NSString * productSpecsName;
@property (nonatomic,copy) NSString * productCode;
@property (nonatomic,copy) NSDictionary * product;
@end

NS_ASSUME_NONNULL_END
