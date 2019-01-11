//
//  MyArticleCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MyArticleCell.h"

@implementation MyArticleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 100, 85)];
        
        headImg.image = kImage(@"树 跟背景");
        [self addSubview:headImg];
        
        
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(headImg.xx + 10, 17, SCREEN_WIDTH - headImg.xx - 20, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(15) textColor:kHexColor(@"#333333")];
        nameLabel.numberOfLines = 3;
        nameLabel.text = @"从小苗长到大树，其实挺好的";
        [nameLabel sizeToFit];
        [self addSubview:nameLabel];
        
        UILabel *praiseLbl = [UILabel labelWithFrame:CGRectMake(0, headImg.yy - 16.5, 0, 16.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(11) textColor:kHexColor(@"#999999")];
        praiseLbl.text = @"赞 280";
        [praiseLbl sizeToFit];
        praiseLbl.frame = CGRectMake(SCREEN_WIDTH - praiseLbl.width - 15, headImg.yy - 16.5, praiseLbl.width, 16.5);
        [self addSubview:praiseLbl];
        
        
        UILabel *collectionLbl = [UILabel labelWithFrame:CGRectMake(0, headImg.yy - 16.5, 0, 16.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(11) textColor:kHexColor(@"#999999")];
        collectionLbl.text = @"收藏 28000";
        [collectionLbl sizeToFit];
        collectionLbl.frame = CGRectMake(SCREEN_WIDTH - collectionLbl.width - praiseLbl.width - 15 - 15, headImg.yy - 16.5, collectionLbl.width, 16.5);
        [self addSubview:collectionLbl];
        
        
        UILabel *timeLabel = [UILabel labelWithFrame:CGRectMake(125, headImg.yy - 16.5, SCREEN_WIDTH - headImg.xx - praiseLbl.width - collectionLbl.width - 45, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
        timeLabel.text = @"2018.01.11";
        [self addSubview:timeLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 114, SCREEN_WIDTH - 30, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
        
    }
    return self;
}

@end
