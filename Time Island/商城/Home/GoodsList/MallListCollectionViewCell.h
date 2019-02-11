//
//  MallListCollectionViewCell.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MallTreeModel.h"
@interface MallListCollectionViewCell : UICollectionViewCell
@property (nonatomic , strong)UIView *backView;
@property (nonatomic , strong) MallTreeModel *model;
@property (nonatomic , strong) UIButton *shopping;
@end
