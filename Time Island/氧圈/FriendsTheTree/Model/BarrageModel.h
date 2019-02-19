//
//  BarrageModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/19.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BarrageModel : NSObject
/*
 code: "BA2018120510430449397633",
 content: "给你点个赞！",
 pic: "Ft6BucQ4Q_vnQai3zmAR5mIME-Yr",
 status: "1",…}
 code: "BA2018120510430449397633"
 content: "给你点个赞！"
 orderNo: "1"
 pic: "Ft6BucQ4Q_vnQai3zmAR5mIME-Yr"
 status: "1"
 updateDatetime: "Dec 5, 2018 10:43:14 AM"
 updater: "UCOIN201700000000000001"

 */

@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * pic;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * updateDatetime;
@property (nonatomic,copy) NSString * updater;
@end

NS_ASSUME_NONNULL_END
