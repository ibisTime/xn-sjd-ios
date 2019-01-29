//
//  MyNoticeTableView.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/15.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "TLTableView.h"
#import "NoticeModel.h"
@interface MyNoticeTableView : TLTableView
@property (nonatomic,strong) NSMutableArray<NoticeModel *> * NoticeModels;
@end
