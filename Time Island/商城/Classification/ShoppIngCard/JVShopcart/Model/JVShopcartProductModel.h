//
//  JVShopcartProductModel.h
//  JVShopcart
//
//  Created by AVGD-Jarvi on 17/3/23.
//  Copyright © 2017年 AVGD-Jarvi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JVShopcartProductModel : NSObject

//@property (nonatomic, assign) NSInteger specWidth;      //宽
//
//@property (nonatomic, assign) NSInteger specHeight;     //高
//
//@property (nonatomic, assign) NSInteger specLength;     //长
//
//@property (nonatomic, copy) NSString *productStyle;
//
//@property (nonatomic, copy) NSString *brandPicUri;
//
//@property (nonatomic, copy) NSString *productId;
//
//@property (nonatomic, copy) NSString *productType;
//
//@property (nonatomic, copy) NSString *brandName;   //品牌名
//
//@property (nonatomic, copy) NSString *brandId;
//
//@property (nonatomic, assign) NSInteger productStocks;      //库存
//
//@property (nonatomic, copy) NSString *productNum;
//
//@property (nonatomic, copy) NSString *cartId;
//
//@property (nonatomic, assign) NSInteger productQty;         //商品数
//
//@property (nonatomic, assign) NSInteger originPrice;
//
//@property (nonatomic, assign) NSInteger productPrice;       //价格
//
//@property (nonatomic, copy) NSString *productName;
//
//@property (nonatomic, copy) NSString *productPicUri;   //图片url

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *shopCode;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *commodityCode;
@property (nonatomic, copy) NSString *commodityName;
@property (nonatomic, copy) NSString *specsId;
@property (nonatomic, copy) NSString *specsName;
@property (nonatomic, copy) NSString *quantity;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *commodityPhoto;
@property (nonatomic, copy) NSString *logistics;
//"code": "CA2019030715423759365104",
//"shopCode": "GS2018121115381942322109",
//"userId": "U2019012322003723383946",
//"commodityCode": "CO2018121315033972787088",
//"commodityName": "脐橙121301",
//"specsId": 9,
//"specsName": "脐橙1213011",
//"quantity": 1,
//"amount": 10000,
//"status": "1",
//"commodityPhoto": "Fna7A8Cay7yzPAJFM-fFtQpwiOSS",
//"logistics": "1"



@property(nonatomic, assign)BOOL isSelected;    //记录相应row是否选中（自定义）

@end
