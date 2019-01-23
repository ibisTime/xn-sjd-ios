//
//  CommentCell.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "CommentCell.h"
@interface CommentCell()
@property (nonatomic ,strong) UIImageView *icon;
@end
@implementation CommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *iconIV= [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 30, 30)];
        iconIV.layer.cornerRadius =15;
        iconIV.clipsToBounds = YES;
        iconIV.image = kImage(@"分类三");
        [self addSubview:iconIV];
        UILabel *moreLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:13];
        moreLab.frame = CGRectMake(55, 15, 100, 30);
        moreLab.textAlignment = NSTextAlignmentLeft;
        moreLab.text = @"张三";
        //        moreLab.backgroundColor = [UIColor redColor];
        self.moreLab = moreLab;
        [self.contentView addSubview:moreLab];
        
        UILabel *detailLab = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(0, 0, 0) font:13];
        detailLab.frame = CGRectMake(15, iconIV.yy,kScreenWidth - 30, 35);
        detailLab.numberOfLines = 2;
        detailLab.textAlignment = NSTextAlignmentLeft;
        detailLab.text = @"老主顾了天天买买买,老主顾了天天买买买,老主顾了天天买买买,老主顾了天天买买买";
        self.detailLab = detailLab;
        [self.contentView addSubview:detailLab];
        
        
    }
    return self;
}

@end
