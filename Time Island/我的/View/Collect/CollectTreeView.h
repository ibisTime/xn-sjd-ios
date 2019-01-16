//
//  CollectTreeView.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BaseCollectionView.h"
#import "CollectTreeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CollectTreeView : BaseCollectionView
@property (nonatomic,strong) NSMutableArray <CollectTreeModel *>*models;

-(instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:(UICollectionViewLayout *)layout
                    withImage:(NSArray *)image;
@end

NS_ASSUME_NONNULL_END
