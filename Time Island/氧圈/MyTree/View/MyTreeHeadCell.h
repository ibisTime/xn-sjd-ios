//
//  MyTreeHeadCell.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/10.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloatingBallHeader.h"
#import "MyTreeEnergyModel.h"
#import "PersonalCenterModel.h"
@protocol MyTreeHeadDelegate <NSObject>

-(void)MyTreeHeadButton:(NSInteger )tag;
-(void)paopaoclick:(MyTreeEnergyModel *)model;

@end

@interface MyTreeHeadCell : UITableViewCell<FloatingBallHeaderDelegate>

@property (nonatomic, strong) FloatingBallHeader *floatingBallHeader;

@property (nonatomic, assign) id <MyTreeHeadDelegate> delegate;

@property (nonatomic , strong)NSMutableArray <MyTreeEnergyModel *>*energyModels;

@property (nonatomic , strong)PersonalCenterModel *model;

@property (nonatomic,strong) NSString * protect;

@property (nonatomic,strong) UIButton * btn;
@end
