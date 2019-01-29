//
//  QWCategoryMenuController.h
//  QW京东Demo
//
//  Created by mac on 16/1/20.
//  Copyright © 2016年 mac. All rights reserved.
////  一级类别菜单的控制器
#import <UIKit/UIKit.h>
#import "QWCategoryDetailController.h"
@interface QWCategoryMenuController : UITableViewController

@property (nonatomic ,strong) QWCategoryDetailController *detailVC;
@end
