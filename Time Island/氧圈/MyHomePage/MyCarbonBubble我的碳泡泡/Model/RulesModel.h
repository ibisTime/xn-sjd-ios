//
//  RulesModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/21.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RulesModel : NSObject
/*
 ckey: "PUBLISH_ARTICLE"
 cvalue: "10"
 id: 93
 remark: "发布文章"
 type: "TPP_RULE"
 updateDatetime: "Feb 20, 2019 7:15:50 AM"
 updater: ""
 */
@property (nonatomic,copy) NSString * ckey;
@property (nonatomic,copy) NSString * cvalue;
@property (nonatomic,copy) NSString * remark;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * updateDatetime;
@end

NS_ASSUME_NONNULL_END
