//
//  OxygenCircleView.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/10.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OxygenCircleDelegate <NSObject>

-(void)OxygenCircleButton:(NSInteger )tag;

@end

@interface OxygenCircleView : UIView

@property (nonatomic, assign) id <OxygenCircleDelegate> delegate;

@end
