//
//  FriendsTheTreeTableView.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "TLTableView.h"
#import "PersonalCenterModel.h"
#import "MyTreeEnergyModel.h"
#import "CompeteModel.h"
#import "DynamicModel.h"
#import "BarrageModel.h"
@interface FriendsTheTreeTableView : TLTableView

@property (nonatomic , assign)NSInteger donation;
@property (nonatomic , strong)PersonalCenterModel *model;
@property (nonatomic , strong)NSMutableArray <MyTreeEnergyModel *>*energyModels;
@property (nonatomic,strong) CompeteModel * CompeteModel;
@property (nonatomic,strong) NSMutableArray<DynamicModel *> * DynamicModels;

@property (nonatomic , strong)BarrageModel *barrageModel;
@property (nonatomic,strong) NSString * state;
@end
