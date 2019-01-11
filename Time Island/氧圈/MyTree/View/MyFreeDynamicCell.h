//
//  MyFreeDynamicCell.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/10.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MyFreeDynamicDelegate <NSObject>

-(void)MyFreeDynamicButton:(NSInteger )tag;

@end

@interface MyFreeDynamicCell : UITableViewCell

@property (nonatomic, assign) id <MyFreeDynamicDelegate> delegate;

@end
