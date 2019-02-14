//
//  DynamicModel.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/2/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DynamicModel : NSObject
//"userId" : "U2019012322003723383946",
//"adoptUserId" : "U2019012215091204827860",
//"quantity" : 0,
//"id" : 7613,
//"createDatetime" : "Feb 14, 2019 10:38:03 AM",
//"type" : "3",
//"adoptTreeCode" : "AOT2019013110265517551089",
//"userInfo"
//adoptUserInfo

@property (nonatomic , copy)NSString *userId;
@property (nonatomic , copy)NSString *adoptUserId;
@property (nonatomic , copy)NSString *quantity;
@property (nonatomic , copy)NSString *ID;
@property (nonatomic , copy)NSString *createDatetime;
@property (nonatomic , copy)NSString *type;
@property (nonatomic , copy)NSString *adoptTreeCode;
@property (nonatomic , strong)NSDictionary *userInfo;
@property (nonatomic , strong)NSDictionary *adoptUserInfo;



@end
