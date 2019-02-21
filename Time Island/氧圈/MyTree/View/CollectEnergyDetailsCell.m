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
    UILabel *numberLbl;
    UILabel *nameLbl;
    UILabel *timeLbl;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        nameLbl = [[UILabel alloc]init];
        nameLbl.textColor = kTextBlack;
        nameLbl.font = HGboldfont(14);
        nameLbl.text = @"唯一被动";
        [self addSubview:nameLbl];
        
        [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(self.mas_left).offset(15);
            make.height.equalTo(@40);
        }];
        
//        numberLbl = [[UILabel alloc]init];
//        numberLbl.textColor = kTextBlack;
//        numberLbl.text = @"收取9g";
//        numberLbl.font = FONT(14);
////        [self addSubview:numberLbl];
//
//        [numberLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.mas_top).offset(0);
//            make.left.equalTo(nameLbl.mas_right).offset(5);
//            make.height.equalTo(@40);
//        }];
        
        
        timeLbl = [[UILabel alloc]init];
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
//    numberLbl.text = [NSString stringWithFormat:@"%.2fg", [DynamicModel.quantity floatValue]/1000];
    if ([DynamicModel.type isEqualToString:@"3"]) {
        
        if (DynamicModel.userInfo[@"nickname"]) {
            nameLbl.text = [NSString stringWithFormat:@"%@ 收取 %.2fg",DynamicModel.userInfo[@"nickname"],[DynamicModel.quantity floatValue]/1000];
        }else{
            nameLbl.text = [DynamicModel.userInfo[@"loginName"] stringByReplacingOccurrencesOfString:[DynamicModel.userInfo[@"loginName"] substringWithRange:NSMakeRange(3,4)] withString:@" **** "];
        }
        
    }else if ([DynamicModel.type isEqualToString:@"1"]){
        if (DynamicModel.userInfo[@"nickname"]) {
            nameLbl.text = [NSString stringWithFormat:@"我 赠送%@ %.2fg",DynamicModel.adoptUserInfo[@"nickname"],[DynamicModel.quantity floatValue]/1000];
        }else{
            nameLbl.text = [DynamicModel.adoptUserInfo[@"loginName"] stringByReplacingOccurrencesOfString:[DynamicModel.adoptUserInfo[@"loginName"] substringWithRange:NSMakeRange(3,4)] withString:@" **** "];
        }
    }
    else
    {
        nameLbl.text = DynamicModel.note;
    }
    
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"MMM dd, yyyy hh:mm:ss aa";
//    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
//    NSDate *date01 = [formatter dateFromString:DynamicModel.createDatetime];
//    formatter.dateFormat = @"HH:mm:ss";
//    formatter.locale = [NSLocale currentLocale];
    timeLbl.text = [DynamicModel.createDatetime convertDateWithoutYear];
}

@end
