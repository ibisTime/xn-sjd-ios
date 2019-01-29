//
//  NoticeModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/28.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoticeModel : NSObject
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * createDatetime;
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * title;
@end

NS_ASSUME_NONNULL_END
