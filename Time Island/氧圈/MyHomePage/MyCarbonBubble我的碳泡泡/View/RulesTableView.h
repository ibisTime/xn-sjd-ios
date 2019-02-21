//
//  RulesTableView.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/21.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLTableView.h"
#import "RulesModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RulesTableView : TLTableView<UITableViewDelegate,UITableViewDataSource>

//@property (nonatomic,strong) NSMutableArray * RulesArray;
@property (nonatomic,strong) NSMutableArray<RulesModel *> * RulesModels;
@end

NS_ASSUME_NONNULL_END
