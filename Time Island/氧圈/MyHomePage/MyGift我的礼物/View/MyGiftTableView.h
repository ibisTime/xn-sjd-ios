//
//  MyGiftTableView.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/15.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "TLTableView.h"
#import "GiftModel.h"
@interface MyGiftTableView : TLTableView
@property (nonatomic,strong) NSMutableArray<GiftModel *> * GiftModel;
@end
