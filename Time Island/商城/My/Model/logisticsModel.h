//
//  logisticsModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/6.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface logisticsModel : NSObject

@property (nonatomic,copy) NSString * dkey;
@property (nonatomic,copy) NSString * dvalue;
@property (nonatomic,copy) NSString * Id;
@property (nonatomic,copy) NSString * parentKey;
@property (nonatomic,copy) NSString * remark;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * updateDatetime;
@property (nonatomic,copy) NSString * updater;
@property (nonatomic,copy) NSString * updaterName;

@end

NS_ASSUME_NONNULL_END
