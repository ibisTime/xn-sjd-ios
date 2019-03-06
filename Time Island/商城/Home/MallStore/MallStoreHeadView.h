//
//  MallStoreHeadView.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/5.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWCategory.h"
#import "MallGoodsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MallStoreHeadView : UICollectionReusableView
@property (nonatomic,strong) SLBannerView *topImage;
@property (nonatomic,strong) UIImageView * headImage;
@property (nonatomic,strong) UILabel *nameLable;
@property (nonatomic,strong) UILabel *introduceLable;
@property (nonatomic,strong) UIView * headerView;
@property (nonatomic,strong) NSMutableArray<QWCategory *> * QWCategorys;
@property (nonatomic,strong) UIButton *iconBtn;
@property (nonatomic,strong) MallGoodsModel * treeModel;
@property (nonatomic,strong) NSMutableArray * imageArraay ;
@property (nonatomic,strong) NSString * str;
@property (nonatomic,strong) void (^classifyclick)(UIButton * sender);
@end

NS_ASSUME_NONNULL_END
