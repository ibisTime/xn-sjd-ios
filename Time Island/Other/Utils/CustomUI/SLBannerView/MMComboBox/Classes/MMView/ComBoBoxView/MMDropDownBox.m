//
//  MMDropDownBox.m
//  MMComboBoxDemo
//
//  Created by wyy on 2016/12/7.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import "MMDropDownBox.h"
#import "MMComboBoxHeader.h"
@interface MMDropDownBox ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, strong) CAGradientLayer *line;
@end

@implementation MMDropDownBox
- (id)initWithFrame:(CGRect)frame titleName:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        self.title = title;
        self.isSelected = NO;
        self.userInteractionEnabled = YES;
        
        //add recognizer
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTapAction:)];
//        [self addGestureRecognizer:tap];
        
        //add subView
        UIButton *screeningBtn = [UIButton buttonWithTitle:title titleColor:kTextColor backgroundColor:kClearColor titleFont:12];
        screeningBtn.frame = CGRectMake(0, 0, 100, 40);
        [screeningBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:5 imagePositionBlock:^(UIButton *button) {
            [screeningBtn setImage:kImage(@"下拉") forState:(UIControlStateNormal)];
        }];
        [screeningBtn addTarget:self action:@selector(respondToTapAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self addSubview:screeningBtn];
        
//        UIColor *dark = [UIColor colorWithWhite:0 alpha:0.2];
//        UIColor *clear = [UIColor colorWithWhite:0 alpha:0];
//        NSArray *colors = @[(id)clear.CGColor,(id)dark.CGColor, (id)clear.CGColor];
//        NSArray *locations = @[@0.2, @0.5, @0.8];
//        self.line = [CAGradientLayer layer];
//        self.line.colors = colors;
//        self.line.locations = locations;
//        self.line.startPoint = CGPointMake(0, 0);
//        self.line.endPoint = CGPointMake(0, 1);
//        self.line.frame = CGRectMake(self.arrow.right + ArrowToRight - 1.0/scale , 0, 1.0/scale, self.height);
//        [self.layer addSublayer:self.line];
    }
    return self;

}

- (void)updateTitleState:(BOOL)isSelected {
    if (isSelected) {
        self.titleLabel.textColor = [UIColor colorWithHexString:titleSelectedColor];
        self.arrow.image = [UIImage imageNamed:@"pulldown"];
    } else{
        self.titleLabel.textColor = [UIColor blackColor];
        self.arrow.image = [UIImage imageNamed:@"pulldown"];
    }
}

- (void)updateTitleContent:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)respondToTapAction:(UIButton *)gesture {
    if ([self.delegate respondsToSelector:@selector(didTapDropDownBox:atIndex:)]) {
        [self.delegate didTapDropDownBox:self atIndex:self.tag];
    }
}
@end
