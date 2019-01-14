//
//  FriendRequestsCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "FriendRequestsCell.h"

@implementation FriendRequestsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 20, 40, 40)];
        headImg.image = kImage(@"头像");
        [self addSubview:headImg];
        
    
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(headImg.xx + 10, 23.5, SCREEN_WIDTH - headImg.xx - 10 - 70, 17) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kTextBlack];
        nameLbl.text = @"庭院深深";
        [self addSubview:nameLbl];
        
        UILabel *cerNumberLbl = [UILabel labelWithFrame:CGRectMake(headImg.xx + 7, nameLbl.yy + 7 - 1.5, SCREEN_WIDTH - headImg.xx - 10 - 70, 13) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#999999")];
        cerNumberLbl.text = @"获得了7个环保证书";
        [self addSubview:cerNumberLbl];
        
        UIButton *RefusedBtn =[UIButton buttonWithTitle:@"拒绝" titleColor:kHexColor(@"#999999") backgroundColor:kClearColor titleFont:12];
        RefusedBtn.frame = CGRectMake(SCREEN_WIDTH - 146, 27, 58, 26);
        kViewBorderRadius(RefusedBtn, 2, 1, kHexColor(@"#999999"));
        [self addSubview:RefusedBtn];
        
        
        UIButton *agreeBtn =[UIButton buttonWithTitle:@"同意" titleColor:kHexColor(@"#23AD8C") backgroundColor:kClearColor titleFont:12];
        agreeBtn.frame = CGRectMake(RefusedBtn.xx + 15, 27, 58, 26);
        kViewBorderRadius(agreeBtn, 2, 1, kHexColor(@"#23AD8C"));
        [self addSubview:agreeBtn];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 79, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
//        UILabel *stateLbl = [UILabel label]
        
        
    }
    return self;
}

@end
