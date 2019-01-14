//
//  HomeHeaderView.h
//  OGC
//
//  Created by 蔡卓越 on 2018/3/13.
//  Copyright © 2018年  tianlei. All rights reserved.
//

#import <UIKit/UIKit.h>
//M
#import "BannerModel.h"
#import "HomeFindModel.h"
#import "HW3DBannerView.h"

typedef NS_ENUM(NSInteger, HomeEventsType) {
    
    HomeEventsTypeBanner = 0,   //Banner图
    HomeEventsTypeStatistics = 1,   
    HomeEventsTypeStore = 2
};

typedef void(^HomeHeaderEventsBlock)(HomeEventsType type, NSInteger index, HomeFindModel*find);

@interface HomeHeaderView : UIScrollView

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
