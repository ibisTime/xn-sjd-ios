//
//  RankingTableView.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "TLTableView.h"
#import "RankModel.h"
@interface RankingTableView : TLTableView
@property (nonatomic,strong) NSMutableArray<RankModel * > * RankModels;
@end
