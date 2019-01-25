//
//  AddressCell.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/18.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol AddressCellDelegrate <NSObject>

-(void)ClickButton : (NSInteger)tag;

@end
@interface AddressCell : UITableViewCell
@property (nonatomic,strong) UILabel * UserName;
@property (nonatomic,strong) UILabel * UserPhone;
@property (nonatomic,strong) UILabel * UserAddress;
@property (nonatomic,strong) UIButton * checkBtn;
@property (nonatomic,strong) UIButton * editbtn;
@property (nonatomic,strong) UIButton * cancelbtn;
@property (nonatomic,strong) UILabel * label ;
@property (nonatomic,assign) id<AddressCellDelegrate> delegrate;


@end

NS_ASSUME_NONNULL_END
