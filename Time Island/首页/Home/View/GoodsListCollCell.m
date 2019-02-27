//
//  GoodsListCollCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/19.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "GoodsListCollCell.h"

@implementation GoodsListCollCell
{
    UIImageView *headImage;
    UILabel *statusLbl;
    UILabel *adoptLbl;
    UILabel *titleLab;
    UILabel *priceLabel;
    UILabel *addressLabel;
    UILabel * label;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIView *backView = [[UIView alloc]init];
        self.backView = backView;
//        backView.backgroundColor = [UIColor redColor];
        [self addSubview:backView];
        
        
        headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 30)/2, (SCREEN_WIDTH - 30)/2)];
        headImage.image = kImage(@"树 跟背景");
        kViewRadius(headImage, 6);
        [backView addSubview:headImage];
        
        
        statusLbl = [UILabel labelWithFrame:CGRectMake(0, 0, 40, 18) textAligment:(NSTextAlignmentCenter) backgroundColor:kTabbarColor font:FONT(12) textColor:kWhiteColor];
//        kViewRadius(statusLbl, 4);
//        statusLbl.text = @"集体";
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:statusLbl.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(6,6)];//圆角大小
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = statusLbl.bounds;
        maskLayer.path = maskPath.CGPath;
        statusLbl.layer.mask = maskLayer;

        [headImage addSubview:statusLbl];
        
        adoptLbl = [UILabel labelWithFrame:CGRectMake((SCREEN_WIDTH - 30)/2 - 55, (SCREEN_WIDTH - 30)/2 - 36, 55, 18) textAligment:(NSTextAlignmentCenter) backgroundColor:RGB(234, 85, 78) font:FONT(11) textColor:kWhiteColor];
//        adoptLbl.text = @"不可认养";
        UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:adoptLbl.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(4,4)];//圆角大小
        CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
        maskLayer1.frame = adoptLbl.bounds;
        maskLayer1.path = maskPath1.CGPath;
        adoptLbl.layer.mask = maskLayer1;
        [headImage addSubview:adoptLbl];
        
        
        titleLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kHexColor(@"#666666") font:13.0];
        
        
        [backView addSubview:titleLab];
        
        
        priceLabel = [UILabel labelWithFrame:CGRectMake(5, headImage.yy + 48, 0, 16) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kRedColor];
        
        
//        priceLabel.backgroundColor = [UIColor yellowColor];
        [backView addSubview:priceLabel];
        
        
        addressLabel = [UILabel labelWithFrame:CGRectMake(priceLabel.frame.size.width + 9, headImage.yy + 50, (SCREEN_WIDTH - 30)/2 - priceLabel.xx - 9, 14) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(11) textColor:RGB(153, 153, 153)];
//        addressLabel.text = @"浙江省 杭州市";
        [backView addSubview:addressLabel];
        
        
//        if ([self.model.sellType isEqualToString:@"4"]) {
            label = [UILabel labelWithTitle: [NSString stringWithFormat:@"%@/%@",self.model.nowCount,self.model.raiseCount] frame:CGRectMake(0, headImage.height - 20, headImage.width, 20)];
            label.alpha = 0.8;
            label.font = FONT(13);
            [label setTextColor:[UIColor whiteColor]];
            [label setBackgroundColor:kTabbarColor];
            [headImage addSubview:label];

//        }
        
    }
    return self;
}


-(void)setModel:(TreeModel *)model
{
    _model = model;
    titleLab.frame = CGRectMake(5, headImage.yy + 8, (SCREEN_WIDTH - 30)/2 - 10, 0);
    titleLab.text = model.name;
    titleLab.numberOfLines = 2;
    [titleLab sizeToFit];
    

    if ([model.status isEqualToString:@"0"]) {
        adoptLbl.text = @"待认养";
        adoptLbl.backgroundColor = RGB(234, 85, 78);
    }else if ([model.status isEqualToString:@"1"])
    {
        adoptLbl.text = @"已认养";
        adoptLbl.backgroundColor = RGB(234, 85, 78);
//    [headImage sd_setImageWithURL:[NSURL URLWithString:[model.listPic convertImageUrl]]];
    }
    [headImage sd_setImageWithURL:[NSURL URLWithString:[model.listPic convertImageUrl]]];
//    [self.modelarray addObject:self.model];
    NSLog(@"%@",model.name);
    NSString *str;
    if (model.productSpecsList.count > 0) {
        float money = [model.productSpecsList[0][@"price"] floatValue] / 1000.00;
//        str =  [NSString stringWithFormat:@"¥%@",model.productSpecsList[0][@"price"]];
        str =  [NSString stringWithFormat:@"¥%.2f",money];

    }else
    {
        str = @"¥0.00";
    }
//    NSString *str=  model.productSpecsList[@"price"];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSFontAttributeName value:FONT(11) range:NSMakeRange(0, 1)];
    priceLabel.attributedText = attrStr;
    [priceLabel sizeToFit];
    priceLabel.frame = CGRectMake(5, headImage.yy + 48, priceLabel.width, 16);

    
    
    addressLabel.text = [NSString stringWithFormat:@"%@ %@",model.province,model.city];

    
    label.text = [NSString stringWithFormat:@"%@/%@",self.model.nowCount,self.model.raiseCount];
    if ([model.sellType isEqualToString:@"4"]) {
        label.hidden = NO;
    }
    else{
        label.hidden = YES;
    }
    
    int selltype = [self.model.sellType intValue];
    //专属
    if (selltype == 1) {
        //根据集齐数量进行判断
        if ([self comparezCount]) {
            adoptLbl.text = @"已被认养";
            adoptLbl.backgroundColor = [UIColor grayColor];
            return;
            //根据时间判断
        }else if (![self compareDate:[self.model.raiseStartDatetime convertToSysDate] date:[self getCurrentTime]] ||![self compareDate:[self getCurrentTime] date:[self.model.raiseEndDatetime convertToSysDate]] ) {
            adoptLbl.text = @"不可认养";
            adoptLbl.backgroundColor = [UIColor grayColor];
            return;
        }
        else{
            adoptLbl.text = @"可认养";
            adoptLbl.backgroundColor = RGB(234, 85, 78);
            return;
        }
         //定向
    }else if (selltype == 2) {
        //根据数量
        if ([self comparezCount]) {
            adoptLbl.text = @"已被认养";
            adoptLbl.backgroundColor = [UIColor grayColor];
            return;
            //根据等级
        }else if ([self.model.directType isEqualToString:@"1"]) {
            if (self.model.directObject != [TLUser user].level) {
                adoptLbl.text = @"不可认养";
                adoptLbl.backgroundColor = [UIColor grayColor];
                return;
            }
            //根据用户
        }else if ([self.model.directType isEqualToString:@"2"]){
            if (self.model.directObject != [TLUser user].userId) {
                adoptLbl.text = @"不可认养";
                adoptLbl.backgroundColor = [UIColor grayColor];
                return;
            }
        }else{
            adoptLbl.text = @"可认养";
            adoptLbl.backgroundColor = RGB(234, 85, 78);
            return;
        }
        
    }else if (selltype == 3){
        if (![self compareDate:[self.model.raiseStartDatetime convertToSysDate] date:[self getCurrentTime]] ||![self compareDate:[self getCurrentTime] date:[self.model.raiseEndDatetime convertToSysDate]] ) {
            adoptLbl.text = @"不可认养";
            adoptLbl.backgroundColor = [UIColor grayColor];
            return;
        }
        else{
            adoptLbl.text = @"可认养";
            adoptLbl.backgroundColor = RGB(234, 85, 78);
            return;
        }
    }
    else if (selltype == 4){
        if ([self comparezCount]) {
            adoptLbl.text = @"已满标";
            adoptLbl.backgroundColor = [UIColor grayColor];
            return;
            //根据等级
        }
        else{
            adoptLbl.text = @"可认养";
            adoptLbl.backgroundColor = RGB(234, 85, 78);
            return;
        }
    }
    
    
}



-(void)setSellTypeArray:(NSArray *)SellTypeArray{
    _SellTypeArray = SellTypeArray;
    for (int i = 0; i < SellTypeArray.count; i++) {
        if ([_model.sellType isEqualToString:SellTypeArray[i][@"dkey"]]) {
            statusLbl.text = SellTypeArray[i][@"dvalue"];
            //            adoptLbl.backgroundColor = RGB(179, 98, 188);
        }
               
    }
    
    
}

-(BOOL)comparezCount{
    if (self.model.raiseCount == self.model.nowCount) {
        return YES;
    }
    return NO;
}


#pragma mark ===================得到当前时间=============
- (NSDate *)getCurrentTime{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    return date;
}

-(BOOL)compareDate:(NSDate *)date1 date:(NSDate *)date2
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //比较准确度为“日”，如果提高比较准确度，可以在此修改时间格式
    NSString *stringDate1 = [dateFormatter stringFromDate:date1];
    NSString *stringDate2 = [dateFormatter stringFromDate:date2];
    NSDate *dateA = [dateFormatter dateFromString:stringDate1];
    NSDate *dateB = [dateFormatter dateFromString:stringDate2];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        return NO;  //date1 比 date2 晚
    } else if (result == NSOrderedAscending){
        return YES; //date1 比 date2 早
    }
    return YES; //在当前准确度下，两个时间一致
}
@end
