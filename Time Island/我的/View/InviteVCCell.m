//
//  InviteVCCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "InviteVCCell.h"

@implementation InviteVCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        //昵称
        self.namelab = [[UILabel alloc]initWithFrame:CGRectMake(15, 16, SCREEN_WIDTH / 3 - 20, 14) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#FF666666")];
//        [self addSubview:self.namelab];
        [self.contentView addSubview:self.namelab];
        self.namelab.text = @"听风";
//        [self.namelab sizeToFit];
//        if (self.namelab.width > self.width - 36.5 - 6 - 5 - 10) {
//            self.namelab.frame = CGRectMake(0, 16, SCREEN_WIDTH / 3 - 20, 14);
//        }else
//        {
//            self.namelab.frame = CGRectMake(0, 16, self.namelab.width + 46, 14);
//        }
        
        
        //佣金
        self.moneylab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 1 / 3, 16.5, 0, 13) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#FF666666")];
        [self.moneylab sizeToFit];
        if (self.moneylab.width > self.width / 3 - 20) {
            self.moneylab.frame = CGRectMake(kScreenWidth * 1 / 3, 16, SCREEN_WIDTH / 3 - 20, 14);
        }
        else{
            self.moneylab.frame = CGRectMake(kScreenWidth * 1 / 3, 16, SCREEN_WIDTH / 3 - 20, 14);
        }
        self.moneylab.text = @"100.0";
//        [self addSubview:self.moneylab];
        [self.contentView addSubview:self.moneylab];
        
        
        //注册时间
        self.timelab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 2 / 3 - 10, 15, SCREEN_WIDTH / 3 - 20, 16.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#FF666666")];
        self.timelab.text = @"2018/11/1 09:53";
//        [self addSubview:self.timelab];
        [self.contentView addSubview:self.timelab];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
