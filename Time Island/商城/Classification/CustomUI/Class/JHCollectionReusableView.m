//
//  JHCollectionReusableView.m
//  HiiN
//
//  Created by 张健华-迈动 on 2017/3/7.
//  Copyright © 2017年 huanli. All rights reserved.
//

#import "JHCollectionReusableView.h"
#import "JHCollectionViewLayoutAttributes.h"
#define QWCollectionHeaderFont [UIFont systemFontOfSize:13]

@interface JHCollectionReusableView()
@property (nonatomic, weak)UILabel *textLabel;

@end
@implementation JHCollectionReusableView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[JHCollectionViewLayoutAttributes class]]) {
        JHCollectionViewLayoutAttributes *attr = (JHCollectionViewLayoutAttributes *)layoutAttributes;
//        self.backgroundColor = kLineColor;
        self.layer.borderWidth = 1;
        self.layer.borderColor = kLineColor.CGColor;

    }
}
- (void)setHeaderTitle:(NSString *)headerTitle {
    
    _headerTitle = headerTitle;
    [self addRankingImage];

    // 设置背景
//    UIImage *backgroundImage = [UIImage imageNamed:@"bg_category_header"];
//    self.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    // 添加文字标签
    self.textLabel.text = headerTitle;
    [_textLabel sizeToFit];
    // 添加图片
}


- (UILabel *)textLabel {
    
    if (_textLabel == nil) {
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.font = QWCollectionHeaderFont;
        //textLabel.textColor = [UIColor grayColor];
        
        [self addSubview:textLabel];
        _textLabel = textLabel;
    }
    
    return _textLabel;
}

- (void)addRankingImage {
    
    UIImageView *rankingImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [rankingImage sizeToFit];
    self.rankingImage = rankingImage;
    if (self.height<100) {
        rankingImage.hidden = YES;
        _textLabel.frame = CGRectMake(15, 0, self.width, 30);
    }else{
        [self addSubview:rankingImage];

        rankingImage.hidden = NO;
        rankingImage.frame = CGRectMake(15, 15, self.width-30, kHeight(100));
        _textLabel.frame = CGRectMake(15, rankingImage.yy+15, self.width-30, kHeight(30));

        
    }
    
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    _rankingImage.x = 15;
//    _rankingImage.y = 15;
//    _rankingImage.width = self.width-30;
//    _rankingImage.height = kHeight(100);
//    _textLabel.x = 15;
//    _textLabel.y = _rankingImage.yy+15;
//}

@end
