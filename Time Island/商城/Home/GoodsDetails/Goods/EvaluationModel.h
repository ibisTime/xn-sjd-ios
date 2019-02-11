//
//  EvaluationModel.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/2/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvaluationModel : NSObject


@property (nonatomic , copy)NSString *userId;
@property (nonatomic , copy)NSString *content;
@property (nonatomic , copy)NSString *commodityCode;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *nickname;
@property (nonatomic , strong)NSArray *nextCommentList;
@property (nonatomic , copy)NSString *commentDatetime;
@property (nonatomic , copy)NSString *cName;
@property (nonatomic , copy)NSString *parentCode;
@property (nonatomic , copy)NSString *photo;



@end
