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
        kViewRadius(_headImage, 15);

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
        _informationLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, _timeLabel.yy + 20, SCREEN_WIDTH - 30, 10)];
        _informationLabel.numberOfLines = 0;
        [self addSubview:_informationLabel];
        
        _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(15, _informationLabel.yy + 5, 150, 115)];
        [_imageview setHidden:YES];
        [self addSubview:_imageview];
        
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = LineBackColor;
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
//            make.top.equalTo(self.contentView.mas_top).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(0);
            make.right.mas_equalTo(self.contentView.mas_right).offset(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
            make.height.mas_equalTo(@1);
        }];
    }
    return self;
}

-(void)setEvaModel:(EvaluationModel *)evaModel
{
    
    
    [_headImage sd_setImageWithURL:[NSURL URLWithString:[evaModel.photo convertImageUrl]] placeholderImage:kImage(@"头像")];
    _nameLabel.text = evaModel.nickname;
    _timeLabel.text = [evaModel.commentDatetime convertToDetailDate];
    
    NSRange startRange = [evaModel.content rangeOfString:@"<p>"];
    NSRange endRange = [evaModel.content rangeOfString:@"</p>"];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    NSString * con = [evaModel.content substringWithRange:range];
    
    _informationLabel.text = con;
    [_informationLabel sizeToFit];
    _informationLabel.frame = CGRectMake(15, _timeLabel.yy + 8, SCREEN_WIDTH - 30, _informationLabel.height);
    
    
    
    if ([evaModel.content containsString:@"<img"]) {
        [_imageview setHidden:NO];
        _imageview.frame = CGRectMake(15, _informationLabel.yy + 5, 150, 115);
        NSRange startRange1 = [evaModel.content rangeOfString:@"src=\""];
        NSRange endRange1;
        if ([evaModel.content containsString:@"?imageMogr2/auto-orient\" />"]) {
            endRange1 = [evaModel.content rangeOfString:@"?imageMogr2/auto-orient\" />"];
        }else
            endRange1 = [evaModel.content rangeOfString:@"?imgeMogr2/auto-orient \">"];
        
        NSRange range1 = NSMakeRange(startRange1.location + startRange1.length, endRange1.location - startRange1.location - startRange1.length);
        NSString * photo = [evaModel.content substringWithRange:range1];
        [_imageview sd_setImageWithURL:[NSURL URLWithString:photo]];
    }
    
   
    

    
}



@end
