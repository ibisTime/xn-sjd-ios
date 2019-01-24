//
//  SubmitOrdersVC.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLBaseVC.h"
#import "MallOrderModel.h"
@interface SubmitOrdersVC : TLBaseVC

@property (nonatomic,strong)MallOrderModel *model;

@property (nonatomic , strong)NSArray *selectArray;

@end
