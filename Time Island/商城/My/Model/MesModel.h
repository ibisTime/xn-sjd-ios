//
//  MesModel.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/1.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MesModel : NSObject
@property (nonatomic,copy) NSString * code ;
@property (nonatomic,copy) NSString * createDatetime ;
@property (nonatomic,copy) NSArray * messageList ;
@property (nonatomic,copy) NSString * mobile ;
@property (nonatomic,copy) NSString * type ;
@property (nonatomic,copy) NSString * user1 ;
@property (nonatomic,copy) NSString * user1Nickname ;
@property (nonatomic,copy) NSString * user1UnreadSum ;
@property (nonatomic,copy) NSString * user2 ;
@property (nonatomic,copy) NSString * user2UnreadSum ;
@end

NS_ASSUME_NONNULL_END
