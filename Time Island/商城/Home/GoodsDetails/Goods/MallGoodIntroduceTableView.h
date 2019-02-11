//
//  MallGoodIntroduceTableView.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/2/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "TLTableView.h"
#import "MallTreeModel.h"
#import "EvaluationModel.h"
@interface MallGoodIntroduceTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <EvaluationModel *>*evaluationModel;
@property (nonatomic ,strong) MallTreeModel *treeModel;
@end
