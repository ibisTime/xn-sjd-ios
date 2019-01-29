//
//  RenYangFieldDeyailView.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/11.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeModel.h"
@interface RenYangFieldDeyailView : UIView
@property (nonatomic ,copy)void(^sureBlock)(void);

@property (nonatomic,strong) TreeModel * TreeModel;

@property (nonatomic,strong) NSArray * slImages;
@end
