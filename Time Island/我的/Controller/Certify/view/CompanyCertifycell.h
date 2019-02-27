//
//  CompanyCertifycell.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompanyCertifycell : UITableViewCell <UITextFieldDelegate>
@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSString * placeholder;
@property (nonatomic,strong) NSString * keyStr;
@property (nonatomic,strong) TLTextField * textfield;
@property (nonatomic,strong) void (^Text)(NSString * text,NSString * key);
@end

NS_ASSUME_NONNULL_END
