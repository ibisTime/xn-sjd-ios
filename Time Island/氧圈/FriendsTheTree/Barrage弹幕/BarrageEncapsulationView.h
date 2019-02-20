//
//  BarrageEncapsulationView.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarrageModel.h"
@interface BarrageEncapsulationView : UIView

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UIImageView *rightImg;

@property (nonatomic , strong)BarrageModel *model;

@end
