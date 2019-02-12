//
//  MineRankCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/11.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MineRankCell.h"

@implementation MineRankCell{
    UIImageView *headImg;
    UIButton *nameBtn;
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
        
        
        nameBtn = [UIButton buttonWithTitle:@"庭院深深" titleColor:kTextBlack backgroundColor:kClearColor titleFont:14];
        
        nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        nameBtn.frame = CGRectMake(headImg.xx + 10, 14, SCREEN_WIDTH - headImg.xx - 10 - 70, 17);
        //        [nameBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:6 imagePositionBlock:^(UIButton *button) {
        //            [button setImage:kImage(@"收  取") forState:(UIControlStateNormal)];
        //        }];
        
        [self addSubview:nameBtn];
        
        cerNumberLbl = [UILabel labelWithFrame:CGRectMake(headImg.xx + 10, nameBtn.yy + 7 - 1.5, SCREEN_WIDTH - headImg.xx - 10 - 70, 13) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#999999")];
        cerNumberLbl.text = @"获得了7个环保证书";
        [self addSubview:cerNumberLbl];
        
        kgLabel = [UILabel labelWithFrame:CGRectMake(nameBtn.xx + 5 , 0, SCREEN_WIDTH - nameBtn.xx - 5 - 15, 65) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(14) textColor:kTextBlack];
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
    _numberLbl.text = RankModel.rowNo;
    if (RankModel.photo) {
        [headImg sd_setImageWithURL: [NSURL URLWithString:[RankModel.photo convertImageUrl]]];
    }
    else{
        headImg.image = kImage(@"头像");
    }
    if (RankModel.nickname) {
        [nameBtn setTitle:RankModel.nickname forState:(UIControlStateNormal)];
    }else{
        [nameBtn setTitle:RankModel.mobile forState:(UIControlStateNormal)];
    }
    
    [nameBtn.titleLabel sizeToFit];
    nameBtn.frame = CGRectMake(headImg.xx + 10, 14,nameBtn.width, 17);
    [nameBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:6 imagePositionBlock:^(UIButton *button) {
        [button setImage:kImage(@"收  取") forState:(UIControlStateNormal)];
    }];
    
    
    cerNumberLbl.text = [NSString stringWithFormat:@"获得了%@个环保证书",RankModel.certificateCount];
    kgLabel.text = [ NSString stringWithFormat:@"%.2fKG碳泡泡",[RankModel.tppAmount floatValue] / 1000];
    [kgLabel sizeToFit];
    kgLabel.frame = CGRectMake(SCREEN_WIDTH - kgLabel.width - 15 , 0, kgLabel.width, 65);
    
}
@end

