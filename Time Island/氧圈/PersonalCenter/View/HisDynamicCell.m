//
//  HisDynamicCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "HisDynamicCell.h"

@implementation HisDynamicCell
{
    UILabel *timeLbl;
    UIImageView *iconImg;
    UILabel *nameLbl;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(32.5, 0, 1, 15)];
        topLineView.backgroundColor = kLineColor;
        [self addSubview:topLineView];
        
        
        iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(topLineView.x - 8.5, topLineView.yy, 18, 18)];
        
        [self addSubview:iconImg];
        
        nameLbl = [[UILabel alloc]init];
        nameLbl.textColor = kTextBlack;
        nameLbl.font = HGboldfont(14);
        nameLbl.text = @"他的好友";
        [self addSubview:nameLbl];
        
        [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(iconImg.mas_right).offset(12);
            make.height.equalTo(@48);
        }];
        
        
        
        timeLbl = [[UILabel alloc]init];
        timeLbl.textColor = kHexColor(@"#999999");

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

-(void)setDynamicModel:(DynamicModel *)dynamicModel
{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMM dd, yyyy hh:mm:ss aa";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date01 = [formatter dateFromString:dynamicModel.createDatetime];
    formatter.dateFormat = @"HH:mm:ss";
    formatter.locale = [NSLocale currentLocale];
    timeLbl.text = [formatter stringFromDate:date01];
    
    if ([dynamicModel.type isEqualToString:@"3"]) {
        nameLbl.text = [NSString stringWithFormat:@"我 收取%@ %.2fg",dynamicModel.adoptUserInfo[@"nickname"],[dynamicModel.quantity floatValue]/1000];
        iconImg.image = kImage(@"收  取");
    }
    else if ([dynamicModel.type isEqualToString:@"1"]){
        if (dynamicModel.userInfo[@"nickname"]) {
            nameLbl.text = [NSString stringWithFormat:@"我 赠送%@ %.2fg",dynamicModel.adoptUserInfo[@"nickname"],[dynamicModel.quantity floatValue]/1000];
        }else{
            nameLbl.text = [dynamicModel.adoptUserInfo[@"loginName"] stringByReplacingOccurrencesOfString:[dynamicModel.adoptUserInfo[@"loginName"] substringWithRange:NSMakeRange(3,4)] withString:@" **** "];
        }
    }
    else
    {
        nameLbl.text = dynamicModel.note;
        iconImg.image = kImage(@"地址（选择）");
    }
    
    
    
    
    
}

@end
