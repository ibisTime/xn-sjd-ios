//
//  YiceSlidelipPickCell.m
//  YiceSlideslipPick
//
//  Created by 音冰冰 on 2018/5/31.
//  Copyright © 2018年 音冰冰. All rights reserved.
//

#import "YiceSlidelipPickCell.h"
#import "YiceSlidelipPickPch.h"

@implementation YiceSlidelipPickCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self viewConfigWithFrame:frame];
    }
    return self;
}

- (void)viewConfigWithFrame:(CGRect)frame
{
    self.label = [[UILabel alloc] init];
    self.label.layer.cornerRadius = yiceSlidelipPickCellUIValue()->ITEM_LABEL_CORNERRADIUS;
    self.label.layer.masksToBounds = YES;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = kPickerMenuCellUnselectedColor;
    self.label.font = [UIFont systemFontOfSize:yiceSlidelipPickCellUIValue()->ITEM_FONT];
    self.label.frame = CGRectMake(0, 0, yiceSlidelipPickCellUIValue()->ITEM_WIDTH, yiceSlidelipPickCellUIValue()->ITEM_HEIGHT);
    [self addSubview:self.label];
}

- (void)setContentString:(NSString *)contentString
{
    _contentString = [contentString copy];
    _label.text = _contentString;
}

- (void)setSelected:(BOOL)selected
{
    
    
    
    [super setSelected:selected];
    
    if (selected == YES) {
        kViewBorderRadius(_label, 4, 1, RGB(244, 168, 165));
        _label.textColor = RGB(236, 110, 104);
        _label.backgroundColor = RGB(252, 237, 236);
    }else
    {
        kViewBorderRadius(_label, 4, 1, kLineColor);
        _label.textColor = kTextColor;
        _label.backgroundColor = kWhiteColor;
    }
    
//    _label.backgroundColor = selected ? RGB(253, 234, 236) : kPickerMenuCellUnselectedColor;
//    _label.textColor = selected ? kPickerMenuSelectedTextColor : kPickerMenuUnselectedTextColor;
}

@end
