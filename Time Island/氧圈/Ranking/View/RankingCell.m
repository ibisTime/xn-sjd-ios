//
//  RankingCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "RankingCell.h"

@implementation RankingCell{
    UIImageView *headImg;
    UILabel *nameLab;
    UILabel *cerNumberLbl;
    UILabel *kgLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _numberImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 20, 20, 25)];
        [self addSubview:_numberImg];
        
        _numberLbl = [UILabel labelWithFrame:CGRectMake(5, 20, 40, 25) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(14) textColor:kTextBlack];
        [self addSubview:_numberLbl];
        
        
        headImg = [[UIImageView alloc]initWithFrame:CGRectMake(95/2, 12.5, 40, 40)];
        headImg.layer.cornerRadius = 20;
        headImg.layer.masksToBounds = YES;
        headImg.image = kImage(@"头像");
        [self addSubview:headImg];
        
    
        nameLab = [UILabel labelWithFrame:CGRectMake(headImg.xx + 10, 14, SCREEN_WIDTH - headImg.xx - 10 - 70, 17) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kTextBlack];
        [self addSubview:nameLab];
        
        cerNumberLbl = [UILabel labelWithFrame:CGRectMake(headImg.xx + 10, nameLab.yy + 7 - 1.5, SCREEN_WIDTH - headImg.xx - 10 - 70, 13) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#999999")];
        cerNumberLbl.text = @"获得了7个环保证书";
        [self addSubview:cerNumberLbl];
        
        kgLabel = [UILabel labelWithFrame:CGRectMake(nameLab.xx + 5 , 0, SCREEN_WIDTH - nameLab.xx - 5 - 15, 65) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(14) textColor:kTextBlack];
        kgLabel.text = @"14.6kg";
        [self addSubview:kgLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 64, SCREEN_WIDTH - 30, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
    }
    return self;
}
-(void)setRankModel:(RankModel *)RankModel{
    _RankModel = RankModel;
    if (RankModel.photo) {
        [headImg sd_setImageWithURL: [NSURL URLWithString:[RankModel.photo convertImageUrl]]];
    }
    else{
        headImg.image = kImage(@"头像");
    }
    if (RankModel.nickname) {
        nameLab.text = RankModel.nickname;
    }else{
        nameLab.text = RankModel.mobile;
    }
    
    [nameLab sizeToFit];
    nameLab.frame = CGRectMake(headImg.xx + 10, 14,nameLab.width + 17, 17);
//    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(nameLab.width - 17, 0, 17, 17)];
//    img.image = kImage(@"收  取");
//    [nameLab addSubview:img];
    

    cerNumberLbl.text = [NSString stringWithFormat:@"获得了%@个环保证书",RankModel.certificateCount];
    kgLabel.text = [ NSString stringWithFormat:@"%.2f碳泡泡",[RankModel.tppAmount floatValue] / 1000];
    [kgLabel sizeToFit];
    kgLabel.frame = CGRectMake(SCREEN_WIDTH - kgLabel.width - 15 , 0, kgLabel.width, 65);
    
}
-(void)setFriendsModel:(FriendsModel *)FriendsModel{
    _FriendsModel = FriendsModel;
    if (FriendsModel.toUserInfo[@"photo"]) {
        [headImg sd_setImageWithURL: [NSURL URLWithString:[FriendsModel.toUserInfo[@"photo"] convertImageUrl]]];
    }
    else{
        headImg.image = kImage(@"头像");
    }
    if (FriendsModel.toUserInfo[@"nickname"]) {
        nameLab.text = FriendsModel.toUserInfo[@"nickname"];
//        [nameLab setTitle:FriendsModel.toUserInfo[@"nickname"] forState:(UIControlStateNormal)];
    }else{
        nameLab.text = [FriendsModel.toUserInfo[@"loginName"] stringByReplacingOccurrencesOfString:[FriendsModel.toUserInfo[@"loginName"] substringWithRange:NSMakeRange(3,4)] withString:@" **** "];
//        [nameBtn setTitle:[FriendsModel.toUserInfo[@"loginName"] stringByReplacingOccurrencesOfString:[FriendsModel.toUserInfo[@"loginName"] substringWithRange:NSMakeRange(3,4)] withString:@" **** "] forState:(UIControlStateNormal)];
    }
    
    [nameLab sizeToFit];
    nameLab.frame = CGRectMake(headImg.xx + 10, 14,nameLab.width + 17, 17);
//    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(nameLab.width - 17, 0, 17, 17)];
//    img.image = kImage(@"收  取");
//    [nameLab addSubview:img];
    
    cerNumberLbl.text = [NSString stringWithFormat:@"获得了%@个环保证书",FriendsModel.certificateCount];
    kgLabel.text = [ NSString stringWithFormat:@"%.2f碳泡泡",[FriendsModel.tppAmount floatValue] / 1000];
    [kgLabel sizeToFit];
    kgLabel.frame = CGRectMake(SCREEN_WIDTH - kgLabel.width - 15 , 0, kgLabel.width, 65);
}
@end
