//
//  SpecsListModel.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/28.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecsListModel : NSObject
@property (nonatomic , copy)NSString *id;
@property (nonatomic , copy)NSString *commodityCode;
@property (nonatomic , copy)NSString *name;
@property (nonatomic , copy)NSString *price;
@property (nonatomic , copy)NSString *inventory;
@property (nonatomic , copy)NSString *remark;
@end
