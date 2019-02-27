//
//  PersonalCenterTableVIew.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/28.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "TLTableView.h"
#import "PersonalCenterModel.h"
#import "DynamicModel.h"
#import "CompeteModel.h"
#import "RankModel.h"
@interface PersonalCenterTableVIew : TLTableView

@property (nonatomic , strong)NSMutableArray <PersonalCenterModel *>*models;
@property (nonatomic , strong)NSArray *dynamicArray;
@property (nonatomic,strong) RankModel * RankModel;
@property (nonatomic,strong) NSString * state;
@property (nonatomic,strong) CompeteModel * CompeteModel;
@end
