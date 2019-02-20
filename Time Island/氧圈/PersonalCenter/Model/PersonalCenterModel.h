//
//  PersonalCenterModel.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/2/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "TLTableView.h"

@interface PersonalCenterModel : TLTableView



@property (nonatomic , copy)NSString *ownerId;
@property (nonatomic , copy)NSString *productCode;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *amount;
@property (nonatomic , copy)NSString *userAdoptTreeCount;
@property (nonatomic , copy)NSString *isShelter;
@property (nonatomic , copy)NSString *treeNumber;
@property (nonatomic , copy)NSString *specsName;
@property (nonatomic , copy)NSString *orderType;
@property (nonatomic , copy)NSString *startDatetime;
@property (nonatomic , copy)NSString *certificateTemplate;
@property (nonatomic , copy)NSString *createDatetime;
@property (nonatomic , copy)NSString *endDatetime;
@property (nonatomic , copy)NSString *orderCode;
@property (nonatomic , copy)NSString *parentCategoryCode;
@property (nonatomic , copy)NSString *quantity;

@property (nonatomic , strong)NSDictionary *tree;
@property (nonatomic , strong)NSDictionary *user;
@property (nonatomic , copy)NSString *categoryCode;
@property (nonatomic , copy)NSString *currentHolder;
@end
