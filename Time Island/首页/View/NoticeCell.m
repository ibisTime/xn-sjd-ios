//
//  NoticeCell.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/14.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "NoticeCell.h"

@implementation NoticeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        

        UILabel *titleLab = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(0, 0, 0) font:14];
        titleLab.frame = CGRectMake(30, 10, kScreenWidth-120, 22);
        titleLab.textAlignment = NSTextAlignmentLeft;
        titleLab.text = @"时间岛公告";
        self.titleLab = titleLab;
        [self.contentView addSubview:titleLab];
        
        UILabel *timeLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:13];
        timeLab.frame = CGRectMake(kScreenWidth-120, 5, 120, 30);
        timeLab.textAlignment = NSTextAlignmentLeft;
        timeLab.text = @"2018.12.25 10.00";
        self.timeLab = timeLab;
        [self.contentView addSubview:timeLab];
        
        
        UILabel *detailLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:9];
        detailLab.frame = CGRectMake(30, titleLab.yy+10, kScreenWidth-120, 22);
        detailLab.textAlignment = NSTextAlignmentLeft;
        detailLab.text = @"时间岛APP全力研发中,时间岛APP全力研发中,时间岛APP全力研发中,";
        self.detailLab = detailLab;
        [self.contentView addSubview:detailLab];
        
        UIView *line = [UIView new];
        line.frame = CGRectMake(0, 69, kScreenWidth, 1);
        line.backgroundColor = RGB(244, 244, 244);
        [self.contentView addSubview:line];
    }
    return self;
}

@end
