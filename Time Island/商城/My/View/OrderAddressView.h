//
//  OrderAddressView.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BaseView.h"
#import "AddressModel.h"

@interface OrderAddressView : BaseView
@property (nonatomic , strong)AddressModel *model;

@property (nonatomic , strong)UILabel *backLabel;

@property (nonatomic , strong)UIImageView *addressImg;

@property (nonatomic , strong)UILabel *nameLbl;

@property (nonatomic , strong)UILabel *addressLbl;

@property (nonatomic , strong)UILabel *phoneLbl;
- (void)setModel:(AddressModel *)model;
@end
