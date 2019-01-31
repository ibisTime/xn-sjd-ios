//
//  MyCarbombubbleView.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarbonModel.h"
@interface MyCarbombubbleView : UIView
@property (nonatomic,strong) CarbonModel * CarbonModel;
@property (nonatomic,strong) UILabel *amountLbl;
@property (nonatomic,strong) NSArray * array;
@end
