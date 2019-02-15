//
//  HisDynamicCell.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicModel.h"
@interface HisDynamicCell : UITableViewCell

@property (nonatomic , strong)UIView *bottomLineView;
@property (nonatomic , strong)DynamicModel *dynamicArray;
@end
