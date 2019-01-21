//
//  ReceivingAddressVC.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/18.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReceivingAddressVC : MallBaseVC<UITableViewDelegate,UITableViewDataSource,RefreshDelegate>
@property int state;
@end

NS_ASSUME_NONNULL_END
