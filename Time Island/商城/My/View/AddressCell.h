//
//  AddressCell.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/18.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressCell : UITableViewCell
@property (nonatomic,strong) UILabel * UserName;
@property (nonatomic,strong) UILabel * UserPhone;
@property (nonatomic,strong) UILabel * UserAddress;
@property (nonatomic,strong) UIButton * checkBtn;

@end

NS_ASSUME_NONNULL_END
