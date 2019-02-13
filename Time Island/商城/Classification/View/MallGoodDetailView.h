//
//  MallGoodDetailView.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BaseView.h"
#import "MallGoodsModel.h"
@interface MallGoodDetailView : BaseView
@property (nonatomic ,strong) MallGoodsModel *treeModel;
@property (nonatomic ,copy)void(^CategoryBlock)(void);

@end
