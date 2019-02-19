//
//  FriendInfoModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/19.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendInfoModel : NSObject

@property (nonatomic,copy) NSString * agentId;
@property (nonatomic,copy) NSString * certificateCount;
@property (nonatomic,copy) NSString * createDatetime;
@property (nonatomic,copy) NSString * emailBindFlag;
@property (nonatomic,copy) NSString * friendCount;
@property (nonatomic,copy) NSString * h5OpenId;
@property (nonatomic,copy) NSString * idNo;
@property (nonatomic,copy) NSString * kind;
@property (nonatomic,copy) NSString * level;
@property (nonatomic,copy) NSString * loginName;
@property (nonatomic,copy) NSString * loginPwdFlag;
@property (nonatomic,copy) NSString * loginPwdStrength;
@property (nonatomic,copy) NSString * mobile;
@property (nonatomic,copy) NSString * nickname;
@property (nonatomic,copy) NSString * photo;
@property (nonatomic,copy) NSString * realName;
@property (nonatomic,strong) NSDictionary * refereeUser;
@property (nonatomic,copy) NSString * rowNo;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * tradePwdStrength;
@property (nonatomic,copy) NSString * tradepwdFlag;
@property (nonatomic,strong) NSDictionary * userExt;
@property (nonatomic,copy) NSString * userId;
@property (nonatomic,copy) NSString * userReferee;
@property (nonatomic,copy) NSString * userRefereeType;
@property (nonatomic,copy) NSString * introduce;
@end

NS_ASSUME_NONNULL_END
