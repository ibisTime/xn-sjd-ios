//
//  FriendsTreeHeadCell.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloatingBallHeader.h"

@protocol FriendsTreeHeadDelegate <NSObject>

-(void)FriendsTreeHeadButton:(NSInteger )tag;

@end

@interface FriendsTreeHeadCell : UITableViewCell<FloatingBallHeaderDelegate>

@property (nonatomic, strong) FloatingBallHeader *floatingBallHeader;

@property (nonatomic, assign) id <FriendsTreeHeadDelegate> delegate;

@end
