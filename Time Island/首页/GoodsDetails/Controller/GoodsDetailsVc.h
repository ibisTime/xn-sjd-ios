//
//  GoodsDetailsVc.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/21.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "TLBaseVC.h"
#import "TreeModel.h"
#import "BannerModel.h"
#import "PersonalCenterModel.h"
#import "FriendsTheTreeVC.h"
@interface GoodsDetailsVc : TLBaseVC
@property (nonatomic,strong) TreeModel * treemodel;
@property (nonatomic,strong) BannerModel * BannerModel;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic , strong)NSMutableArray <PersonalCenterModel *>*models;
@end
