//
//  RenYangListCell.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/10.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "RenYangListCell.h"
#import "AppColorMacro.h"
#import "AppMacro.h"
#import "TLUIHeader.h"
#import "NSString+Extension.h"
#import <UIImageView+WebCache.h>

@interface RenYangListCell()

@end
@implementation RenYangListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        UIImageView *image = [[UIImageView alloc] init];
        image.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:image];
        image.frame = CGRectMake(15, 15, 22, 22);
        image.layer.cornerRadius = 11;
        image.clipsToBounds = YES;
        self.iconImage = image;
        image.centerY = self.centerY;

        image.image = kImage(@"古树认养");
        UILabel *moreLab = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(0, 0, 0) font:11];
        moreLab.frame = CGRectMake(40, 5, kScreenWidth-120, 22);
        moreLab.textAlignment = NSTextAlignmentLeft;
        moreLab.text = @"新年第一棵苍天大树";
        self.moreLab = moreLab;
        [self.contentView addSubview:moreLab];
        
        UILabel *detailLab = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(153, 153, 153) font:9];
        detailLab.frame = CGRectMake(40, 20, kScreenWidth-120, 22);
        detailLab.textAlignment = NSTextAlignmentLeft;
        detailLab.text = @"2018.12.25-2019.12.25";
        self.detailLab = detailLab;
        [self.contentView addSubview:detailLab];
        
        UILabel *moneyLab = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(0, 0, 0) font:13];
        moneyLab.frame = CGRectMake(kScreenWidth-120, 5, 120, 30);
        moneyLab.centerY = self.centerY;
        moneyLab.textAlignment = NSTextAlignmentLeft;
        moneyLab.text = @"¥ 5000.00";
        self.moneyLab = moneyLab;
        [self.contentView addSubview:moneyLab];
        
        UIView *line = [UIView new];
        line.frame = CGRectMake(0, detailLab.yy, kScreenWidth, 1);
        line.backgroundColor = RGB(244, 244, 244);
        [self.contentView addSubview:line];
    }
    return self;
}

@end
