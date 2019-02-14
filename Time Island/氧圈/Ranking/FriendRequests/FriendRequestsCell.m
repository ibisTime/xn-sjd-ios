//
//  FriendRequestsCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "FriendRequestsCell.h"

@implementation FriendRequestsCell{
    UIImageView *headImg;
    UILabel *nameLbl;
    UILabel *cerNumberLbl;
    
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        headImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 20, 40, 40)];
        headImg.layer.cornerRadius = 20;
        headImg.layer.masksToBounds = YES;

        [self addSubview:headImg];
        
    
        
       nameLbl = [UILabel labelWithFrame:CGRectMake(headImg.xx + 10, 23.5, SCREEN_WIDTH - headImg.xx - 10 - 70, 17) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kTextBlack];

        [self addSubview:nameLbl];
        
        cerNumberLbl = [UILabel labelWithFrame:CGRectMake(headImg.xx + 7, nameLbl.yy + 7 - 1.5, SCREEN_WIDTH - headImg.xx - 10 - 70, 13) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#999999")];
        cerNumberLbl.text = @"获得了7个环保证书";
        [self addSubview:cerNumberLbl];
        
        self.RefusedBtn =[UIButton buttonWithTitle:@"拒绝" titleColor:kHexColor(@"#999999") backgroundColor:kClearColor titleFont:12];
        self.RefusedBtn.frame = CGRectMake(SCREEN_WIDTH - 146, 27, 58, 26);
        kViewBorderRadius(self.RefusedBtn, 2, 1, kHexColor(@"#999999"));
        [self.RefusedBtn addTarget:self action:@selector(refuse) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.RefusedBtn];
        
        
        self.agreeBtn =[UIButton buttonWithTitle:@"同意" titleColor:kHexColor(@"#23AD8C") backgroundColor:kClearColor titleFont:12];
        self.agreeBtn.frame = CGRectMake(self.RefusedBtn.xx + 15, 27, 58, 26);
        kViewBorderRadius(self.agreeBtn, 2, 1, kHexColor(@"#23AD8C"));
        [self.agreeBtn addTarget:self action:@selector(agree) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.agreeBtn];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 79, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
        
        self.stateLbl = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 73, 27, 58, 26) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
        [self addSubview:self.stateLbl];
        [self.stateLbl setHidden:YES];
        
        
    }
    return self;
}
-(void)agree{
    NSLog(@"%s",__func__);
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"805152";
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"approveResult"] = @(1);
    http.parameters[@"code"] = self.FriendsModel.code;
    [http postWithSuccess:^(id responseObject) {
        self.stateLbl.text = @"已通过";
        [self.stateLbl setHidden:NO];
        [self.RefusedBtn setHidden:YES];
        [self.agreeBtn setHidden:YES];
    } failure:^(NSError *error) {
    }];
}
-(void)refuse{
    NSLog(@"%s",__func__);
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"805152";
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"approveResult"] = @(0);
    http.parameters[@"code"] = self.FriendsModel.code;
    [http postWithSuccess:^(id responseObject) {
        self.stateLbl.text = @"已拒绝";
        [self.stateLbl setHidden:NO];
        [self.RefusedBtn setHidden:YES];
        [self.agreeBtn setHidden:YES];
    } failure:^(NSError *error) {
    }];
}

-(void)setFriendsModel:(FriendsModel *)FriendsModel{
    _FriendsModel = FriendsModel;
    if (FriendsModel.fromUserInfo[@"photo"]) {
        [headImg sd_setImageWithURL:[NSURL URLWithString:[FriendsModel.fromUserInfo[@"photo"] convertImageUrl]] placeholderImage:kImage(@"头像")];
    }
    else{
        headImg.image = kImage(@"头像");
    }
    
    if (FriendsModel.fromUserInfo[@"nickname"]){
        nameLbl.text = FriendsModel.fromUserInfo[@"nickname"];
    }
    else{
        nameLbl.text = [FriendsModel.fromUserInfo[@"loginName"] stringByReplacingOccurrencesOfString:[FriendsModel.fromUserInfo[@"loginName"] substringWithRange:NSMakeRange(3,4)] withString:@" **** "];
    }
    
    cerNumberLbl.text = [NSString stringWithFormat:@"获得了%@个环保证书",FriendsModel.fromUserInfo[@"certificateCount"]];
    
    if ([FriendsModel.status isEqualToString:@"1"]) {
        self.stateLbl.text = @"已通过";
        [self.stateLbl setHidden:NO];
        [self.RefusedBtn setHidden:YES];
        [self.agreeBtn setHidden:YES];
    }
    
    if ([FriendsModel.status isEqualToString:@"2"]) {
        self.stateLbl.text = @"已拒绝";
        [self.stateLbl setHidden:NO];
        [self.RefusedBtn setHidden:YES];
        [self.agreeBtn setHidden:YES];
    }
}

@end
