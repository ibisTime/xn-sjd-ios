//
//  GetAddVC.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface GetAddVC : TLBaseVC<UITextFieldDelegate>
@property (nonatomic,strong) TLTextField * Name;
@property (nonatomic,strong) NSString * NameString;
@property (nonatomic,strong) TLTextField * Phone;
@property (nonatomic,strong) NSString * PhoneString;
@property (nonatomic,strong) TLTextField * Address;
@property (nonatomic,strong) NSString * AddressString;
@property (nonatomic,strong) TLTextField * DoorNum;
@property (nonatomic,strong) NSString * DoorNumString;
//@property (nonatomic,strong) AddressPickView * pickerView;
@property (nonatomic,strong) NSString * sheng;
@property (nonatomic,strong) NSString * shi;
@property (nonatomic,strong) NSString * qu;
@property (nonatomic,assign) int state;
@property (nonatomic,strong) NSString * AddressCode;


@end

NS_ASSUME_NONNULL_END
