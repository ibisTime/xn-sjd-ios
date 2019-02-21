//
//  FriendsTheTreeVC.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "TLBaseVC.h"
#import "PersonalCenterModel.h"
#import "DynamicModel.h"
@interface FriendsTheTreeVC : TLBaseVC
@property (nonatomic , strong)PersonalCenterModel *model;
@property (nonatomic,strong) DynamicModel * DynamicModel;
@property (nonatomic,strong) NSMutableArray * Info;
@end
