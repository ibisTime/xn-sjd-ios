//
//  IntroduceModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntroduceModel : NSObject
/*
 code: "XX2018120409255593522248"
 content: "<h4 align="center" style="text-align:center;line-h"
 createDatetime: "Dec 4, 2018 9:25:55 AM"
 object: "C"
 publishDatetime: "Dec 4, 2018 9:25:38 AM"
 remark: ""
 status: "1"
 title: "氧林平台最长标题测试公告一一一一一一一一一一一一一一一"
 type: "1"
 updateDatetime: "Dec 4, 2018 9:28:23 AM"
 updater: "UCOIN201700000000000001"
 updaterName: "admin"
 */

@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * createDatetime;
@property (nonatomic,copy) NSString * object;
@property (nonatomic,copy) NSString * publishDatetime;
@property (nonatomic,copy) NSString * remark;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * updateDatetime;
@property (nonatomic,copy) NSString * updater;
@property (nonatomic,copy) NSString * updaterName;
@end

NS_ASSUME_NONNULL_END
