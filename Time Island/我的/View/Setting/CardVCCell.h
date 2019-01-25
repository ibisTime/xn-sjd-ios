//
//  CardVCCell.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/17.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardVCCell : UITableViewCell
@property (nonatomic,strong) UIImageView * LogoImage;
@property (nonatomic,strong) UIImageView * BackgroundImage;
@property (nonatomic,strong) UILabel * CardName;
@property (nonatomic,strong) UILabel * CardType;
@property (nonatomic,strong) UILabel * CardCount;
@property (nonatomic,strong) NSString * CardNameString;
@property (nonatomic,strong) NSString * CardTypeString;
@property (nonatomic,strong) NSString * CardCountString;
//@property (nonatomic,strong) NSString * CardCountSrting;
@end

NS_ASSUME_NONNULL_END
