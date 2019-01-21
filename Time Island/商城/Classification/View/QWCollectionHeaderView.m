//
//  QWCollectionHeaderView.m
//  QW京东Demo
//
//  Created by mac on 16/1/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "QWCollectionHeaderView.h"
#define QWCollectionHeaderFont [UIFont systemFontOfSize:13]

@interface QWCollectionHeaderView ()

@property (nonatomic, weak)UILabel *textLabel;
@property (nonatomic, weak)UIImageView *rankingImage;

@end

@implementation QWCollectionHeaderView

- (void)setHeaderTitle:(NSString *)headerTitle {
    
    _headerTitle = headerTitle;
    
    // 设置背景
    UIImage *backgroundImage = [UIImage imageNamed:@"bg_category_header"];
    self.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    // 添加文字标签
    self.textLabel.text = headerTitle;
    [_textLabel sizeToFit];
    // 添加图片
    [self addRankingImage];
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
    _rankingImage = rankingImage;
    
    [self addSubview:rankingImage];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _textLabel.x = 20;
    _textLabel.y = 5;
    
    _rankingImage.x = self.width - _rankingImage.width - 10;
    _rankingImage.y = _textLabel.y;
}

@end
