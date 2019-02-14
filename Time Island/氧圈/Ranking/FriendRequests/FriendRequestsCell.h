//
//  FriendRequestsCell.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsModel.h"

@interface FriendRequestsCell : UITableViewCell
@property (nonatomic,strong) FriendsModel * FriendsModel;
@property (nonatomic,strong) UILabel *stateLbl;
@property (nonatomic,strong) UIButton *RefusedBtn;
@property (nonatomic,strong) UIButton *agreeBtn;
@end
