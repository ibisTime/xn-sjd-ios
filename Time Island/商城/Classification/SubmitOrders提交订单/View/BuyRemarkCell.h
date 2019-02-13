//
//  BuyRemarkCell.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/24.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "TLTextView.h"
@interface BuyRemarkCell : BaseTableViewCell<UITextFieldDelegate>
@property (nonatomic , strong)TLTextField *filed;
@property (nonatomic,strong) void (^remark)(NSString * remark);

@end
