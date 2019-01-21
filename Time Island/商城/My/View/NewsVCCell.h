//
//  NewsVCCell.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/21.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsVCCell : UITableViewCell
@property (nonatomic,strong) UILabel * NewsTitle;
@property (nonatomic,strong) UILabel * NewsDetails;
@property (nonatomic,strong) UILabel * NewsTime;
@end

NS_ASSUME_NONNULL_END
