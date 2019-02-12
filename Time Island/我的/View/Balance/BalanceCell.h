//
//  BalanceCell.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/11.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarbonModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BalanceCell : UITableViewCell
@property (nonatomic,strong) CarbonModel * CarbonModel;
@property (nonatomic,strong) UILabel *nameLbl;
@property (nonatomic,strong) UILabel *timeLbl;
@property (nonatomic,strong) UILabel *numberLbl;
@property (nonatomic,strong) UIImageView *iconImg;
@end

NS_ASSUME_NONNULL_END
