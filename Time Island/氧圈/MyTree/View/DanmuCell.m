//
//  DanmuCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "DanmuCell.h"

@implementation DanmuCell{
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
        
        backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
        kViewBorderRadius(backView, 25, 1, kLineColor);
        [self addSubview:backView];
        
        
        headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 40, 40)];
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
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMM dd, yyyy hh:mm:ss aa";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date01 = [formatter dateFromString:dynamicModel.createDatetime];
    formatter.dateFormat = @"HH:mm:ss";
    formatter.locale = [NSLocale currentLocale];
    timeLbl.text = [formatter stringFromDate:date01];
    
    [headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dynamicModel.userInfo[@"photo"] convertImageUrl]]] placeholderImage:kImage(@"头像")];
    
    nameLabel.text = dynamicModel.userInfo[@"nickname"];
    [nameLabel sizeToFit];
    if (nameLabel.width > SCREEN_WIDTH - 70 - 15 - headImage.xx - 50 ) {
        nameLabel.frame = CGRectMake(headImage.xx + 8, 10, SCREEN_WIDTH - 70 - 15 - headImage.xx - 50, 14);
    }else
    {
        nameLabel.frame = CGRectMake(headImage.xx + 8, 10, nameLabel.width, 14);
    }
    
    
    expressionLabel.text = dynamicModel.barrageContent;
    [expressionLabel sizeToFit];
    
    if (expressionLabel.width > SCREEN_WIDTH - 70 - 15 - headImage.xx - 50) {
        expressionLabel.frame = CGRectMake(headImage.xx + 8, 24, SCREEN_WIDTH - 70 - 15 - headImage.xx - 50, 16);
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
    
    backView.frame = CGRectMake(15, 0, expressionImage.xx + 10, 50);
    
}

@end
