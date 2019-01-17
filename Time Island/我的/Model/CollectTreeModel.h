//
//  CollectTreeModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectTreeModel : TLBaseModel
@property (nonatomic ,copy) NSString *code;
@property (nonatomic ,copy) NSString *Description;

@property (nonatomic ,copy) NSString *avgChange;
@property (nonatomic ,copy) NSString *bestChange;
@property (nonatomic ,copy) NSString *worstChange;
@property (nonatomic ,copy) NSString *bestSymbol;
@property (nonatomic ,copy) NSString *worstSymbol;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *location;
@property (nonatomic ,copy) NSString *orderNo;
@property (nonatomic ,copy) NSString *status;
@property (nonatomic ,copy) NSString *createDatetime;
@property (nonatomic ,copy) NSString *updater;
@property (nonatomic ,copy) NSString *updateDatetime;
@property (nonatomic ,copy) NSString *remark;

@property (nonatomic ,copy) NSString *upCount;
@property (nonatomic ,copy) NSString *downCount;
@property (nonatomic ,copy) NSString *totalCount;
@property (nonatomic ,strong) NSMutableArray *list;
@end

NS_ASSUME_NONNULL_END
