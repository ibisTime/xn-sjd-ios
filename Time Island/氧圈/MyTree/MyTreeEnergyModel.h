//
//  MyTreeEnergyModel.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/28.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTreeEnergyModel : NSObject

@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *adoptUserId;
@property (nonatomic , copy)NSString *quantity;
@property (nonatomic , copy)NSString *createDatetime;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *invalidDatetime;
@property (nonatomic , copy)NSString *adoptTreeCode;


//"status" : "0",
//"adoptUserId" : "U2018120321304871394447",
//"quantity" : 0,
//"createDatetime" : "Jan 28, 2019 12:00:00 AM",
//"code" : "CBO2019012800000229166406",
//"invalidDatetime" : "Jan 31, 2019 12:00:00 AM",
//"adoptTreeCode" : "AOT2019012417243227481804"


@end
