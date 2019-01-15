//
//  BookVideoCell.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/14.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BookVideoCell.h"

@implementation BookVideoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        UIImageView *image = [[UIImageView alloc] init];
        image.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:image];
        image.frame = CGRectMake(15, 15, 100, 85);
        image.layer.cornerRadius = 3;
        image.clipsToBounds = YES;
        self.iconImage = image;
        image.image = kImage(@"baner1");
        UILabel *moreLab = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(0, 0, 0) font:16];
        moreLab.frame = CGRectMake(image.xx+20, 15, kScreenWidth-120, 22);
        moreLab.textAlignment = NSTextAlignmentLeft;
        moreLab.text = @"我的第一次认养";
        self.moreLab = moreLab;
        [self.contentView addSubview:moreLab];
        
        UILabel *detailLab = [UILabel labelWithBackgroundColor:kLineColor textColor:kBlackColor font:13];
        detailLab.frame = CGRectMake(image.xx+20, moreLab.yy+10, 100, 24);
        detailLab.textAlignment = NSTextAlignmentLeft;
        detailLab.text = @"作者: 威震天";
        self.detailLab = detailLab;
        [self.contentView addSubview:detailLab];
        
        UILabel *moneyLab = [UILabel labelWithBackgroundColor:kLineColor textColor:kBlackColor font:13];
        moneyLab.frame = CGRectMake(detailLab.xx+10, moreLab.yy+10, 120, 24);
        moneyLab.textAlignment = NSTextAlignmentLeft;
        moneyLab.text = @"关联古树: 爱心树";
        self.moneyLab = moneyLab;
        [self.contentView addSubview:moneyLab];
        
        UILabel *timeLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:13];
        timeLab.frame = CGRectMake(image.xx+20, detailLab.yy+10, 90, 24);
        timeLab.textAlignment = NSTextAlignmentLeft;
        timeLab.text = @"2018.01.15";
        timeLab.yy = image.yy;
        self.timeLab = timeLab;
        [self.contentView addSubview:timeLab];
        
        UILabel *collectLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:11];
        collectLab.frame = CGRectMake(detailLab.xx+10, detailLab.yy+10, 60, 24);
        collectLab.textAlignment = NSTextAlignmentLeft;
        collectLab.text = @"收藏 100";
        collectLab.yy = image.yy;
        self.collectLab = collectLab;
        [self.contentView addSubview:collectLab];
        
        UILabel *praiseLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:11];
        praiseLab.frame = CGRectMake(collectLab.xx, detailLab.yy+10, 60, 24);
        praiseLab.textAlignment = NSTextAlignmentLeft;
        praiseLab.text = @"评论 100";
        praiseLab.yy = image.yy;
        self.praiseLab = praiseLab;
        [self.contentView addSubview:praiseLab];
        
        UIView *line = [UIView new];
        line.frame = CGRectMake(0, image.yy+10, kScreenWidth, 1);
        line.backgroundColor = RGB(244, 244, 244);
        [self.contentView addSubview:line];
    }
    return self;
}


@end
