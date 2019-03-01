//
//  TeamPostCell.m
//  LHDS
//
//  Created by QinBao Zheng on 2018/8/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TeamPostCell.h"

@implementation TeamPostCell

-(UIImageView *)headImage
{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        

    }
    return _headImage;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(52, 15,  SCREEN_WIDTH - 52 -15 - 100, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:kHexColor(@"#999999")];
        
    }
    return _nameLabel;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 165, 15, 150, 30) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(12) textColor:kHexColor(@"#999999")];
        
    }
    return _timeLabel;
}




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.headImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.timeLabel];
        _informationLabel = [[UIWebView alloc]initWithFrame:CGRectMake(15, _timeLabel.yy + 8, SCREEN_WIDTH - 30, 10)];
        [self addSubview:_informationLabel];


    }
    return self;
}

-(void)setEvaModel:(EvaluationModel *)evaModel
{
    
    
    [_headImage sd_setImageWithURL:[NSURL URLWithString:evaModel.photo] placeholderImage:kImage(@"头像")];
    _nameLabel.text = evaModel.nickname;
    _timeLabel.text = [evaModel.commentDatetime convertToDetailDate];
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _informationLabel.frame.origin.y + 39.5, SCREEN_WIDTH, 0.5)];
    _lineView.backgroundColor = LineBackColor;
    [self addSubview:_lineView];
}



@end
