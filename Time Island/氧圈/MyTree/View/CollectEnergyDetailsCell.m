//
//  CollectEnergyDetailsCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/10.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "CollectEnergyDetailsCell.h"

@implementation CollectEnergyDetailsCell
{
    UILabel *numberLb;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *nameLbl = [[UILabel alloc]init];
        nameLbl.textColor = kTextBlack;
        nameLbl.font = HGboldfont(14);
        nameLbl.text = @"唯一被动";
        [self addSubview:nameLbl];
        
        [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(self.mas_left).offset(15);
            make.height.equalTo(@40);
        }];
        
        UILabel *numberLbl = [[UILabel alloc]init];
        numberLbl.textColor = kTextBlack;
        numberLbl.text = @"收取9g";
        numberLbl.font = FONT(14);
        [self addSubview:numberLbl];

        [numberLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(nameLbl.mas_right).offset(5);
            make.height.equalTo(@40);
        }];
        
        
        UILabel *timeLbl = [[UILabel alloc]init];
        timeLbl.textColor = kHexColor(@"#999999");
        timeLbl.text = @"一小时前";
        timeLbl.font = FONT(12);
        [self addSubview:timeLbl];

        [timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.equalTo(@40);
        }];
        
    }
    return self;
}

-(void)setDynamicModel:(DynamicModel *)DynamicModel{
    
}

@end
