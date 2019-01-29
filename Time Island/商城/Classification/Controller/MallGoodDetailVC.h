//
//  MallGoodDetailVC.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLBaseVC.h"
#import "QWCategory.h"
#import "MallTreeModel.h"
@interface MallGoodDetailVC : TLBaseVC
@property (nonatomic ,copy) NSString *code;
@property (nonatomic,strong) MallTreeModel * treeModel;

@end
