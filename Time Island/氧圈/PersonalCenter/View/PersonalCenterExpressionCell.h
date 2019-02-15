//
//  PersonalCenterExpressionCell.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/2/15.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicModel.h"
@interface PersonalCenterExpressionCell : UITableViewCell
@property (nonatomic , strong)DynamicModel *dynamicModel;
@property (nonatomic , strong)UIView *bottomLineView;
@end
