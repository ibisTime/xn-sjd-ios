//
//  PersonalCenterVC.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/28.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "TLBaseVC.h"
#import "RankModel.h"
#import "FriendsModel.h"

@interface PersonalCenterVC : TLBaseVC
@property (nonatomic, assign) BOOL isMultiSelection;
@property (nonatomic,strong) RankModel * RankModel;
@property (nonatomic,strong) FriendsModel * FriendsModel;
@property (nonatomic,strong) NSString * state;
@end
