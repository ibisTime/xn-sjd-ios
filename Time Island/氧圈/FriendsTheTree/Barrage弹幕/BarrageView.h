//
//  BarrageView.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarrageModel.h"
@interface BarrageView : UIView

@property (nonatomic , strong)UIButton *ShutDownBtn;

@property (nonatomic,strong) NSMutableArray<BarrageModel *> * BarrageModels;

@property (nonatomic,strong)UICollectionView *collectionView;

@end
