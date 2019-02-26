//
//  TreeListVC.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/9.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLBaseVC.h"

@interface TreeListVC : TLBaseVC
@property (nonatomic, assign) BOOL isMultiSelection;           /*singer和combination类型是否支持多选*/
@property (nonatomic,strong) NSString * state;
@property (nonatomic,strong) NSString * SearchContent;
@end
