//
//  JVShopcartCountView.m
//  JVShopcart
//
//  Created by AVGD-Jarvi on 17/3/23.
//  Copyright © 2017年 AVGD-Jarvi. All rights reserved.
//

#import "JVShopcartCountView.h"
#import "Masonry.h"

@interface JVShopcartCountView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *increaseButton;
@property (nonatomic, strong) UIButton *decreaseButton;
@property (nonatomic, strong) UITextField *editTextField;

@end

@implementation JVShopcartCountView

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self addSubview:self.increaseButton];
    [self addSubview:self.decreaseButton];
    [self addSubview:self.editTextField];
}

- (void)configureShopcartCountViewWithProductCount:(NSInteger)productCount productStock:(NSInteger)productStock {
    if (productCount == 1) {
        self.decreaseButton.enabled = NO;
        self.increaseButton.enabled = YES;
    } else if (productCount == productStock) {
        self.decreaseButton.enabled = YES;
        self.increaseButton.enabled = NO;
    } else {
        self.decreaseButton.enabled = YES;
        self.increaseButton.enabled = YES;
    }
    
    self.editTextField.text = [NSString stringWithFormat:@"%ld", productCount];
}

- (void)decreaseButtonAction {
    NSInteger count = self.editTextField.text.integerValue;
    if (self.shopcartCountViewEditBlock) {
        self.shopcartCountViewEditBlock(-- count);
    }
}

- (void)increaseButtonAction {
    NSInteger count = self.editTextField.text.integerValue;
    if (self.shopcartCountViewEditBlock) {
        self.shopcartCountViewEditBlock(++ count);
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.shopcartCountViewEditBlock) {
        self.shopcartCountViewEditBlock(self.editTextField.text.integerValue);
    }
}

- (UITextField *)editTextField {
    if(_editTextField == nil) {
        _editTextField = [[UITextField alloc] init];
        _editTextField.textAlignment=NSTextAlignmentCenter;
        _editTextField.keyboardType=UIKeyboardTypeNumberPad;
      
        _editTextField.delegate = self;
        _editTextField.font=[UIFont systemFontOfSize:13];
        _editTextField.backgroundColor = [UIColor whiteColor];
    }
    return _editTextField;
}

- (UIButton *)decreaseButton {
    if(_decreaseButton == nil) {
        _decreaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_decreaseButton setBackgroundImage:[UIImage imageNamed:@"减"] forState:UIControlStateNormal];
        [_decreaseButton setBackgroundImage:[UIImage imageNamed:@"减"] forState:UIControlStateDisabled];
        [_decreaseButton addTarget:self action:@selector(decreaseButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _decreaseButton;
}

- (UIButton *)increaseButton
{
    if(_increaseButton == nil)
    {
        _increaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_increaseButton setBackgroundImage:[UIImage imageNamed:@"加"] forState:UIControlStateNormal];
        [_increaseButton setBackgroundImage:[UIImage imageNamed:@"加"] forState:UIControlStateDisabled];
        [_increaseButton addTarget:self action:@selector(increaseButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _increaseButton;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.decreaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(self.mas_height);
    }];
    
    [self.increaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.equalTo(self.mas_height);
    }];
    
    [self.editTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.decreaseButton.mas_right);
        make.right.equalTo(self.increaseButton.mas_left);
    }];
}

@end
