

#import <UIKit/UIKit.h>

static CGFloat const FloatingBallHeaderHeight = 430;

@class FloatingBallHeader;
@protocol FloatingBallHeaderDelegate <NSObject>

- (void)floatingBallHeader:(FloatingBallHeader *)floatingBallHeader didPappaoAtIndex:(NSInteger)index isLastOne:(BOOL)isLastOne;

@end

@interface FloatingBallHeader : UIView

@property (nonatomic, weak) id<FloatingBallHeaderDelegate> delegate;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) NSArray *numberList;

@property (nonatomic, strong) NSString *state;

// 重置动画，因为页面disappear会将layer动画移除
- (void)resetAnimation;
// 移除所有泡泡
- (void)removeAllPaopao;

@end
