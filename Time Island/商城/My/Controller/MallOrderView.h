//
//  MallOrderView.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/21.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallBaseVC.h"

NS_ASSUME_NONNULL_BEGIN


@interface MallOrderView : MallBaseVC<UITableViewDataSource,UITableViewDelegate,RefreshDelegate>
@property (nonatomic,strong) NSString * status;
@property (nonatomic,strong) NSArray * statusList;
@end

NS_ASSUME_NONNULL_END
