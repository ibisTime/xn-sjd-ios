//
//  CollectEnergyDetailsCell.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/10.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalCenterModel.h"
#import "DynamicModel.h"
@interface CollectEnergyDetailsCell : UITableViewCell
@property (nonatomic , strong)PersonalCenterModel *model;
@property (nonatomic,strong)  DynamicModel * DynamicModel;
@end
