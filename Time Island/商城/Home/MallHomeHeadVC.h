//
//  MallHomeHeadVC.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/18.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerModel.h"
#import "HomeFindModel.h"
#import "HW3DBannerView.h"
NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, HomeEventsType) {
    
    HomeEventsTypeBanner = 0,   //Banner图
    HomeEventsTypeStatistics = 1,
    HomeEventsTypeStore = 2
};

typedef void(^HomeHeaderEventsBlock)(HomeEventsType type, NSInteger index, HomeFindModel*find);

@interface MallHomeHeadVC : UIScrollView

@property (nonatomic, copy) HomeHeaderEventsBlock headerBlock;

@property (nonatomic , strong)HW3DBannerView *scrollView;
//轮播图
@property (nonatomic, strong) NSMutableArray <BannerModel *>*banners;
//点击公告更多
@property (nonatomic, copy) void (^clickNoticeBlock)(void);
//点击tag标签
@property (nonatomic, copy) void (^clickTagBlock)(NSInteger index);
//点击推文更多
@property (nonatomic, copy) void (^clickBookBlock)(void);
//点击快报
@property (nonatomic, copy) void (^clicknewsBlock)(void);

@end

NS_ASSUME_NONNULL_END
