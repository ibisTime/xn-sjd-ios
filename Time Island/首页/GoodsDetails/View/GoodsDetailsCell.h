//
//  GoodsDetailsCell.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/29.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GoodsDetailsCell : UITableViewCell<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView * detail;
@property (nonatomic,strong) TreeModel * TreeModel;
@end

NS_ASSUME_NONNULL_END
