//
//  PersonalCenterHeadView.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/28.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankModel.h"
#import "FriendsModel.h"
#import "FriendInfoModel.h"

@protocol AddFriendBtn <NSObject>

-(void)AddFriend:(NSString *)toUser;

@end

@interface PersonalCenterHeadView : UIView

//@property (nonatomic,strong) RankModel * RankModel;
//@property (nonatomic,strong) FriendsModel * FriendsModel;
@property (nonatomic,strong) FriendInfoModel * FriendInfoModel;
@property (nonatomic,strong) NSString * state;
@property (nonatomic,weak) id<AddFriendBtn> delegate;
@end
