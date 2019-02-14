//
//  FriendsModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/14.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendsModel : NSObject
@property (nonatomic,strong) NSString * certificateCount;
@property (nonatomic,strong) NSString * code;
@property (nonatomic,strong) NSString * createDatetime;
@property (nonatomic,strong) NSString * rowNo;
@property (nonatomic,strong) NSString * status;
@property (nonatomic,strong) NSString * toUser;
@property (nonatomic,strong) NSString * type;
@property (nonatomic,strong) NSString * userId;
@property (nonatomic,strong) NSString * nickname;
@property (nonatomic,strong) NSString * tppAmount;
@property (nonatomic,strong) NSDictionary * fromUserInfo;
@property (nonatomic,strong) NSDictionary * toUserInfo;
@end

NS_ASSUME_NONNULL_END
