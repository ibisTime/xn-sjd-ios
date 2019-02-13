//
//  TransportCell.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/24.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface TransportCell : BaseTableViewCell
@property (nonatomic , strong)UILabel *nameLbl;
@property (nonatomic , strong)UILabel *countLbl;
@property (nonatomic , strong)UIImageView *youImage;

@property (nonatomic,strong) NSString * addressCode;
@property (nonatomic,strong) NSString * commodityCodeList;


@end
