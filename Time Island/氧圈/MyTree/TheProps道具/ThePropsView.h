//
//  ThePropsView.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClickDelegate <NSObject>

-(void)ClickButton:(NSMutableArray *)array;

@end


@interface ThePropsView : UIView

@property (nonatomic , strong)UIButton *deleteBtn;

@property (nonatomic,weak) id<ClickDelegate> delegate;

@property (nonatomic , strong)UIButton *shieldingBackBtn;

@property (nonatomic,strong) NSMutableArray * array;
@end
