//
//  ExpressCell.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "ExpressCell.h"

@implementation ExpressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.statusLab = [UILabel labelWithFrame:CGRectMake(39, 20, kScreenWidth-78, kHeight(40)) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(14) textColor:kTextColor];
        [self addSubview:self.statusLab];
        self.statusLab.numberOfLines = 0;
        
        self.timeLab = [UILabel labelWithFrame:CGRectMake(39, self.statusLab.yy+10, kScreenWidth-78, kHeight(40)) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(14) textColor:kTextColor2];
        [self addSubview:self.timeLab];
        [self drawCustomLine];
        }
    return self;

}
- (void)drawCustomLine
{
    UIView *pointView = [UIView new];
    [self addSubview:pointView];
    self.pointView = pointView;
    if (self.isTop == YES) {
        pointView.layer.cornerRadius = 4;
        pointView.clipsToBounds = YES;
        pointView.backgroundColor = kSJDMainTextColor;
        [pointView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.statusLab.mas_top).offset(16);
            make.right.equalTo(self.statusLab.mas_left).offset(-13);
            make.width.height.equalTo(@8);
        }];
    }else{
        pointView.layer.cornerRadius = 4;
        pointView.clipsToBounds = YES;
        pointView.backgroundColor = kHexColor(@"#CCCCCC");
        [pointView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.statusLab.mas_top).offset(16);
            make.right.equalTo(self.statusLab.mas_left).offset(-13);
            make.width.height.equalTo(@8);
        }];
    }
    
}

-(void)setIsTop:(BOOL)isTop
{
    _isTop = isTop;
    if (isTop == YES) {
        self.pointView.layer.cornerRadius = 4;
        self.pointView.clipsToBounds = YES;
        self.pointView.backgroundColor = kSJDMainTextColor;
        [self.pointView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.statusLab.mas_top).offset(16);
            make.right.equalTo(self.statusLab.mas_left).offset(-13);
            make.width.height.equalTo(@8);
        }];
        UIView *lineView = [UIView new];
        lineView.backgroundColor = kHexColor(@"#E6E6E6");
        [self addSubview:lineView];
        [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.pointView.mas_top).offset(4);
            make.right.equalTo(self.statusLab.mas_left).offset(-13-4);
            make.width.equalTo(@1);
            make.height.equalTo(@(130));
        }];
        [self bringSubviewToFront:self.pointView];
    }else{
       
    }
}

-(void)setIsBottom:(BOOL)isBottom
{
    _isBottom = isBottom;
    self.pointView.layer.cornerRadius = 4;
    self.pointView.clipsToBounds = YES;
    self.pointView.backgroundColor = kHexColor(@"#CCCCCC");
    [self.pointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statusLab.mas_top).offset(17.5);
        make.right.equalTo(self.statusLab.mas_left).offset(-13);
        make.width.height.equalTo(@8);
    }];
    UIView *lineView = [UIView new];
    [self addSubview:lineView];
    lineView.backgroundColor = kHexColor(@"#E6E6E6");
    
    [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.statusLab.mas_left).offset(-13-4);
        make.width.equalTo(@1);
        make.height.equalTo(@(130/2));
    }];
    [self bringSubviewToFront:self.pointView];

}

-(void)setIscenterView:(BOOL)iscenterView
{
    _iscenterView = iscenterView;
    self.pointView.layer.cornerRadius = 4;
    self.pointView.clipsToBounds = YES;
    self.pointView.backgroundColor = kHexColor(@"#CCCCCC");
    [self.pointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statusLab.mas_top).offset(17.5);
        make.right.equalTo(self.statusLab.mas_left).offset(-13);
        make.width.height.equalTo(@8);
    }];
    UIView *lineView = [UIView new];
    [self addSubview:lineView];
    lineView.backgroundColor = kHexColor(@"#E6E6E6");
    
    [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.statusLab.mas_left).offset(-13-4);
        make.width.equalTo(@1);
        make.height.equalTo(@(130));
    }];
    [self bringSubviewToFront:self.pointView];

}
@end
