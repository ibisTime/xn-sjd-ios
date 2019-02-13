//
//  BuyCountCell.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/24.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface BuyCountCell : BaseTableViewCell
@property (nonatomic,assign) NSInteger count;
@property (nonatomic , strong)UIButton *minButton;

@property (nonatomic , strong)UILabel *nameLbl;

@property (nonatomic , strong)UILabel *countLbl;

@property (nonatomic , strong)UIButton *MaxButton;
@property (nonatomic,strong) void (^buycount)(NSInteger i);
@end
