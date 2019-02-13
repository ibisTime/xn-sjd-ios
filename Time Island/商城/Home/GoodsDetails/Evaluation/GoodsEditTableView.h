//
//  GoodsEditTableView.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/2/12.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "TLTableView.h"
#import "EvaluationModel.h"
@interface GoodsEditTableView : TLTableView


@property (nonatomic , strong)NSMutableArray <EvaluationModel *>*evaluationModel;
@end
