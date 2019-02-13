//
//  MessageCell.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/12.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MessageCell : UITableViewCell
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UILabel * time;
@property (nonatomic,strong) NSArray * array;
@property (nonatomic,strong) MessageModel * MessageModel;
@end

NS_ASSUME_NONNULL_END
