//
//  ExpressCell.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface ExpressCell : BaseTableViewCell
@property (nonatomic,strong) UILabel * statusLab;
@property (nonatomic,strong) UILabel * timeLab;
@property (nonatomic,assign) BOOL isTop;
@property (nonatomic,assign) BOOL iscenterView;

@property (nonatomic,assign) BOOL isBottom;
@property (nonatomic,strong) UIView *pointView;
@end
