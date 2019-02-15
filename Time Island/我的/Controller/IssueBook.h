//
//  IssueBook.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/17.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLBaseVC.h"
#import "PersonalCenterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IssueBook : TLBaseVC<UITextViewDelegate,UIGestureRecognizerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic , strong)PersonalCenterModel *model;
@property (nonatomic,strong) NSString * state;
@end

NS_ASSUME_NONNULL_END
