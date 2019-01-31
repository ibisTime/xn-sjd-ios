//
//  BookCell.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BookModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BookCell : BaseTableViewCell
@property (nonatomic ,strong) UILabel *moreLab;

@property (nonatomic ,strong) UIImageView *iconImage;

@property (nonatomic ,strong) UILabel *detailLab;

@property (nonatomic ,strong) UILabel *moneyLab;

@property (nonatomic ,strong) UILabel *timeLab;

@property (nonatomic ,strong) UILabel *collectLab;

@property (nonatomic ,strong) UILabel *praiseLab;

@property (nonatomic,strong) BookModel * BookModel;

@end

NS_ASSUME_NONNULL_END
