//
//  CertificateModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/11.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CertificateModel : NSObject

/**
 amount: 110000
 categoryCode: "C2018120321534283696643"
 certificateTemplate: "Fn4tdcTUYBbu94w_gxe9KaPgITAB"
 code: "AOT2018121115495380021401"
 createDatetime: "Dec 11, 2018 3:49:53 PM"
 currentHolder: "U2018120411280026923563"
 endDatetime: "Jan 31, 2019 11:59:59 PM"
 isShelter: "0"
 orderCode: "GO2018121115494404589592"
 orderType: "5"
 ownerId: "U2018120409334461763926"
 parentCategoryCode: "C2018120321532672463996"
 productCode: "PP2018121114234504275254"
 startDatetime: "Dec 11, 2018 12:00:00 AM"
 status: "2"
 tree: {code: "T2018121114234505067911", productType: "1", productCode: "PP2018121114234504275254",…}
 treeNumber: "cw1211002"
 user
 */
@property (nonatomic,copy) NSString * amount;
@property (nonatomic,copy) NSString * categoryCode;
@property (nonatomic,copy) NSString * certificateTemplate;
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * createDatetime;
@property (nonatomic,copy) NSString * currentHolder;
@property (nonatomic,copy) NSString * endDatetime;
@property (nonatomic,copy) NSString * isShelter;
@property (nonatomic,copy) NSString * orderCode;
@property (nonatomic,copy) NSString * orderType;
@property (nonatomic,copy) NSString * ownerId;
@property (nonatomic,copy) NSString * parentCategoryCode;
@property (nonatomic,copy) NSString * productCode;
@property (nonatomic,copy) NSString * startDatetime;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSDictionary * tree;
@property (nonatomic,copy) NSString * treeNumber;
@property (nonatomic,copy) NSDictionary * user;
@end

NS_ASSUME_NONNULL_END
