//
//  QWDetailCategoryCell.m
//  QW京东Demo
//
//  Created by mac on 16/1/21.
//  Copyright © 2016年 mac. All rights reserved.
//  详细分类的图标

#import "QWDetailCategoryCell.h"
#import "UIImageView+WebCache.h"
#import "QWCategoryCommon.h"
#define QWCategoryCellTextSize [UIFont systemFontOfSize:12]

@interface QWDetailCategoryCell ()



@end

@implementation QWDetailCategoryCell

- (void)setCategory:(QWCategory *)category {
    
    _category = category;
    
    // 添加图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[category.pic convertImageUrl]]
                      placeholderImage:[UIImage imageNamed:@"我的礼物"]];
    
    // 添加文字
    self.textLabel.text = category.name;
}

#pragma mark - 懒加载
- (UIImageView *)imageView {
    if (_imageView == nil) {
        // 注意：这里不需要设置frame，子控件的frame都在layoutSubviews中设置
        UIImageView *tempImageView = [[UIImageView alloc] init];
        
        _imageView = tempImageView;
        
        // 注意：一定要加载到contentView上，如果加载到view上则有可能被遮住
        [self.contentView addSubview:tempImageView];
    }
    
    return _imageView;
}

- (UILabel *)textLabel {
    if (_textLabel == nil) {
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.backgroundColor = [UIColor whiteColor];
        textLabel.font = [UIFont systemFontOfSize:12];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = kBlackColor;
        _textLabel = textLabel;
        [self.contentView addSubview:textLabel];
    }
    
    return _textLabel;
}

#pragma mark - 布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 图片
    CGFloat margin = ((kScreenWidth - QWCategoryMenuWidth)-self.width*3)/6;

    _imageView.width = self.width-10;
    _imageView.height = self.width-10 ;
//    _imageView.centerX = self.width / 2;
    _imageView.centerY = _imageView.height * 0.6;
    
    
    // 文字
    _textLabel.x = 0;
    _textLabel.y = _imageView.height+10;
    _textLabel.width =self.width;
    _textLabel.height = self.height - _textLabel.y-5;
    
}

@end
