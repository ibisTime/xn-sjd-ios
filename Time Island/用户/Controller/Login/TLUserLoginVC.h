//
//  TLUserLoginVC.h
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/12.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "TLAccountBaseVC.h"

@interface TLUserLoginVC : TLAccountBaseVC


@property (nonatomic,copy) void(^loginSuccess)();

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) NSString * state;
@end
