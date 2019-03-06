//
//  MallCancelOrderView.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/5.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MallCancelOrderView : MallBaseVC<UITableViewDataSource,UITableViewDelegate,RefreshDelegate>
@property (nonatomic,copy) NSArray * statusList;

@end

NS_ASSUME_NONNULL_END
