//
//  TreeModel.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/25.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TreeModel : UITableViewHeaderFooterView



@property (nonatomic , copy)NSString *rank;
@property (nonatomic , copy)NSString *productCode;
@property (nonatomic , copy)NSString *province;
@property (nonatomic , copy)NSString *originPlace;
@property (nonatomic , copy)NSString *originalPrice;

@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *adoptCount;
@property (nonatomic , copy)NSString *updateDatetime;
@property (nonatomic , copy)NSString *articleCount;
@property (nonatomic , copy)NSString *treeNumber;
@property (nonatomic , copy)NSString *city;
@property (nonatomic , copy)NSString *category;
@property (nonatomic , copy)NSString *latitude;
@property (nonatomic , copy)NSString *productType;
@property (nonatomic , copy)NSString *town;
@property (nonatomic , copy)NSString *updater;
@property (nonatomic , copy)NSString *adoptUserNames;
@property (nonatomic , copy)NSString *pic;
@property (nonatomic , copy)NSString *longitude;
@property (nonatomic , copy)NSString *variety;
@property (nonatomic , copy)NSString *pointCount;
@property (nonatomic , copy)NSString *scientificName;
@property (nonatomic , copy)NSString *area;
@property (nonatomic , copy)NSString *age;
@property (nonatomic , copy)NSString *collectionCount;
@property (nonatomic , copy)NSString *productName;
@property (nonatomic , copy)NSString *remark;
@property (nonatomic , copy)NSString *curOrderCode;
@property (nonatomic , copy)NSString *ownerName;

@property (nonatomic,copy) NSString * name;
@property (nonatomic , copy)NSString *code;
@property (nonatomic,copy) NSString * sellType;
@property (nonatomic , copy)NSString *ownerId;
@property (nonatomic,copy) NSString * categoryCode;
@property (nonatomic,copy) NSString * listPic;
@property (nonatomic,copy) NSString * bannerPic;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * raiseStartDatetime;
@property (nonatomic,copy) NSString * raiseEndDatetime;
@property (nonatomic,copy) NSString * raiseCount;
@property (nonatomic,copy) NSString * nowCount;
@property (nonatomic,copy) NSString * Description;
@property (nonatomic,strong) NSArray * productSpecsList;
@end
