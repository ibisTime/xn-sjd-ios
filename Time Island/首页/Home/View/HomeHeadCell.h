//
//  HomeHeadCell.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/25.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerModel.h"
#import "HomeFindModel.h"
#import "HW3DBannerView.h"
#import "SGAdvertScrollView.h"

typedef NS_ENUM(NSInteger, HomeEventsType) {
    
    HomeEventsTypeBanner = 0,   //Banner图
    HomeEventsTypeStatistics = 1,
    HomeEventsTypeStore = 2
};

typedef void(^HomeHeaderEventsBlock)(HomeEventsType type, NSInteger index, HomeFindModel*find);




@interface HomeHeadCell : UICollectionViewCell<SGAdvertScrollViewDelegate>


@property (nonatomic, copy) HomeHeaderEventsBlock headerBlock;

//@property (nonatomic , strong)HW3DBannerView *scrollView;
//轮播图
@property (nonatomic, strong) NSMutableArray <BannerModel *>*banners;
//点击公告更多
@property (nonatomic, copy) void (^clickNoticeBlock)(void);
@property (nonatomic,copy) void (^tapintroduce)(void);
//点击tag标签
@property (nonatomic, copy) void (^clickTagBlock)(NSInteger index);
//点击推文更多
@property (nonatomic, copy) void (^clickBookBlock)(void);
//点击快报
@property (nonatomic, copy) void (^clicknewsBlock)(NSInteger index);

//i点击轮播图
@property (nonatomic,copy) void (^clickimage)(NSInteger index);

@property (nonatomic,copy) void  (^TreeClickBlock)(void);

@property (nonatomic , strong)UIView *backView;

@property (nonatomic, strong) UIView *noticeView;//公告
@property (nonatomic, strong) UILabel *introduceLab;
@property (nonatomic,strong) NSArray * TextLoopArray;
//@property UIImageView * imageView;
@property (nonatomic,strong) NSString * ImageString;
@property (nonatomic,strong) UIImageView * tuiwenimage;
@property (nonatomic , strong)SGAdvertScrollView *advertScrollView;
@end
