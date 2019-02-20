//
//  FriendsTreeHeadCell.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloatingBallHeader.h"
#import "DonationAnimationView.h"
#import "PersonalCenterModel.h"
#import "MyTreeEnergyModel.h"
#import "BarrageModel.h"
#import "BarrageEncapsulationView.h"
@protocol FriendsTreeHeadDelegate <NSObject>

-(void)FriendsTreeHeadButton:(NSInteger )tag;
-(void)paopaoclick:(MyTreeEnergyModel *)model;

@end

@interface FriendsTreeHeadCell : UITableViewCell<FloatingBallHeaderDelegate>

@property (nonatomic , strong)BarrageModel *barrageModel;
@property (nonatomic , assign)NSInteger donation;

@property (nonatomic, strong) FloatingBallHeader *floatingBallHeader;

@property (nonatomic, assign) id <FriendsTreeHeadDelegate> delegate;

@property (nonatomic , strong)DonationAnimationView *animationView;

@property (nonatomic , strong)PersonalCenterModel *model;
@property (nonatomic , strong)NSMutableArray <MyTreeEnergyModel *>*energyModels;

@property (nonatomic , strong)BarrageEncapsulationView *barrView;

@end
