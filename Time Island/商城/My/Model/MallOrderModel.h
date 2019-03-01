//
//  MallOrderModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/21.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MallOrderModel : NSObject

/**
 addressCode: "AD2019030110573372074265"
 amount: 10000
 applyDatetime: "Mar 1, 2019 10:58:06 AM"
 applyNote: ""
 applyUser: "U2019012215091204827860"
 applyUserName: "mmm15726952216"
 city: "合肥市"
 code: "COO2019030110580655063766"
 detailAddress: "44"
 detailList: [{code: "COOD2019030110580655374240", orderCode: "COO2019030110580655063766",…}]
 district: "瑶海区"
 expressType: "1"
 payAmount: 10000
 payGroup: "COO2019030110580655063766"
 postalFee: 0
 province: "安徽省"
 quantity: 1
 receiver: "444"
 receiverMobile: "444"
 receiverName: "444"
 remark: "超过支付时间平台自动取消"
 sellersName: "18772346905"
 settleStatus: "0"
 shopCode: "GS2018121115381942322109"
 shopOwner: "U2018121115381941985602"
 status: "5"
 updateDatetime: "Mar 1, 2019 11:50:00 AM"
 updater: "SYS_USER"
 */
@property (nonatomic,copy) NSString * addressCode;
@property (nonatomic,copy) NSString * amount;
@property (nonatomic,copy) NSString * applyDatetime;
@property (nonatomic,copy) NSString * applyNote;
@property (nonatomic,copy) NSString * applyUser;
@property (nonatomic,copy) NSString * applyUserName;
@property (nonatomic,copy) NSString * city;
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * detailAddress;
@property (nonatomic,copy) NSArray * detailList;
@property (nonatomic,copy) NSString * district;
@property (nonatomic,copy) NSString * expressType;
@property (nonatomic,copy) NSString * payAmount;
@property (nonatomic,copy) NSString * payGroup;
@property (nonatomic,copy) NSString * postalFee;
@property (nonatomic,copy) NSString * province;
@property (nonatomic,copy) NSString * quantity;
@property (nonatomic,copy) NSString * receiver;
@property (nonatomic,copy) NSString * receiverMobile;
@property (nonatomic,copy) NSString * receiverName;
@property (nonatomic,copy) NSString * remark;
@property (nonatomic,copy) NSString * sellersName;
@property (nonatomic,copy) NSString * settleStatus;
@property (nonatomic,copy) NSString * shopCode;
@property (nonatomic,copy) NSString * shopOwner;
@property (nonatomic,copy) NSString * status;//5已取消 。1代发货 。
@property (nonatomic,copy) NSString * updateDatetime;
@property (nonatomic,copy) NSString * updater;

@end

NS_ASSUME_NONNULL_END
