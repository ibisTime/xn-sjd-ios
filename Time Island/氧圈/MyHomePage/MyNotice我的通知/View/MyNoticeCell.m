//
//  MyNoticeCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/15.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MyNoticeCell.h"

@implementation MyNoticeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 100 - 30-100, 22.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kTextBlack];
//        nameLbl.text = @"千岛湖时间岛";
        nameLbl.text = self.titleString;
        [self addSubview:nameLbl];
        self.nameLbl = nameLbl;
        
        UILabel *timeLbl = [UILabel labelWithFrame:CGRectMake(nameLbl.xx + 10, 15, SCREEN_WIDTH - nameLbl.xx - 10 - 15 , 22.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
//        timeLbl.text = @"2018.01.11";
        [self addSubview:timeLbl];
        self.timeLbl = timeLbl;
        
        
        UILabel *contactLbl = [UILabel labelWithFrame:CGRectMake(15,nameLbl.yy + 11, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#999999")];
//        contactLbl.text = @"千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字千岛湖时间岛辅助文字辅助文字";
        [self addSubview:contactLbl];
        self.contactLbl = contactLbl;
        
        
        
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 167/2 - 1, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
    }
    return self;
}
-(void)setTimeString:(NSString *)TimeString{
     self.timeLbl.text = TimeString;
}
-(void)setTitleString:(NSString *)titleString{
    self.nameLbl.text = titleString;
}
-(void)setContentString:(NSString *)ContentString{
    self.contactLbl.text = ContentString;
}
@end
