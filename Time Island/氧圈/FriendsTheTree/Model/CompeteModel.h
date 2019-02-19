//
//  CompeteModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/19.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompeteModel : NSObject
@property (nonatomic,copy) NSString * userWeekQuantity;
@property (nonatomic,copy) NSString * toUserWeekQuantity;
@property (nonatomic,strong) NSDictionary * toUserInfo;
@property (nonatomic,strong) NSDictionary * userInfo;
@end

NS_ASSUME_NONNULL_END
