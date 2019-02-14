//
//  FriendRequestsTableView.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "TLTableView.h"
#import "FriendsModel.h"
@interface FriendRequestsTableView : TLTableView
@property (nonatomic,strong) NSMutableArray<FriendsModel *> * FriendsModels;
@end
