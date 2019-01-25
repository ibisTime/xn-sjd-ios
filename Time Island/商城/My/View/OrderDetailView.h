//
//  OrderDetailView.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BaseView.h"
#import "AddressModel.h"

@interface OrderDetailView : BaseView
@property (nonatomic , strong)AddressModel *model;

@property (nonatomic , strong)UIImageView *addressImg;

@property (nonatomic , strong)UILabel *backLabel;

@property (nonatomic , strong)UILabel *nameLbl;

@property (nonatomic , strong)UILabel *addressLbl;

@property (nonatomic , strong)UILabel *phoneLbl;

@property (nonatomic , strong)UILabel *backContentLabel;

@property (nonatomic , strong)UILabel *nameContentLbl;

@property (nonatomic , strong)UILabel *addressContentLbl;

@property (nonatomic , strong)UILabel *phoneContentLbl;


@property (nonatomic , strong)UILabel *payCodeLbl;

@property (nonatomic , strong)UILabel *payCodeContentLbl;

@property (nonatomic, copy) void (^clickBtnBlock)(NSInteger inter);

@end
