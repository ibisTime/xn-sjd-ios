//
//  OrderView.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderView : TLBaseVC<UITableViewDataSource,UITableViewDelegate,RefreshDelegate>
@property (nonatomic,strong) NSString * status;

@end

NS_ASSUME_NONNULL_END
