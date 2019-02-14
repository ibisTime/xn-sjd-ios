//
//  PersonalCenterCell.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/2/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalCenterModel.h"
@interface PersonalCenterCell : UITableViewCell
@property (nonatomic , strong)PersonalCenterModel *models;

@property (nonatomic , strong)UILabel *nameLable;
@property (nonatomic , strong)UILabel *timeLbl;
@property (nonatomic , strong)UILabel *addressLable;
@property (nonatomic , strong)UILabel *promptLbl;
@end
