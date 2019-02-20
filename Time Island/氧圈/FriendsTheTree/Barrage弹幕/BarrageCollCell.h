//
//  BarrageCollCell.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/2/19.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarrageModel.h"
@interface BarrageCollCell : UICollectionViewCell


@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UIImageView *rightImg;
@property (nonatomic , strong)BarrageModel *model;
@end
