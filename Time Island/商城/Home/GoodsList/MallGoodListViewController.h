//
//  MallGoodListViewController.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/21.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLBaseVC.h"

@interface MallGoodListViewController : TLBaseVC
@property (nonatomic,strong) NSString * parentCategoryCode;
@property (nonatomic,strong) NSString * categoryCode;
@property (nonatomic,strong) NSString * state;
@property (nonatomic,strong) NSString * SearchContent;
@property (nonatomic, assign) BOOL isMultiSelection;           /*singer和combination类型是否支持多选*/
@end
