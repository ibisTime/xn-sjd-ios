//
//  BookContentCell.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/14.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BookContentCell : UITableViewCell
@property (nonatomic,strong) BookModel * BookModel;
@property (nonatomic,strong) UILabel * content;
@property (nonatomic,strong) void (^cellheight)(float height);
@property (nonatomic,strong) NSString * state;
@end

NS_ASSUME_NONNULL_END
