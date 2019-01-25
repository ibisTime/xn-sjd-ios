//
//  CardModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardModel : NSObject
@property (nonatomic,copy) NSString * bankCode;
@property (nonatomic,copy) NSString * bankName;
@property (nonatomic,copy) NSString * channelType;
@property (nonatomic,copy) NSString * payType;
@property (nonatomic,copy) NSString * paybank;
@property (nonatomic,copy) NSString * remark;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * subbranch;
@property (nonatomic,copy) NSString * currency;
@property (nonatomic,copy) NSString * bankcardNumber;
@property (nonatomic,copy) NSString * bindMobile;
@end

NS_ASSUME_NONNULL_END
