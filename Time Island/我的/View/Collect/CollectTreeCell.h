//
//  CollectTreeCell.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectTreeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CollectTreeCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *contentLab;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UILabel *nameprice;

@property (nonatomic, strong) UIImageView *contentImage;

@property (nonatomic, strong) UIImageView *companyImage;

@property (nonatomic, strong) UIButton *owerButton;

@property (nonatomic, strong) UIButton *statusButton;

@property (nonatomic ,strong) CollectTreeModel *model;
@end

NS_ASSUME_NONNULL_END
