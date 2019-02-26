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
        
        image.frame = CGRectMake(15, 10, 30, 30);
        image.layer.cornerRadius = 15;
        self.iconImage = image;
        image.image = kImage(@"古树认养");
        [self.iconImage setHidden:YES];
        
        
        UILabel *moneyLab = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(0, 0, 0) font:13];
        moneyLab.frame = CGRectMake(0, 0, 0, 50);
        moneyLab.centerY = self.centerY;
        moneyLab.textAlignment = NSTextAlignmentRight;
        moneyLab.text = @"¥ 5000.00";
        [moneyLab sizeToFit];
        moneyLab.frame = CGRectMake(SCREEN_WIDTH - moneyLab.width - 15, 0, moneyLab.width, 50);
        self.moneyLab = moneyLab;
        [self.contentView addSubview:moneyLab];
        [self.moneyLab setHidden:YES];
        
        
        
        UILabel *moreLab = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(0, 0, 0) font:11];
        moreLab.frame = CGRectMake(image.xx + 4, 10, kScreenWidth - image.xx - 4 - 15 - moneyLab.width, 15);
        moreLab.textAlignment = NSTextAlignmentLeft;
        moreLab.text = @"新年第一棵苍天大树";
        self.moreLab = moreLab;
        [self.contentView addSubview:moreLab];
        [self.moreLab setHidden:YES];
        
        
        UILabel *detailLab = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(153, 153, 153) font:9];
        detailLab.frame = CGRectMake(image.xx + 4, 25, kScreenWidth - image.xx - 4 - 15 - moneyLab.width, 15);
        detailLab.textAlignment = NSTextAlignmentLeft;
        detailLab.text = @"2018.12.25-2019.12.25";
        self.detailLab = detailLab;
        [self.contentView addSubview:detailLab];
        [self.detailLab setHidden:YES];
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, 200)];
        UIImageView * image1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 25, 100, 50, 50)];
        image1.image = kImage(@"暂无订单");
        [view addSubview:image1];
        UILabel * label = [UILabel labelWithFrame:CGRectMake(0, image1.yy + 5, SCREEN_WIDTH, 30) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(16) textColor:kTextColor3];
        label.text = @"抱歉，暂无认养";
        [view addSubview:label];
        [self.contentView addSubview:view];
        self.view = view;
        [self.view setHidden:NO];
        
        
    }
    return self;
}
-(void)setRenYangModel:(RenYangUserModel *)RenYangModel{
    
    NSLog(@"%@",RenYangModel.user);
    [self.view setHidden:YES];
    [self.moneyLab setHidden:NO];
    [self.moreLab setHidden:NO];
    [self.detailLab setHidden:NO];
    [self.iconImage setHidden:NO];
    self.moreLab.text = RenYangModel.user[@"nickname"];
    self.detailLab.text = [RenYangModel.startDatetime convertToDetailDate];
    float money = [RenYangModel.amount floatValue] / 1000.00;
    self.moneyLab.text = [NSString stringWithFormat:@"¥ %.2f",money];
    if (RenYangModel.user[@"photo"]) {
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[RenYangModel.user[@"photo"] convertImageUrl]]];
    }
    
    UIView *line = [UIView new];
    line.frame = CGRectMake(0, 49, kScreenWidth, 1);
    line.backgroundColor = RGB(244, 244, 244);
    [self.contentView addSubview:line];
}
@end
