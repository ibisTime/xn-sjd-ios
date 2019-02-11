//
//  RuleModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/11.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuleModel : NSObject
@property (nonatomic,strong) NSString * ckey;
@property (nonatomic,strong) NSString * cvalue;
@property (nonatomic,strong) NSString * remark;
@property (nonatomic,strong) NSString * type;
@property (nonatomic,strong) NSString * updateDatetime;
@end

NS_ASSUME_NONNULL_END
