//
//  SearchHistoryModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/26.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchHistoryModel : NSObject
/*
 code: "SH2019013011290077966215"
 content: "安庆"
 searchDatetime: "Jan 30, 2019 11:29:00 AM"
 type: "1"
 userId: "U2019012215091204827860"
 */
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * searchDatetime;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * userId;
@end

NS_ASSUME_NONNULL_END
