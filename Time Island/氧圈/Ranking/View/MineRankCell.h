//
//  MineRankCell.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/11.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankModel.h"
#import "FriendsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MineRankCell : UITableViewCell
@property (nonatomic , strong)UIImageView *numberImg;
@property (nonatomic , strong)UILabel *numberLbl;
@property (nonatomic,strong) RankModel * RankModel;
@property (nonatomic,strong) FriendsModel * FriendsModel;
@end

NS_ASSUME_NONNULL_END
