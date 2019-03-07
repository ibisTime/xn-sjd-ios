//
//  NewsVCCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/21.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "NewsVCCell.h"

@implementation NewsVCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    [super layoutSubviews];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.NewsTitle = [UILabel labelWithFrame:CGRectMake(15, 16.5, SCREEN_WIDTH - 15 - 72, 21) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(15) textColor:kHexColor(@"#333333")];
        [self.contentView addSubview:self.NewsTitle];
        
        self.NewsDetails = [UILabel labelWithFrame:CGRectMake(15, self.NewsTitle.yy + 10, SCREEN_WIDTH - 30, 16.5) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
        [self.contentView addSubview:self.NewsDetails];
        
        self.NewsTime = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 72, 19, 56, 16.5) textAligment:NSTextAlignmentRight backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
        [self.contentView addSubview:self.NewsTime];
        
        [self.contentView addSubview:[self createview:CGRectMake(15, self.NewsDetails.yy + 15, SCREEN_WIDTH - 30, 1)]];
        
    }
    return self;
}
-(UIView * )createview:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kLineColor;
    return view;
}
-(void)setModel:(MesModel *)model{
    self.NewsTitle.text = [TLUser user].nickname;
    self.NewsDetails.text = model.messageList[model.messageList.count - 1][@"content"];
    self.NewsTime.text = [model.createDatetime convertToDetailDate];
    [self.NewsTime sizeToFit];
    self.NewsTime.frame = CGRectMake(SCREEN_WIDTH - self.NewsTime.width - 15, 19, self.NewsTime.width, 16.5);
}
@end
