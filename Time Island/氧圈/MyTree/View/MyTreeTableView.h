//
//  MyTreeTableView.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/10.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "TLTableView.h"
#import "MyTreeEnergyModel.h"
#import "PersonalCenterModel.h"
#import "DynamicModel.h"
@interface MyTreeTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <MyTreeEnergyModel *>*energyModels;
@property (nonatomic , strong)PersonalCenterModel *model;
@property (nonatomic,strong) NSMutableArray<DynamicModel *> * DynamicModels;

@property (nonatomic,strong) NSMutableArray<DynamicModel *> * DynamicPhotoModels;
@end
