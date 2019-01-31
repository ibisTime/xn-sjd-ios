//
//  RenYangUserModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/30.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RenYangUserModel : NSObject
@property (nonatomic,copy) NSString * amount;
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * currentHolder;
@property (nonatomic,copy) NSString * startDatetime;
@property (nonatomic,copy) NSString * treeNumber;
@property (nonatomic,copy) NSString * userAdoptTreeCount;
@property (nonatomic,copy) NSArray * tree;
@property (nonatomic,copy) NSDictionary * user;
@end

NS_ASSUME_NONNULL_END
