//
//  PasswayModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/6.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PasswayModel : NSObject

/**
 EBusinessID: "1393243"
 LogisticCode: "804524344825276997"
 ShipperCode: "YTO"
 State: "3"
 Success: true
 Traces: [{AcceptStation: "【广东省广州市新增城市公司】 取件人: 丁新官 已收件", AcceptTime: "2019-02-24 19:01:05"},…]
 */
@property (nonatomic,copy) NSString * EBusinessID;
@property (nonatomic,copy) NSString * LogisticCode;
@property (nonatomic,copy) NSString * ShipperCode;
@property (nonatomic,copy) NSString * State;
@property (nonatomic,copy) NSString * Success;
@property (nonatomic,copy) NSArray * Traces;
@end

NS_ASSUME_NONNULL_END
