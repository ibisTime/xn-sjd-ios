//
//  CertifyVCCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/23.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "CertifyVCCell.h"

@implementation CertifyVCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel * label1 = [UILabel labelWithFrame:CGRectMake(15, 0, 75, 55) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(15) textColor:kBlackColor];
        [self addSubview:label1];
        self.title = label1;
        
        UILabel * label2 = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 100, 0, 75, 55) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(15) textColor:kBlackColor];
        [self addSubview:label2];
        self.state = label2;
        
        UIImageView  *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 6, 55/2 - 6, 6, 12)];
        img2.image = [UIImage imageNamed:@"跳转"];
        [self.contentView addSubview:img2];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 54, SCREEN_WIDTH - 30, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
    }
    return self;
}
@end
