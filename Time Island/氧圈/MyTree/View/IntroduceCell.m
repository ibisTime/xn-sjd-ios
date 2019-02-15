//
//  IntroduceCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "IntroduceCell.h"

@implementation IntroduceCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel  *lab = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 25) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kBlackColor];
        lab.text = [TLUser user].introduce;
        [self addSubview:lab];
        
        
        UIButton  *btn = [UIButton buttonWithTitle:@"去认养人主页" titleColor:kTabbarColor backgroundColor:kClearColor titleFont:16];
        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        btn.frame = CGRectMake(15, lab.yy + 5, 120, 20);
        [self addSubview:btn];
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

@end
