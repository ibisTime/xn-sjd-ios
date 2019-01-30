//
//  MyCarbonBubbleCell.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarbonModel.h"
@interface MyCarbonBubbleCell : UITableViewCell
@property (nonatomic,strong) CarbonModel * CarbonModel;
@property (nonatomic,strong) UILabel *nameLbl;
@property (nonatomic,strong) UILabel *timeLbl;
@property (nonatomic,strong) UILabel *numberLbl;
@property (nonatomic,strong) UIImageView *iconImg;
@end
