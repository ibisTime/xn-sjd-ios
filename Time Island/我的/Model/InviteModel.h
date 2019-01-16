//
//  InviteModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface InviteModel : TLBaseModel
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * money;
@property (nonatomic,copy) NSString * time;
@end

NS_ASSUME_NONNULL_END
