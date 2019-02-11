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




-(UILabel *)informationLabel
{
    if (!_informationLabel) {
        _informationLabel = [UILabel labelWithFrame:CGRectMake(15, _timeLabel.yy + 8, SCREEN_WIDTH - 30, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:kTextBlack];
        _informationLabel.numberOfLines = 0;
        

    }
    return _informationLabel;
}

-(UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [UILabel labelWithFrame:CGRectZero textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:kHexColor(@"#999999")];
        _numberLabel.text = @"流量46次";
    }
    return _numberLabel;
}

-(UIButton *)praiseButton
{
    if (!_praiseButton) {
        _praiseButton = [UIButton buttonWithTitle:@"评论" titleColor:kHexColor(@"#999999") backgroundColor:kClearColor titleFont:12];
        [_praiseButton SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:6 imagePositionBlock:^(UIButton *button) {
            [button setImage:[UIImage imageNamed:@"评论"] forState:(UIControlStateNormal)];
        }];
        [_praiseButton sizeToFit];

    }
    return _praiseButton;
}

-(UIButton *)commentsButton
{
    if (!_commentsButton) {
        _commentsButton = [UIButton buttonWithTitle:@"999+" titleColor:kHexColor(@"#999999") backgroundColor:kClearColor titleFont:12];
        [_commentsButton SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:6 imagePositionBlock:^(UIButton *button) {
            [button setImage:[UIImage imageNamed:@"未点赞"] forState:(UIControlStateNormal)];
        }];
        [_commentsButton sizeToFit];

    }
    return _commentsButton;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.headImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.informationLabel];
        [self addSubview:self.numberLabel];
        [self addSubview:self.commentsButton];
        [self addSubview:self.praiseButton];


    }
    return self;
}

-(void)setEvaModel:(EvaluationModel *)evaModel
{
    
    
    [_headImage sd_setImageWithURL:[NSURL URLWithString:evaModel.photo] placeholderImage:kImage(@"默认头像")];
    _nameLabel.text = evaModel.nickname;
    _timeLabel.text = [evaModel.commentDatetime convertToDetailDate];
    _informationLabel.text = @"好看又耐用";
    [_informationLabel sizeToFit];
    
    
    if (evaModel.nextCommentList.count > 0) {
        
        
        
        
        

        for (int i = 0 ; i < 5; i ++) {
            UIImageView *photoImage= [[UIImageView alloc]initWithFrame:CGRectMake(15 + i % 3 * ((SCREEN_WIDTH - 42)/3 + 6), _informationLabel.frame.origin.y + _informationLabel.frame.size.height + 12 + i/3*((SCREEN_WIDTH - 42)/3 + 6), (SCREEN_WIDTH - 42)/3, (SCREEN_WIDTH - 42)/3)];
            photoImage.image = HGImage(@"1");
            [self addSubview:photoImage];
            
            if ( i == 4) {
                _photoImage = photoImage;
            }
        }
        
        
        _numberLabel.frame = CGRectMake(15, _photoImage.yy + 6, 100, 34);
        _praiseButton.frame = CGRectMake(SCREEN_WIDTH - 15 - _commentsButton.width - 20 - _praiseButton.frame.size.width, _photoImage.yy + 6, _praiseButton.width , 34);
        _commentsButton.frame = CGRectMake(SCREEN_WIDTH - 15 - _commentsButton.width, _photoImage.frame.origin.y + _photoImage.frame.size.height + 6, _commentsButton.width, 34);
        
        
        
    }else
    {
        _numberLabel.frame = CGRectMake(15, _informationLabel.yy + 6, 100, 34);
        _praiseButton.frame = CGRectMake(SCREEN_WIDTH - 15 - _commentsButton.frame.size.width - 20 - _praiseButton.frame.size.width, _informationLabel.yy+ 6, _praiseButton.width , 34);
        
        _commentsButton.frame = CGRectMake(SCREEN_WIDTH - 15 - _commentsButton.width, _informationLabel.yy + 6, _commentsButton.frame.size.width, 34);
    }
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _commentsButton.frame.origin.y + 39.5, SCREEN_WIDTH, 0.5)];
    _lineView.backgroundColor = LineBackColor;
    [self addSubview:_lineView];
}



@end
