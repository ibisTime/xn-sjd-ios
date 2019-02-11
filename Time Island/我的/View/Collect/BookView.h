//
//  BookView.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLTableView.h"
#import "BookModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BookView : TLTableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray<BookModel *> * BookModels;
@end

NS_ASSUME_NONNULL_END
