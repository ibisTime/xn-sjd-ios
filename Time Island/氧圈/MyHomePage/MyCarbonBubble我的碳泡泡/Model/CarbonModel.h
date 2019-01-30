//
//  CarbonModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/30.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarbonModel : NSObject
@property (nonatomic,copy) NSString * accountNumber;
@property (nonatomic,copy) NSString * accountType;
@property (nonatomic,copy) NSString * bizNote;
@property (nonatomic,copy) NSString * bizType;
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * createDatetime;
@property (nonatomic,copy) NSString * currency;
@property (nonatomic,copy) NSString * postAmountString;
@property (nonatomic,copy) NSString * remark;
@property (nonatomic,copy) NSString * transAmountString;
@property (nonatomic,copy) NSString * workDate;
@property (nonatomic,copy) NSString * preAmountString;
@end

NS_ASSUME_NONNULL_END
