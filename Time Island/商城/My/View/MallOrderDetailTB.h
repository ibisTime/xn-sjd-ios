//
//  MallOrderDetailTB.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLTableView.h"
#import "MallOrderModel.h"
@interface MallOrderDetailTB : TLTableView
@property (nonatomic,strong) MallOrderModel * model;
@property (nonatomic,strong) void (^payback)(NSString * code);
@end
