//
//  ThePropsDetailsView.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/18.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ClickConvertDelegrate <NSObject>

-(void)ClickConvertBtn:(NSMutableArray *)array;

@end

@interface ThePropsDetailsView : UIView
@property (nonatomic , strong)UIButton *ShutDownBtn;
@property (nonatomic,strong) NSMutableArray * array;
@property (nonatomic,weak) id<ClickConvertDelegrate> delegate;
@end

NS_ASSUME_NONNULL_END
