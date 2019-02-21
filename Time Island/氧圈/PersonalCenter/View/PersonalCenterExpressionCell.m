//
//  PersonalCenterExpressionCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/2/15.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "PersonalCenterExpressionCell.h"

@implementation PersonalCenterExpressionCell
{
    UIView *backView;
    UIImageView *headImage;
    UILabel *nameLabel;
    UILabel *expressionLabel;
    UIImageView *expressionImage;
    UILabel *timeLbl;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        backView = [[UIView alloc]initWithFrame:CGRectMake(24, 0, 100, 50)];
        kViewBorderRadius(backView, 25, 1, kLineColor);
        [self addSubview:backView];
        
        
        headImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
        kViewRadius(headImage, 20);
        headImage.image = kImage(@"头像");
        [backView addSubview:headImage];
        
        nameLabel = [UILabel labelWithFrame:CGRectMake(headImage.xx + 8, 10, 100, 14) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
        [backView addSubview:nameLabel];
        
        expressionLabel = [UILabel labelWithFrame:CGRectMake(headImage.xx + 8, 24, 100, 16) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kTextColor];
        [backView addSubview:expressionLabel];
        
        expressionImage = [[UIImageView alloc]initWithFrame:CGRectMake(expressionLabel.xx , 5, 40, 40)];
        kViewRadius(expressionImage, 20);
        [backView addSubview:expressionImage];
        
        
        timeLbl = [[UILabel alloc]init];
        timeLbl.textColor = kHexColor(@"#999999");
        
        timeLbl.font = FONT(12);
        [self addSubview:timeLbl];
        
        [timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.equalTo(@48);
        }];
        
        
        
        
    }
    return self;
}

-(void)setDynamicModel:(DynamicModel *)dynamicModel
{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"MMM dd, yyyy hh:mm:ss aa";
//    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
//    NSDate *date01 = [formatter dateFromString:dynamicModel.createDatetime];
//    formatter.dateFormat = @"HH:mm:ss";
//    formatter.locale = [NSLocale currentLocale];
    timeLbl.text = [dynamicModel.createDatetime convertDateWithoutYear];
    
    [headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dynamicModel.userInfo[@"photo"] convertImageUrl]]] placeholderImage:kImage(@"头像")];
    
    nameLabel.text = dynamicModel.userInfo[@"nickname"];
    [nameLabel sizeToFit];
    if (nameLabel.width > SCREEN_WIDTH - 70 - 15 - headImage.xx - 60) {
        nameLabel.frame = CGRectMake(headImage.xx + 8, 10, SCREEN_WIDTH - 70 - 15 - headImage.xx - 60, 14);
    }else
    {
        nameLabel.frame = CGRectMake(headImage.xx + 8, 10, nameLabel.width, 14);
    }
    
    if (dynamicModel.barrageContent) {
        expressionLabel.text = dynamicModel.barrageContent;
        [expressionLabel sizeToFit];
        
        if (expressionLabel.width > SCREEN_WIDTH - 70 - 15 - headImage.xx - 60) {
            expressionLabel.frame = CGRectMake(headImage.xx + 8, 24, SCREEN_WIDTH - 70 - 15 - headImage.xx - 60, 16);
        }
        else
        {
            expressionLabel.frame = CGRectMake(headImage.xx + 8, 24, expressionLabel.width, 16);
        }
        
        [expressionImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dynamicModel.barragePic convertImageUrl]]]];
        
        if (nameLabel.width > expressionLabel.width)
        {
            expressionImage.frame = CGRectMake(nameLabel.xx + 10 , 5, 40, 40);
        }else
        {
            expressionImage.frame = CGRectMake(expressionLabel.xx + 5, 5, 40, 40);
        }
        
        backView.frame = CGRectMake(24, 0, expressionImage.xx + 10, 50);
    }else{
        expressionLabel.text = @"来收取能量，被保护罩阻挡啦！";
        [expressionLabel sizeToFit];
        
        if (expressionLabel.width > SCREEN_WIDTH - 70 - 15 - headImage.xx - 60) {
            expressionLabel.frame = CGRectMake(headImage.xx + 8, 24, SCREEN_WIDTH - 70 - 15 - headImage.xx - 60, 16);
        }
        else
        {
            expressionLabel.frame = CGRectMake(headImage.xx + 8, 24, expressionLabel.width, 16);
            
        }
        backView.frame = CGRectMake(24, 0, expressionLabel.xx + 10, 50);
    }
    
    
    if (![self.state isEqualToString:@"inside"]) {
        UIView *bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(32.5, backView.yy, 1, 15)];
        bottomLineView.backgroundColor = kLineColor;
        self.bottomLineView = bottomLineView;
        [self addSubview:bottomLineView];
    }
    
    
    
    
}

@end
