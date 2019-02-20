//
//  BookCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BookCell.h"

@implementation BookCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *image = [[UIImageView alloc] init];
        image.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:image];
        image.frame = CGRectMake(15, 15, 100, 85);
        image.layer.cornerRadius = 3;
        image.clipsToBounds = YES;
        self.iconImage = image;
        image.image = kImage(@"baner1");
        
        UILabel *moreLab = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(0, 0, 0) font:15];
        moreLab.frame = CGRectMake(image.xx+10, 17.5, kScreenWidth-120, 22);
        moreLab.textAlignment = NSTextAlignmentLeft;
        moreLab.text = @"从小苗长到大树，其实挺好的";
        self.moreLab = moreLab;
        [self.contentView addSubview:moreLab];
        
//        UILabel *detailLab = [UILabel labelWithBackgroundColor:kLineColor textColor:kBlackColor font:13];
        UILabel *detailLab = [[UILabel alloc]init];
        detailLab.frame = CGRectMake(image.xx+20, moreLab.yy+10, 100, 24);
        detailLab.textAlignment = NSTextAlignmentLeft;
//        detailLab.text = @"作者: 威震天";
        self.detailLab = detailLab;
        [self.contentView addSubview:detailLab];

        UILabel *moneyLab = [UILabel labelWithBackgroundColor:kLineColor textColor:kBlackColor font:13];
//        UILabel *moneyLab = [[UILabel alloc]init];
        moneyLab.frame = CGRectMake(image.xx+10, moreLab.yy+10, 120, 24);
        moneyLab.textAlignment = NSTextAlignmentLeft;
//        moneyLab.text = @"关联古树: 爱心树";
        self.moneyLab = moneyLab;
        [self.contentView addSubview:moneyLab];
        
        UILabel * statelab = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 48, moreLab.yy + 10, 48, 24) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:[UIColor redColor]];
        self.statelab = statelab;
        [self.contentView addSubview:statelab];
        
        UILabel *timeLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:13];
        timeLab.frame = CGRectMake(image.xx+10, moreLab.yy+47.5, 90, 24);
        timeLab.textAlignment = NSTextAlignmentLeft;
        timeLab.text = @"2018.01.11";
        timeLab.yy = image.yy;
        self.timeLab = timeLab;
        [self.contentView addSubview:timeLab];
        
        
        UILabel *collectLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:11];
//        collectLab.frame = CGRectMake(detailLab.xx+10, detailLab.yy+10, 60, 24);
        collectLab.frame = CGRectMake(SCREEN_WIDTH - 60 - 15 - 60, detailLab.yy+10, 60, 24);
        collectLab.textAlignment = NSTextAlignmentRight;
        collectLab.text = @"收藏 100";
        collectLab.yy = image.yy;
        self.collectLab = collectLab;
        [self.contentView addSubview:collectLab];
        
        UILabel *praiseLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:11];
//        praiseLab.frame = CGRectMake(collectLab.xx, detailLab.yy+10, 60, 24);
        praiseLab.frame = CGRectMake(SCREEN_WIDTH - 60 - 15, detailLab.yy+10, 60, 24);
        praiseLab.textAlignment = NSTextAlignmentRight;
        praiseLab.text = @"赞 100";
        praiseLab.yy = image.yy;
        self.praiseLab = praiseLab;
        [self.contentView addSubview:praiseLab];
        
        UIView *line = [UIView new];
        line.frame = CGRectMake(0, image.yy+10, kScreenWidth, 1);
        line.backgroundColor = RGB(244, 244, 244);
        [self.contentView addSubview:line];
    }
    return self;
}


-(void)setBookModel:(BookModel *)BookModel{
    
    if (self.state == 1) {
        NSArray *imgs = [BookModel.photo componentsSeparatedByString:@"||"];
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[imgs[0] convertImageUrl]]];
        self.moreLab.text = BookModel.title;
        NSString * timestr =[BookModel.publishDatetime convertToDetailDate];
        self.timeLab.text = [timestr substringToIndex:10];
        
        self.collectLab.text = [NSString stringWithFormat:@"收藏 %@",BookModel.collectCount];
        self.praiseLab.text = [NSString stringWithFormat:@"赞 %@",BookModel.pointCount];
        self.moneyLab.text = [NSString stringWithFormat:@"关联古树 :%@",BookModel.treeName];
        
        if ([BookModel.status isEqualToString:@"2"]) {
            self.statelab.text = @"待审核";
        }
        else if ([BookModel.status isEqualToString:@"4"]){
            self.statelab.text = @"待上架";
        }
    }
    else{
        NSArray * imgs = [BookModel.article[@"photo"] componentsSeparatedByString:@"||"];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[imgs[0] convertImageUrl]]];
    self.moreLab.text = BookModel.article[@"title"];
    NSString * timestr =[BookModel.article[@"publishDatetime"] convertToDetailDate];
    self.timeLab.text = [timestr substringToIndex:10];
        [self.moneyLab setHidden:YES];
    self.collectLab.text = [NSString stringWithFormat:@"收藏 %@",BookModel.article[@"collectCount"]];
    self.praiseLab.text = [NSString stringWithFormat:@"赞 %@",BookModel.article[@"pointCount"]];
    }
    
}
@end
