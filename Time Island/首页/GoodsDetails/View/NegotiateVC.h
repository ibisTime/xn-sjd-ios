//
//  NegotiateVC.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/30.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLBaseVC.h"
#import "TreeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface NegotiateVC : TLBaseVC
@property (nonatomic,strong) UIWebView * web;
@property (nonatomic,strong) TreeModel * TreeModel;
@property (nonatomic,assign) int count;
@property (nonatomic,assign) int TreeSize;

@end

NS_ASSUME_NONNULL_END
