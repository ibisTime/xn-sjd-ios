//
//  MallCancelOrderModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/5.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MallCancelOrderModel : NSObject

/**
 address: {code: "AD2019022117450019142074", userId: "U2019012215091204827860", addressee: "456", mobile: "456",…}
 addressCode: "AD2019022117450019142074"
 afterSaleStatus: "2"
 amount: 10
 applyDatetime: "Mar 1, 2019 4:12:06 PM"
 applyUser: "U2019012215091204827860"
 backJfAmount: 0
 cnyDeductAmount: 0
 code: "COOD2019030116120696416435"
 commodityCode: "CO2018121315033972787088"
 commodityName: "脐橙121301"
 jfDeductAmount: 0
 jourCode: "AJ2019030116121515721255"
 listPic: "Fna7A8Cay7yzPAJFM-fFtQpwiOSS"
 logistics: "1"
 maxJfdkRate: 10
 orderCode: "COO2019030116120695239311"
 price: 10
 quantity: 1
 sellerName: "18772346905"
 shopCode: "GS2018121115381942322109"
 shopName: "18772346905"
 specsId: 10
 specsName: "脐橙12130112"
 status: "5"
 updateDatetime: "Mar 1, 2019 4:12:06 PM"
 */
@property (nonatomic,copy) NSDictionary * address;
@property (nonatomic,copy) NSString * addressCode;
@property (nonatomic,copy) NSString * afterSaleStatus;
@property (nonatomic,copy) NSString * amount;
@property (nonatomic,copy) NSString * applyDatetime;
@property (nonatomic,copy) NSString * applyUser;
@property (nonatomic,copy) NSString * backJfAmount;
@property (nonatomic,copy) NSString * cnyDeductAmount;
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * commodityCode;
@property (nonatomic,copy) NSString * commodityName;
@property (nonatomic,copy) NSString * jfDeductAmount;
@property (nonatomic,copy) NSString * jourCode;
@property (nonatomic,copy) NSString * listPic;
@property (nonatomic,copy) NSString * logistics;
@property (nonatomic,copy) NSString * maxJfdkRate;
@property (nonatomic,copy) NSString * orderCode;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * quantity;
@property (nonatomic,copy) NSString * sellerName;
@property (nonatomic,copy) NSString * shopCode;
@property (nonatomic,copy) NSString * shopName;
@property (nonatomic,copy) NSString * specsId;
@property (nonatomic,copy) NSString * specsName;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * updateDatetime;
@end

NS_ASSUME_NONNULL_END
