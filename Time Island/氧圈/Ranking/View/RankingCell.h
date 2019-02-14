//
//  RankingCell.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankModel.h"
#import "FriendsModel.h"
@interface RankingCell : UITableViewCell


@property (nonatomic , strong)UIImageView *numberImg;
@property (nonatomic , strong)UILabel *numberLbl;
@property (nonatomic,strong) RankModel * RankModel;
@property (nonatomic,strong) FriendsModel * FriendsModel;
@end
