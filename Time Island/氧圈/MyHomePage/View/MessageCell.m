//
//  MessageCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/12.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel * label1 = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH / 2 - 15, 55) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kBlackColor];
        [self addSubview:label1];
        self.title = label1;
        
        UILabel * time1 = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2 - 15, 55) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(16) textColor:kBlackColor];
        [self addSubview:time1];
        self.time = time1;
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(15, 54, SCREEN_WIDTH - 30, 1)];
        view.backgroundColor = kLineColor;
        [self addSubview:view];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setMessageModel:(MessageModel *)MessageModel{
    self.title.text = MessageModel.title;
    self.time.text = [MessageModel.createDatetime convertToDetailDate];
}
@end
