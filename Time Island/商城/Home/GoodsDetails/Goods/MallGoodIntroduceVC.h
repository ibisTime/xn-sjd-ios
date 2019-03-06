//
//  MallGoodIntroduceVC.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLBaseVC.h"
#import "MallGoodsModel.h"
#import "GoodsModel.h"
@interface MallGoodIntroduceVC : TLBaseVC
@property (nonatomic ,strong) MallGoodsModel *treeModel;
@property (nonatomic ,strong) GoodsModel *model;
@property (nonatomic,strong) void (^clickmore)(void);
@end
