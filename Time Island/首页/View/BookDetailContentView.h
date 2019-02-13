//
//  BookDetailContentView.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/28.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BaseView.h"
#import "BookModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BookDetailContentView : BaseView
@property (nonatomic,strong) UILabel * content;
@property (nonatomic,strong) UIImageView * photo;
@property (nonatomic,strong) BookModel * BookModel;
@property (nonatomic,strong) NSString * state;
@end

NS_ASSUME_NONNULL_END
