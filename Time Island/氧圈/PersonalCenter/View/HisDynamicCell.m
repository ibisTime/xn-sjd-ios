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
        iconImg.image = kImage(@"收  取");
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
        
//        UILabel *numberLbl = [[UILabel alloc]init];
//        numberLbl.textColor = kTextBlack;
//        numberLbl.text = @"收取9g";
//        numberLbl.font = FONT(14);
//        [self addSubview:numberLbl];
//
//        [numberLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.mas_top).offset(0);
//            make.left.equalTo(nameLbl.mas_right).offset(5);
//            make.height.equalTo(@48);
//        }];
        
        
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

-(void)setDynamicArray:(DynamicModel *)dynamicArray
{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMM dd, yyyy hh:mm:ss aa";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date01 = [formatter dateFromString:dynamicArray.createDatetime];
    formatter.dateFormat = @"HH:mm:ss";
    formatter.locale = [NSLocale currentLocale];
    timeLbl.text = [formatter stringFromDate:date01];
    
    nameLbl.text = dynamicArray.note;
    
}

@end
