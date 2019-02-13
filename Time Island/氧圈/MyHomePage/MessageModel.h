//
//  MessageModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/12.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageModel : NSObject
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * createDatetime;
@property (nonatomic,copy) NSString * object;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * userId;

@end

NS_ASSUME_NONNULL_END
