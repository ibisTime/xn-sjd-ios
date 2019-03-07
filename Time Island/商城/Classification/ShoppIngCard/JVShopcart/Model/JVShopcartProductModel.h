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
//@property (nonatomic, copy) NSString* amount;       //价格
//
//@property (nonatomic, copy) NSString *productName;
//
//@property (nonatomic, copy) NSString *productPicUri;   //图片url


@property (nonatomic, copy) NSString* amount;       //价格
@property (nonatomic, copy) NSString* code;       //编号
@property (nonatomic, copy) NSString* commodityCode;       //商品编号
@property (nonatomic, copy) NSString* commodityName;       //商品名
@property (nonatomic, copy) NSString* commodityPhoto;       //商品图片
@property (nonatomic, copy) NSString* logistics;       //
@property (nonatomic, copy) NSString* quantity;       //数量
@property (nonatomic, copy) NSString* shopCode;       //商店编号
@property (nonatomic, copy) NSString* specsId;       //分类编号
@property (nonatomic, copy) NSString* specsName;       //d分类名称
@property (nonatomic, copy) NSString* status;       //状态
@property (nonatomic, copy) NSString* userId;       //用户编号


@property(nonatomic, assign)BOOL isSelected;    //记录相应row是否选中（自定义）

@end
