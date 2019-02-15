//
//  DanmuCell.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DanmuCell : UITableViewCell
@property (nonatomic , strong)DynamicModel *dynamicModel;
@property (nonatomic , strong)UIView *bottomLineView;

@end

NS_ASSUME_NONNULL_END
