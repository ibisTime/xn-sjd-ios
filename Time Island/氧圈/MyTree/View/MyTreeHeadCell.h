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
@protocol MyTreeHeadDelegate <NSObject>

-(void)MyTreeHeadButton:(NSInteger )tag;

@end

@interface MyTreeHeadCell : UITableViewCell<FloatingBallHeaderDelegate>

@property (nonatomic, strong) FloatingBallHeader *floatingBallHeader;

@property (nonatomic, assign) id <MyTreeHeadDelegate> delegate;

@property (nonatomic , strong)NSMutableArray <MyTreeEnergyModel *>*energyModels;

@end
