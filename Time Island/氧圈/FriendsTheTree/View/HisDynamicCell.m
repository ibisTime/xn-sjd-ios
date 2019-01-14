//
//  HisDynamicCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "HisDynamicCell.h"

@implementation HisDynamicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(32.5, 0, 1, 15)];
        topLineView.backgroundColor = kLineColor;
        [self addSubview:topLineView];
        
        
        UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(topLineView.x - 8.5, topLineView.yy, 18, 18)];
        iconImg.image = kImage(@"收  取");
        [self addSubview:iconImg];
        
        UILabel *nameLbl = [[UILabel alloc]init];
        nameLbl.textColor = kTextBlack;
        nameLbl.font = HGboldfont(14);
        nameLbl.text = @"他的好友";
        [self addSubview:nameLbl];
        
        [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(iconImg.mas_right).offset(12);
            make.height.equalTo(@48);
        }];
        
        UILabel *numberLbl = [[UILabel alloc]init];
        numberLbl.textColor = kTextBlack;
        numberLbl.text = @"收取9g";
        numberLbl.font = FONT(14);
        [self addSubview:numberLbl];
        
        [numberLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(nameLbl.mas_right).offset(5);
            make.height.equalTo(@48);
        }];
        
        
        UILabel *timeLbl = [[UILabel alloc]init];
        timeLbl.textColor = kHexColor(@"#999999");
        timeLbl.text = @"一小时前";
        timeLbl.font = FONT(12);
        [self addSubview:timeLbl];
        
        [timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.equalTo(@48);
        }];
        
        UIView *bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(32.5, iconImg.yy, 1, 15)];
        bottomLineView.backgroundColor = kLineColor;
        self.bottomLineView = bottomLineView;
        [self addSubview:bottomLineView];
    }
    return self;
}

@end
