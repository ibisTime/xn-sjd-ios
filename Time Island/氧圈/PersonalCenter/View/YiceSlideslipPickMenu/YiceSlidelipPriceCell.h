//
//  YiceSlidelipPriceCell.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/11.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol PriceDelegate <NSObject>

-(void)returnMinPrice:(NSString *)min MaxPrice:(NSString *)max;

@end
@interface YiceSlidelipPriceCell : UICollectionViewCell<UITextFieldDelegate>
@property (nonatomic,weak) id<PriceDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
