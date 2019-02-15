//
//  TreeDetailCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TreeDetailCell.h"

@implementation TreeDetailCell{
    UILabel * title;
    UILabel * detail;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        title = [UILabel labelWithFrame:CGRectMake(15, 0, 100, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kBlackColor];
        
        [self addSubview:title];
        
        detail = [UILabel labelWithFrame:CGRectMake(100, 0, SCREEN_WIDTH - 30 - 100, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kBlackColor];
        
        [self addSubview:detail];
        
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setTitlearr:(NSString *)titlearr{
    title.text = titlearr;
}
-(void)setDetailstr:(NSString *)detailstr{
    detail.text = detailstr;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
