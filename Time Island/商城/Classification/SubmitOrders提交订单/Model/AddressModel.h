//
//  AddressModel.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/9.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
//收件人
@property (nonatomic , copy)NSString *addressee;

@property (nonatomic , copy)NSString *district;

@property (nonatomic , copy)NSString *city;

@property (nonatomic , copy)NSString *code;

@property (nonatomic , copy)NSString *detailAddress;

@property (nonatomic , copy)NSString *isDefault;

@property (nonatomic , copy)NSString *mobile;

@property (nonatomic , copy)NSString *province;

@property (nonatomic , copy)NSString *userId;



@end
