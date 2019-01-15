//
//  TreeFiledCell.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/10.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TreeFiledCell.h"
#import "AppColorMacro.h"
#import "AppMacro.h"
#import "TLUIHeader.h"
#import "NSString+Extension.h"
#import <UIImageView+WebCache.h>

@interface TreeFiledCell()


@end
@implementation TreeFiledCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        UILabel *moreLab = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(0, 0, 0) font:13];
        moreLab.frame = CGRectMake(15, 5, 120, 30);
        moreLab.textAlignment = NSTextAlignmentLeft;
        moreLab.text = @"[树木名称]";
        self.moreLab = moreLab;
        [self.contentView addSubview:moreLab];
        
        UILabel *detailLab = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(0, 0, 0) font:14];
        detailLab.frame = CGRectMake(120+30, 5, kScreenWidth-120-60, 30);
        detailLab.textAlignment = NSTextAlignmentLeft;
        detailLab.text = @"习总书记栽种的下姜村一级樟树";
        self.detailLab = detailLab;
        [self.contentView addSubview:detailLab];
        UIView *line = [UIView new];
        line.frame = CGRectMake(0, self.frame.size.height-1, kScreenWidth, 1);
        line.backgroundColor = RGB(244, 244, 244);
        [self.contentView addSubview:line];
    }
    return self;
}


@end
