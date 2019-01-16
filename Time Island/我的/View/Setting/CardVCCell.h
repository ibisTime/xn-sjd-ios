//
//  CardVCCell.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardVCCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView * image;
-(instancetype)initWithFrame:(CGRect)frame
                imagestring : (NSString * )imagestring
                 logostring : (NSString * )logostring
                   cardname : (NSString * )cardname
                    cardnum : (NSString * )cardnum;
@end

NS_ASSUME_NONNULL_END
