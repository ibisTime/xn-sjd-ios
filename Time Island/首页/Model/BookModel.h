//
//  BookModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/28.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookModel : NSObject
@property (nonatomic,copy) NSString * updateDatatime;
@property (nonatomic,copy) NSString * productCode;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * publishUserName;
@property (nonatomic,strong) NSDictionary * adoptOrderTree;
@property (nonatomic,copy) NSString * publishDatetime;
@property (nonatomic,copy) NSString * treeName;
@property (nonatomic,copy) NSString * readCount;
@property (nonatomic,copy) NSString * orderNo;
@property (nonatomic,copy) NSString * publishUserId;
@property (nonatomic,copy) NSString * adoptTreeCode;
@property (nonatomic,copy) NSString * photo;
@property (nonatomic,copy) NSString * collectCount;
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * treeNumber;
@property (nonatomic,copy) NSString * pointCount;
@property (nonatomic,copy) NSString * openLevel;
@property (nonatomic,copy) NSString * productName;
@property (nonatomic,copy) NSString * productStatus;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * treeNo;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * updater;
@end

NS_ASSUME_NONNULL_END
