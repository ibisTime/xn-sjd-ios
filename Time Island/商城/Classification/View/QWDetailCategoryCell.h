//
//  QWDetailCategoryCell.h
//  QW京东Demo
//
//  Created by mac on 16/1/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWCategory.h"


@interface QWDetailCategoryCell : UICollectionViewCell

@property (nonatomic, strong) QWCategory *category;
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *textLabel;
@end
