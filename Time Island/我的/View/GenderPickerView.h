//
//  GenderPickerView.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/24.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^GenderBlock)( NSString *Gender);

@interface GenderPickerView : UIPickerView<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) NSArray * genderarray;
@property (nonatomic,copy) GenderBlock genderblock;
@end

NS_ASSUME_NONNULL_END
