//
//  OrderCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/27.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell{
    UILabel * label;
    UILabel * label1 ;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        label = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH/3 - 15, 55) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kTextBlack];
        [self addSubview:label];
        
        label1 = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH/3 - 15, 0, SCREEN_WIDTH * 2/3 - 15, 55) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(16) textColor:kTextBlack];
        [self addSubview:label1];
    }
    return self;
}
-(void)setTitle:(NSString *)title{
    _title = title;
}
-(void)setContent:(NSString *)content{
    label.text = self.title;
    label1.text = content;
}
@end
