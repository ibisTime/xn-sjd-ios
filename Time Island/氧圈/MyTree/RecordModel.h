//
//  RecordModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/20.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecordModel : NSObject
/*
 "code": "MR201809291609461096144",
 "treeNumber": "T0012",
 "projectCode": "MP201809291559140079750",
 "projectName": "cut gress",
 "maintainerCode": "M201809291543171072916",
 "maintainerName": "tony",
 "pic": "",
 "description": "",
 "updater": "001",
 "updateDatetime": "Sep 29, 2018 4:12:16 PM",
 "remark": ""
 */


@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * treeNumber;
@property (nonatomic,copy) NSString * projectCode;
@property (nonatomic,copy) NSString * projectName;
@property (nonatomic,copy) NSString * maintainerCode;
@property (nonatomic,copy) NSString * maintainerName;
@property (nonatomic,copy) NSString * pic;
@property (nonatomic,copy) NSString * description;
@property (nonatomic,copy) NSString * updater;
@property (nonatomic,copy) NSString * updateDatetime;
@property (nonatomic,copy) NSString * remark;
@end

NS_ASSUME_NONNULL_END
