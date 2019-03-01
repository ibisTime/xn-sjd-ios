//
//  MallGoodIntroduceTableView.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/2/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "TLTableView.h"
#import "MallGoodsModel.h"
#import "EvaluationModel.h"
@interface MallGoodIntroduceTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <EvaluationModel *>*evaluationModel;
@property (nonatomic ,strong) MallGoodsModel *treeModel;
@property (nonatomic,assign) float webViewHeight1;
@property (nonatomic,copy) void (^more)(void);
@end
