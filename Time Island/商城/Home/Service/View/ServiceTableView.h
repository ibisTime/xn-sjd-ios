//
//  ServiceTableView.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/5.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLTableView.h"
#import "MesModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ServiceTableView : TLTableView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray<MesModel*> * model;
@property (nonatomic,assign) CGFloat height;

@end

NS_ASSUME_NONNULL_END
