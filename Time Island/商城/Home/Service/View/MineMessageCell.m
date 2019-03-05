//
//  MineMessageCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/5.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MineMessageCell.h"

@implementation MineMessageCell

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
        self.content = [UILabel labelWithFrame:CGRectMake(80, 0, SCREEN_WIDTH - 80 - 20, 70) textAligment:(NSTextAlignmentCenter) backgroundColor:RGB(41, 41, 43) font:FONT(14) textColor:RGB(241, 225, 153)];
        self.content.numberOfLines = 0;
        [self addSubview:self.content];
        
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 70, 15, 50, 50)];
        kViewRadius(img, 25);
        [img sd_setImageWithURL:[NSURL URLWithString:[[TLUser user].photo convertImageUrl]] placeholderImage:kImage(@"头像")];
        [self addSubview:img];
    }
    return self;
}
@end
