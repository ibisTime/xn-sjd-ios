//
//  GiftModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/27.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GiftModel : NSObject
/**
 adoptTreeCode: "AOT2018120614274833576887"
 area: "西湖区"
 city: "杭州市"
 claimDatetime: "Dec 6, 2018 3:44:44 PM"
 claimer: "U2018120411280026923563"
 claimerName: "]//-18966164445"
 code: "GO2018120615433453157690"
 createDatetime: "Dec 6, 2018 3:43:34 PM"
 description: "<p><img src="http://image.o2lin.com/4.jpg_1544082202635" style="max-width:100%;"><br></p>"
 invalidDatetime: "Dec 6, 2018 12:00:00 AM"
 listPic: "Ftt95N5x92PSOva4gyLobHVPfT_m"
 name: "树叶"
 price: 10000
 province: "浙江省"
 reAddress: "顶替"
 reMobile: "13588465354"
 receiver: "陈 "
 status: "2"
 toUser: "U2018120411280026923563"
 */
@property (nonatomic,copy) NSString * adoptTreeCode;
@property (nonatomic,copy) NSString * area;
@property (nonatomic,copy) NSString * city;
@property (nonatomic,copy) NSString * claimDatetime;
@property (nonatomic,copy) NSString * claimer;
@property (nonatomic,copy) NSString * claimerName;

@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * createDatetime;
@property (nonatomic,copy) NSString * Description;
@property (nonatomic,copy) NSString * invalidDatetime;
@property (nonatomic,copy) NSString * listPic;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * province;
@property (nonatomic,copy) NSString * reAddress;
@property (nonatomic,copy) NSString * reMobile;
@property (nonatomic,copy) NSString * receiver;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * toUser;
+(NSDictionary *)mj_replacedKeyFromPropertyName;
@end

NS_ASSUME_NONNULL_END
