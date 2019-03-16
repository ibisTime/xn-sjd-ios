//
//  commodityOrderDetailModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/8.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface commodityOrderDetailModel : NSObject

/**
 "code": "COOD2019030814222421561826",
 "orderCode": "COO2019030814222420315696",
 "shopCode": "GS2018121115381942322109",
 "commodityCode": "CO2018121315033972787088",
 "commodityName": "脐橙121301",
 "specsId": 10,
 "specsName": "脐橙12130112",
 "applyUser": "U2019012215091204827860",
 "applyDatetime": "Mar 8, 2019 2:22:24 PM",
 "quantity": 1,
 "price": 10,
 "amount": 10,
 "maxJfdkRate": 10,
 "cnyDeductAmount": 0,
 "jfDeductAmount": 0,
 "backJfAmount": 0,
 "listPic": "Fna7A8Cay7yzPAJFM-fFtQpwiOSS",
 "addressCode": "AD2019022117450019142074",
 "status": "4",
 "updateDatetime": "Mar 8, 2019 2:22:24 PM",
 "commodity": {
 }
 */

@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * orderCode;
@property (nonatomic,copy) NSString * shopCode;
@property (nonatomic,copy) NSString * commodityCode;
@property (nonatomic,copy) NSString * commodityName;
@property (nonatomic,copy) NSString * specsId;
@property (nonatomic,copy) NSString * specsName;
@property (nonatomic,copy) NSString * applyUser;
@property (nonatomic,copy) NSString * applyDatetime;
@property (nonatomic,copy) NSString * quantity;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * amount;
@property (nonatomic,copy) NSString * maxJfdkRate;
@property (nonatomic,copy) NSString * cnyDeductAmount;
@property (nonatomic,copy) NSString * jfDeductAmount;
@property (nonatomic,copy) NSString * backJfAmount;
@property (nonatomic,copy) NSString * listPic;
@property (nonatomic,copy) NSString * addressCode;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * updateDatetime;
@property (nonatomic,copy) NSDictionary * commodity;
@end

NS_ASSUME_NONNULL_END
