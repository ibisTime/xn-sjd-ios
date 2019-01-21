//
//  GoodsDetailsHeadView.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/21.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodsDetailsHeadDelegate <NSObject>

-(void)GoodsDetailsHeadButton:(NSInteger )tag;

@end

@interface GoodsDetailsHeadView : UITableViewHeaderFooterView

@property (nonatomic ,strong)UIView *lineView;

@property (nonatomic, assign) id <GoodsDetailsHeadDelegate> delegate;
@end
