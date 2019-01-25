//
//  introduceView.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface introduceView : TLBaseVC
//@property (nonatomic,strong) UITextView * detail;
@property (nonatomic,strong) UIWebView * detail;
@property (nonatomic,strong) NSString * web;
@property (nonatomic,strong) UIScrollView * scrollview;
@property (nonatomic,strong) NSString * IntroduceTitle;
@property (nonatomic,strong) NSString * time;
@end

NS_ASSUME_NONNULL_END
